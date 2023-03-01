library(data.table)
library(rethinking)

d <- fread("./data/wastewater_20220601.csv")

dens(d$confirmed_cases)
# d$confirmed_cases_imputed <- ifelse(d$confirmed_cases == 0, 1, d$confirmed_cases)
# d$confirmed_cases_imputed
d$sars_cov_2_virus
log10(d$sars_cov_2_virus)
dens(d$sars_cov_2_virus)

dens(log10(d$sars_cov_2_virus))



dens(d$confirmed_cases_imputed)
dens(log10(d$confirmed_cases_imputed))

rbinom(n = 1, size = 1000, prob = 0.5)
dens(rbinom(n = 1e4, size = 1000, prob = 0.5), adj = 0.1)

dens(rgamma(1e4, shape = 200, rate = 2))

dens(rpois(1e4, 500), adj = 0.1)

sim_cases <- function(population, virus_log10) {
  p <- 
  C <- rbinom(1, size = population, prob = p)
  return(C)
}


dat <- list(C = d$confirmed_cases, V = log10(d$sars_cov_2_virus))
m1 <- ulam(
  alist(
    C ~ dpois(lambda),
    lambda <- a + b * V, # should be integer
    a ~ dnorm(0, 10),
    b ~ dnorm(0, 10)
  ), data = dat, chains = 4, cores = 4
)

precis(m1)

m2 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + b * V, 
    a ~ dnorm(0, 1.5), 
    b ~ dnorm(0, 1.5)
  ), data = dat, chains = 4, cores = 4
)

precis(m2)
post <- extract.samples(m2)

post_sim <- sim(m2, V = log10(d$sars_cov_2_virus))

plot(NULL, xlim = c(0, 111), ylim = c(0, 1000))
for (i in 1:20) {
  lines(1:111, post_sim[i, ], lty = 1, col = "gray")
}

lines(d$confirmed_cases, col = 4, lwd = 4)
# V_standardized_positive <- (d$sars_cov_2_virus - 0) / sd(d$sars_cov_2_virus)
# lines(V_standardized_positive * 200, col = 2, lwd = 2)
lines(log(d$sars_cov_2_virus)*10, col = 2, lwd = 2)




# Lag 10 ------------------------------------------------------------------

dat5 <- list(C = d_lag10$c, V1 = d_lag10$v_lag1, V2 = d_lag10$v_lag2, V3 = d_lag10$v_lag3, V4 = d_lag10$v_lag4, V5 = d_lag10$v_lag5, V6 = d_lag10$v_lag6, V7 = d_lag10$v_lag7, V8 = d_lag10$v_lag8, V9 = d_lag10$v_lag9, V10 = d_lag10$v_lag10)
m5 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bV6 * V6 + bV7 * V7 + bV8 * V8 + bV9 * V9 + bV10 * V10,
    a ~ dnorm(0, 1.5), 
    bV1 ~ dnorm(0, 1.5), 
    bV2 ~ dnorm(0, 1.5), 
    bV3 ~ dnorm(0, 1.5), 
    bV4 ~ dnorm(0, 1.5), 
    bV5 ~ dnorm(0, 1.5), 
    bV6 ~ dnorm(0, 1.5),
    bV7 ~ dnorm(0, 1.5),
    bV8 ~ dnorm(0, 1.5),
    bV9 ~ dnorm(0, 1.5),
    bV10 ~ dnorm(0, 1.5)
  ), data = dat5, chains = 4, cores = 4, log_lik = TRUE
)

dat5 <- list(C = d_lag10$c, DH1 = d_lag10$dh_lag1, DH2 = d_lag10$dh_lag2, DH3 = d_lag10$dh_lag3, DH4 = d_lag10$dh_lag4, DH5 = d_lag10$dh_lag5, DH6 = d_lag10$dh_lag6, DH7 = d_lag10$dh_lag7, DH8 = d_lag10$dh_lag8, DH9 = d_lag10$dh_lag9, DH10 = d_lag10$dh_lag10)
m5.dh <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bDH4 * DH4 + bDH5 * DH5 + bDH6 * DH6 + bDH7 * DH7 + bDH8 * DH8 + bDH9 * DH9 + bDH10 * DH10,
    a ~ dnorm(0, 1.5), 
    bDH1 ~ dnorm(0, 1.5), 
    bDH2 ~ dnorm(0, 1.5), 
    bDH3 ~ dnorm(0, 1.5), 
    bDH4 ~ dnorm(0, 1.5), 
    bDH5 ~ dnorm(0, 1.5), 
    bDH6 ~ dnorm(0, 1.5),
    bDH7 ~ dnorm(0, 1.5),
    bDH8 ~ dnorm(0, 1.5),
    bDH9 ~ dnorm(0, 1.5),
    bDH10 ~ dnorm(0, 1.5)
  ), data = dat5, chains = 4, cores = 4, log_lik = TRUE
)

dat5 <- list(C = d_lag10$c, A1 = d_lag10$a_lag1, A2 = d_lag10$a_lag2, A3 = d_lag10$a_lag3, A4 = d_lag10$a_lag4, A5 = d_lag10$a_lag5, A6 = d_lag10$a_lag6, A7 = d_lag10$a_lag7, A8 = d_lag10$a_lag8, A9 = d_lag10$a_lag9, A10 = d_lag10$a_lag10)
m5.a <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bA1 * A1 + bA2 * A2 + bA3 * A3 + bA4 * A4 + bA5 * A5 + bA6 * A6 + bA7 * A7 + bA8 * A8 + bA9 * A9 + bA10 * A10,
    a ~ dnorm(0, 1.5), 
    bA1 ~ dnorm(0, 1.5), 
    bA2 ~ dnorm(0, 1.5), 
    bA3 ~ dnorm(0, 1.5), 
    bA4 ~ dnorm(0, 1.5), 
    bA5 ~ dnorm(0, 1.5), 
    bA6 ~ dnorm(0, 1.5),
    bA7 ~ dnorm(0, 1.5),
    bA8 ~ dnorm(0, 1.5),
    bA9 ~ dnorm(0, 1.5),
    bA10 ~ dnorm(0, 1.5)
  ), data = dat5, chains = 4, cores = 4, log_lik = TRUE
)

compare(m5, m5.dh, m5.a, func = WAIC)
compare(m5, m5.dh, m5.a, func = PSIS)


# Lag 5 -------------------------------------------------------------------
dat3 <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, DH1 = d_lag5$dh_lag1, DH2 = d_lag5$dh_lag2, DH3 = d_lag5$dh_lag3, DH4 = d_lag5$dh_lag4, DH5 = d_lag5$dh_lag5)
m3 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bDH4 * DH4 + bDH5 * DH5,
    # logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5, 
    a ~ dnorm(0, 1.5), 
    bV1 ~ dnorm(0, 1.5), 
    bV2 ~ dnorm(0, 1.5), 
    bV3 ~ dnorm(0, 1.5), 
    bV4 ~ dnorm(0, 1.5), 
    bV5 ~ dnorm(0, 1.5), 
    bDH1 ~ dnorm(0, 1.5),
    bDH2 ~ dnorm(0, 1.5),
    bDH3 ~ dnorm(0, 1.5),
    bDH4 ~ dnorm(0, 1.5),
    bDH5 ~ dnorm(0, 1.5)
  ), data = dat3, chains = 4, cores = 4, log_lik = TRUE
)

dat3.1 <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, A1 = d_lag5$a_lag1, A2 = d_lag5$a_lag2, A3 = d_lag5$a_lag3, A4 = d_lag5$a_lag4, A5 = d_lag5$a_lag5)
m3.1 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bA1 * A1 + bA2 * A2 + bA3 * A3 + bA4 * A4 + bA5 * A5,
    # logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5, 
    a ~ dnorm(0, 1.5), 
    bV1 ~ dnorm(0, 1.5), 
    bV2 ~ dnorm(0, 1.5), 
    bV3 ~ dnorm(0, 1.5), 
    bV4 ~ dnorm(0, 1.5), 
    bV5 ~ dnorm(0, 1.5), 
    bA1 ~ dnorm(0, 1.5),
    bA2 ~ dnorm(0, 1.5),
    bA3 ~ dnorm(0, 1.5),
    bA4 ~ dnorm(0, 1.5),
    bA5 ~ dnorm(0, 1.5)
  ), data = dat3.1, chains = 4, cores = 4, log_lik = TRUE
)


dat3.2 <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, P1 = d_lag5$p_lag1, P2 = d_lag5$p_lag2, P3 = d_lag5$p_lag3, P4 = d_lag5$p_lag4, P5 = d_lag5$p_lag5)
m3.2 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bP1 * P1 + bP2 * P2 + bP3 * P3 + bP4 * P4 + bP5 * P5,
    # logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5, 
    a ~ dnorm(0, 1.5), 
    bV1 ~ dnorm(0, 1.5), 
    bV2 ~ dnorm(0, 1.5), 
    bV3 ~ dnorm(0, 1.5), 
    bV4 ~ dnorm(0, 1.5), 
    bV5 ~ dnorm(0, 1.5), 
    bP1 ~ dnorm(0, 1.5),
    bP2 ~ dnorm(0, 1.5),
    bP3 ~ dnorm(0, 1.5),
    bP4 ~ dnorm(0, 1.5),
    bP5 ~ dnorm(0, 1.5)
  ), data = dat3.2, chains = 4, cores = 4, log_lik = TRUE
)

dat3.3 <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, N1 = d_lag5$n_lag1, N2 = d_lag5$n_lag2, N3 = d_lag5$n_lag3, N4 = d_lag5$n_lag4, N5 = d_lag5$n_lag5)
m3.3 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bN1 * N1 + bN2 * N2 + bN3 * N3 + bN4 * N4 + bN5 * N5,
    # logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5, 
    a ~ dnorm(0, 1.5), 
    bV1 ~ dnorm(0, 1.5), 
    bV2 ~ dnorm(0, 1.5), 
    bV3 ~ dnorm(0, 1.5), 
    bV4 ~ dnorm(0, 1.5), 
    bV5 ~ dnorm(0, 1.5), 
    bN1 ~ dnorm(0, 1.5),
    bN2 ~ dnorm(0, 1.5),
    bN3 ~ dnorm(0, 1.5),
    bN4 ~ dnorm(0, 1.5),
    bN5 ~ dnorm(0, 1.5)
  ), data = dat3.3, chains = 4, cores = 4, log_lik = TRUE
)

compare(m3, m3.1, m3.2, m3.3, func = WAIC)
compare(m3, m3.1, m3.2, m3.3, func = PSIS)




# Lag 3 -------------------------------------------------------------------

dat4 <- list(C = d_lag3$c, C1 = d_lag3$c_lag1, C2 = d_lag3$c_lag2, C3 = d_lag3$c_lag3, V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, DH1 = d_lag3$dh_lag1, DH2 = d_lag3$dh_lag2, DH3 = d_lag3$dh_lag3, N1 = d_lag3$n_lag1, N2 = d_lag3$n_lag2, N3 = d_lag3$n_lag3)
m4 <- ulam(
  alist(
    C ~ binomial(1e4, p), 
    # logit(p) <- a + bC1 * C1 + bC2 * C2 + bC3 * C3 + bV1 * V1 + bV2 * V2 + bV3 * V3 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3, 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bN1 * N1 + bN2 * N2 + bN3 * N3,
    # logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3, 
    # logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3,
    a ~ dnorm(0, 1.5), 
    # bC1 ~ dnorm(0, 1.5), 
    # bC2 ~ dnorm(0, 1.5), 
    # bC3 ~ dnorm(0, 1.5), 
    bV1 ~ dnorm(0, 1.5), 
    bV2 ~ dnorm(0, 1.5), 
    bV3 ~ dnorm(0, 1.5), 
    bDH1 ~ dnorm(0, 1.5),
    bDH2 ~ dnorm(0, 1.5),
    bDH3 ~ dnorm(0, 1.5),
    bN1 ~ dnorm(0, 1.5),
    bN2 ~ dnorm(0, 1.5),
    bN3 ~ dnorm(0, 1.5)
  ), data = dat4, chains = 4, cores = 4, log_lik = TRUE
)

WAIC(m4)
PSIS(m4)


# Model with only one lag
m5 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1, 
    # a ~ dnorm(0, 1.5), 
    a ~ dunif(-10, 10), 
    # bV1 ~ dnorm(0, 10), 
    bV1 ~ dunif(-10, 10)
    # bDH1 ~ dnorm(0, 1.5)
  ), data = dat3, chains = 4, cores = 4, log_lik = TRUE
)


# Model with log zero
dat6 <- list(C = c, V = v, A = a, N = n, P = p, H = h, DH = dh)
m6 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV * V + bA * A + bDH * DH,
    a ~ dnorm(0, 1.5), 
    bV ~ dnorm(0, 1.5), ç
    bA ~ dnorm(0, 1.5), 
    # bN ~ dnorm(0, 1.5), 
    # bP ~ dnorm(0, 1.5), 
    # bH ~ dnorm(0, 1.5), 
    bDH ~ dnorm(0, 1.5)
  ), data = dat6, chains = 4, cores = 4, log_lik=TRUE
)

precis(m6)
post_sim6 <- sim(m6, V = v, A = a, N = n, P = p, H = h, DH = dh, n = 1e4)
post_sim6 <- sim(m6, V = v, A = a, DH = dh, n = 1e4)
plot(NULL, xlim = c(0, 111), ylim = c(0, 1000))
for (i in 1:50) {
  lines(1:(111), post_sim6[i, ], lty = 1, col = "gray")
}

lines(d$confirmed_cases[1:111], col = 4, lwd = 2)
PI_sim <- apply(post_sim6, 2, PI)
lines(PI_sim[1, ], lty = 2)
lines(PI_sim[2, ], lty = 2)

WAIC(m6)


prior <- extract.prior(m5, n = 1e4)

p <- sapply(1:length(dat3$V1), function(i) inv_logit(prior$a + prior$bV1 * dat3$V1[i]))

dens(p, adj = 0.1)

plot(NULL, xlim = c(0, 106), ylim = c(0, 1e4))
for (i in 1:106) {
  points(x = i, y = rbinom(n = 1, size = 3.3e5, prob = p[1,i]), add = TRUE)
}


precis(m4)

post_sim <- sim(m3, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, DH1 = d_lag5$dh_lag1, DH2 = d_lag5$dh_lag2, DH3 = d_lag5$dh_lag3, DH4 = d_lag5$dh_lag4, DH5 = d_lag5$dh_lag5, n = 1e4)
post_sim <- sim(m3.3, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, N1 = d_lag5$n_lag1, N2 = d_lag5$n_lag2, N3 = d_lag5$n_lag3, N4 = d_lag5$n_lag4, N5 = d_lag5$n_lag5, n = 1e4)
post_sim <- sim(m3, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, n = 1e4)

post_sim <- sim(m4, V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, DH1 = d_lag3$dh_lag1, DH2 = d_lag3$dh_lag2, DH3 = d_lag3$dh_lag3, n = 1e4)
post_sim <- sim(m4, V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, n = 1e4)

post_sim <- sim(m5, V1 = d_lag10$v_lag1, V2 = d_lag10$v_lag2, V3 = d_lag10$v_lag3, V4 = d_lag10$v_lag4, V5 = d_lag10$v_lag5, V6 = d_lag10$v_lag6, V7 = d_lag10$v_lag7, V8 = d_lag10$v_lag8, V9 = d_lag10$v_lag9, V10 = d_lag10$v_lag10, n = 1e4)

plot(NULL, xlim = c(0, 111-5), ylim = c(0, 1000))
for (i in 1:50) {
  lines(1:(111-5), post_sim[i, ], lty = 1, col = "gray")
}

lines(d$confirmed_cases[6:111], col = 4, lwd = 2)

PI_sim <- apply(post_sim, 2, PI)
lines(PI_sim[1, ], lty = 2)
lines(PI_sim[2, ], lty = 2)

# V_standardized_positive <- (d$sars_cov_2_virus - 0) / sd(d$sars_cov_2_virus)
# lines(V_standardized_positive[6:111] * 200, col = 2, lwd = 1)


compare(m3, m4, func = WAIC)



curve( inv_logit(mean(post$a) + mean(post$b) * x), ylab = "Confirmed Case", xlab = "Virus Concentration", xlim = c(0, 6))


curve( rpois(1, lambda = exp(mean(post$a) + mean(post$b) * x)), ylab = "Confirmed Case", xlab = "Virus Concentration", xlim = c(0, 6))

curve( exp(mean(post$a) + mean(post$b) * x), ylab = "Confirmed Case", xlab = "Virus Concentration", xlim = c(0, 6))

points(log10(d$sars_cov_2_virus), d$confirmed_cases, col = col.alpha(2, 1))

input <- as.ts(log10(d$sars_cov_2_virus))
output <- as.ts(exp(mean(post$a) + mean(post$b) * input))
time <- as.ts(d$sampling_date)

curve( exp(mean(post$a) + mean(post$b) * input), ylab = "Confirmed Case", xlab = "Virus Concentration", xlim = c(0, 6))

plot.ts(output, type = "l", ylim = c(0, 1200))
points(d$confirmed_cases, col = 2)
lines(d$desethyl_hydroxychloroquine * 5 * 1e4, col = 4)
