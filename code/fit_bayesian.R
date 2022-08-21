library(rethinking)
library(rstan)
source("./code/load_data.R")
dens(d$acetaminophen, main = "Acetaminophen") # in gene copies/L
dens(d$confirmed_cases, main = "Confirmed Cases") # 7 days moving average
dens(d$sars_cov_2_virus, main = "Virus") # in µg/L
dens(d$sars_cov_2_virus_log)

summary(d$confirmed_cases)
summary(d$acetaminophen)
summary(d$sars_cov_2_virus_log)

plot(d$acetaminophen ~ d$sampling_date, type = "l")
plot(standardize(d$acetaminophen) ~ d$sampling_date, type = "l")
plot(d$confirmed_cases ~ d$sampling_date, type = "l")
plot(d$sars_cov_2_virus ~ d$sampling_date, type = "l")
plot(d$sars_cov_2_virus_log ~ d$sampling_date, type = "l")



# Univariate model: confirmed cases ---------------------------------------
dens(d$confirmed_cases, main = "Confirmed Cases") # 7 days moving average

precis(d$confirmed_cases)
precis(log(d$confirmed_cases))
curve(dlnorm(x, meanlog = 10, sdlog = 4), from = 0, to = 1000)



x <- rlnorm(1000, -2, 5)
plot(density(log(x)))
plot(density(x), xlim = c(0, 100))
mean(log(x))
sd(log(x))


summary(lm(d$acetaminophen ~ d$sars_cov_2_virus + d$confirmed_cases))
summary(lm(d$confirmed_cases ~ d$acetaminophen + d$sars_cov_2_virus))
summary(lm(d$confirmed_cases ~ d$sars_cov_2_virus))



sim_CVA <- function(n_steps, init, beta, dt = 0.001) {
  C <- rep(NA, n_steps)
  V <- rep(NA, n_steps)
  A <- rep(NA, n_steps)
  C[1] <- init[1]
  V[1] <- init[2]
  A[1] <- init[3]
  for (i in 2:n_steps) {
    # C[i] <- C[i-1] + dt * (beta[1] * V[i-1] - beta[2] * A[i-1])
    # A[i] <- A[i-1] + dt * C[i-1] * beta[5]
    # V[i] <- V[i-1] + dt * V[i-1] * (-beta[3] * A[i-1] - beta[4] * C[i-1])
    # A[i] <- A[i-1] + dt * A[i-1] * (beta[5] * V[i-1] + beta[6] * C[i-1])
    
    # C[i] <- C[i-1] + dt * beta[1] * A[i-1]
    # V[i] <- V[i-1] + dt * (V[i-1] * beta[2] - A[i-1] * beta[3])
    # A[i] <- A[i-1] + dt * beta[4] * V[i-1]
    V[i] <- V[i-1] + dt * V[i-1] * (beta[1] - A[i-1] * beta[2])
    A[i] <- A[i-1] + dt * A[i-1] * (V[i-1] * beta[3] - beta[4])
    C[i] <- beta[5] * V[i-1]
  }
  return(cbind(C, V, A))
}



# Simulation --------------------------------------------------------------
beta <- c(0.5, 0.5, 0.5, 0.05, 0.8)
beta <- c(1, 1, 1, 1, 0.5)
# z <- sim_CVA(1e4, cbind(d$confirmed_cases, d$sars_cov_2_virus * 1e-3, standardize(d$acetaminophen))[1,], beta)
z <- sim_CVA(1e4, cbind(c, v, a)[1,], beta)

# z <- sim_CVA(1e4, cbind(d$confirmed_cases, d$sars_cov_2_virus, standardize(d$acetaminophen))[1, ], beta)

# pdf("./figures/trend_simulated.pdf", width = 9, height = 6)
plot(z[, 1], type="l", ylim=c(min(z), max(z)+0.5), main = "CVT Model: Simulated Values Over Time", xlab = "Time", ylab = "Standardized Values") # cases
lines(z[, 2], col="red") # virus
lines(z[, 3], col=rangi2)
grid(nx = 10)
legend("topleft", legend = c("Confirmed Cases", "SARS-CoV-2 Virus", "Acetaminophen"), col = c("black", "red", "blue"), lty=1)
# dev.off()





# Statistical model -------------------------------------------------------
# Instrument Detection Limit: https://www.agilent.com/en/support/liquid-chromatography-mass-spectrometry-lc-ms/instrument-detection-limit#:~:text=Instrument%20Detection%20Limit%20(IDL)%20is%20a%20statistical%20measurement%20of%20analytical,real%20and%20not%20baseline%20noise.

data("Lynx_Hare_model")
cat(Lynx_Hare_model)

data_list <- list(
  N = nrow(d),
  measure = cbind(c, v, a)
)

# stan_code <- readChar("./code/fit_bayesian.stan", file.info("./code/fit_bayesian.stan")$size)
# cat(stan_code)

fit <- stan(file = "./code/fit_bayesian.stan", data = data_list, chains = 1, cores = 3, control = list(adapt_delta = 0.95))



# Prior Predictive Simulation ---------------------------------------------
N <- 1e4
a_p <- rexp(N, rate = 0.5)
b_v0_p <- runif(N, 0, 1)
b_a0_p <- runif(N, 0, 1)
sigma_c_prior <- rexp(N, rate = 0.5)
mu_c_prior <- log(a_p + b_v0_p * v + b_a0_p * a)
c_prior <- rlnorm(1e4, meanlog = mu_c_prior, sdlog = sigma_c_prior)
plot(c_prior, ylim=c(0, 1000))
any(c_prior == 0)
dens(d$confirmed_cases)

# ulam --------------------------------------------------------------------




fit <- ulam(
  alist(
    C ~ dlnorm( log(mu_c + 1), sigma_c ), 
    mu_c <- a + b_v0 * V + b_a0 * A + + b_v1 * V_lag1 + b_a1 * A_lag1,
    a ~ exponential(0.5), 
    b_v0 ~ uniform(0, 1), 
    b_a0 ~ uniform(0, 1), 
    b_v1 ~ uniform(0, 1), 
    b_a1 ~ uniform(0, 1), 
    sigma_c ~ exponential(0.5)
  ), data = data_ar1, chains = 4, cores = 4
)

precis(fit)
post <- extract.samples(fit)
str(post)
mu_post <- exp(post$a + post$b_v0 * v + post$b_a0 * a)
sigma_post <- post$sigma_c
dens(mu_post)

plot(data_list$C ~ d$sampling_date, type = "l", xlab = "Time", ylab = "Value", col = "red", lwd = 2, main = "COVID Confirmed Cases Predicted by \n Virus and Acetaminophen Concentration")
lines(data_list$V ~ d$sampling_date[1:111], type = "l", col = "black")
lines(data_list$A ~ d$sampling_date[1:111], type = "l", col = "orange")

mu <- link(fit)
for (s in 2:111) {
  lines(d$sampling_date[2:111], mu[s, ], col = col.alpha(rangi2, 0.2), lwd = 1)
}
grid()
