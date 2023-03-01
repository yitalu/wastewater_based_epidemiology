# This script creates predictive plots based on the ADL and DL model.



# Predict by ADL Model ----------------------------------------------------
lag_length <- 3
pred <- predict(fit_ADL, newdata = d[1:(111-lag_length+1)], interval = "confidence")

# pdf("./figures/prediction_ADL_lag3.pdf", width = 9, height = 6)

plot(pred[, 1] ~ c((lag_length):111), type = "l", xlab = "Time", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Predicted by \n Past Cases, Virus Gene Copies, and Nicotine")
lines(pred[, 2] ~ c((lag_length):111), type = "l", col = rangi2)
lines(pred[, 3] ~ c((lag_length):111), type = "l", col = rangi2)
lines(c, type = "l", col="red")
grid()
legend("topleft", legend = c("Confirmed Case", "Predicted Case", "Confidence Interval"), col = c("red", "black", rangi2), lty=1)

# dev.off()

# lines(fit$fitted.values, type = "l", col="orange")
# lines(a, type = "l", col="green")



# Predict by DL Model -----------------------------------------------------
lag_length <- 5
pred <- predict(fit_DL, newdata = d[1:(111-lag_length)], interval = "confidence")

# pdf("./figures/prediction_DL_lag5.pdf", width = 9, height = 6)

plot(pred[, 1] ~ c((lag_length+1):111), type = "l", xlab = "Time", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Predicted by \n Virus Gene Copies and Desethyl Hydroxychloroquine")
lines(pred[, 2] ~ c((lag_length+1):111), type = "l", col = rangi2)
lines(pred[, 3] ~ c((lag_length+1):111), type = "l", col = rangi2)
lines(c, type = "l", col="red")
grid()
legend("topleft", legend = c("Confirmed Case", "Predicted Case", "Confidence Interval"), col = c("red", "black", rangi2), lty=1)

# dev.off()



# Bayesian Predictive Plots -----------------------------------------------
library(brms)

lag_length <- 3
m1 <- brm(formula = c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3, iter = 4000)

lag_length <- 5
m2 <- brm(formula = c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5, iter = 4000)

summary(m1)
plot(m1)

prior_summary(m1)
pp_check(m1, type = "stat", stat = "mean")

pp_check(m1, prefix = "ppd")
pp_check(m1, ndraws = 50)
pp_check(m1, type = "xyz", )
pp_check(m1, type = "ribbon", ndraws = 10)


summary(m2)
plot(m2)

prior_summary(m2)
pp_check(m2, type = "stat", stat = "mean")

pp_check(m2, prefix = "ppd")
pp_check(m2, ndraws = 50)
pp_check(m2, type = "xyz", )
pp_check(m2, type = "ribbon", ndraws = 100)


fit1 <- ulam(
  alist(
    C ~ dlnorm( log(mu_c + 1), sigma_c ), 
    # mu_c <- a + b_v0 * V + b_a0 * A + + b_v1 * V_lag1 + b_a1 * A_lag1,
    mu_c <- a + b_c1 * c_lag1 + b_c2 * c_lag2 + b_c3 * c_lag3 + b_v1 * v_lag1 + b_v2 * v_lag2 + b_v3 * v_lag3 + b_n1 * n_lag1 + b_n2 * n_lag2 + b_n3 * n_lag3,
    a ~ exponential(0.5), 
    b_c1 ~ uniform(-1, 1), 
    b_c2 ~ uniform(-1, 1), 
    b_c3 ~ uniform(-1, 1), 
    b_v1 ~ uniform(-1, 1), 
    b_v2 ~ uniform(-1, 1), 
    b_v3 ~ uniform(-1, 1), 
    b_n1 ~ uniform(-1, 1), 
    b_n2 ~ uniform(-1, 1), 
    b_n3 ~ uniform(-1, 1), 
    sigma_c ~ exponential(0.5)
  ), data = d_lag3, chains = 4, cores = 4
)

precis(fit1)
post <- extract.samples(fit1)
str(post)
mu_post <- exp(post$a + post$b_v0 * v + post$b_a0 * a)
mu_post <- exp(post$a + post$b_c1 * c_lag1 + post$b_c2 * c_lag2 + post$b_c3 * c_lag3 + post$b_v1 * v_lag1 + post$b_v2 * v_lag2 + post$b_v3 * v_lag3 + post$b_n1 * n_lag1 + post$b_n2 * n_lag2 + post$b_n3 * n_lag3 + 1)
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

