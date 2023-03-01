rm(list = ls())
source(file = "./code/01_load_data.R")
source(file = "./code/04_lag_variables.R")



# One Predictor, Lag 10 ---------------------------------------------------

# . virus -----------------------------------------------------------------
dat <- list(C = d_lag10$c, V1 = d_lag10$v_lag1, V2 = d_lag10$v_lag2, V3 = d_lag10$v_lag3, V4 = d_lag10$v_lag4, V5 = d_lag10$v_lag5, V6 = d_lag10$v_lag6, V7 = d_lag10$v_lag7, V8 = d_lag10$v_lag8, V9 = d_lag10$v_lag9, V10 = d_lag10$v_lag10)
m.v10 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bV6 * V6 + bV7 * V7 + bV8 * V8 + bV9 * V9 + bV10 * V10, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bV4 ~ dnorm(0.5, 0.5), 
    bV5 ~ dnorm(0.5, 0.5), 
    bV6 ~ dnorm(0.5, 0.5), 
    bV7 ~ dnorm(0.5, 0.5), 
    bV8 ~ dnorm(0.5, 0.5), 
    bV9 ~ dnorm(0.5, 0.5), 
    bV10 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)

precis(m.v10)
WAIC(m.v10)




# . ace -------------------------------------------------------------------
dat <- list(C = d_lag10$c, A1 = d_lag10$a_lag1, A2 = d_lag10$a_lag2, A3 = d_lag10$a_lag3, A4 = d_lag10$a_lag4, A5 = d_lag10$a_lag5, A6 = d_lag10$a_lag6, A7 = d_lag10$a_lag7, A8 = d_lag10$a_lag8, A9 = d_lag10$a_lag9, A10 = d_lag10$a_lag10)
m.a10 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bA1 * A1 + bA2 * A2 + bA3 * A3 + bA4 * A4 + bA5 * A5 + bA6 * A6 + bA7 * A7 + bA8 * A8 + bA9 * A9 + bA10 * A10, 
    a ~ dnorm(-10, 1), 
    bA1 ~ dnorm(0.5, 0.5), 
    bA2 ~ dnorm(0.5, 0.5), 
    bA3 ~ dnorm(0.5, 0.5), 
    bA4 ~ dnorm(0.5, 0.5), 
    bA5 ~ dnorm(0.5, 0.5), 
    bA6 ~ dnorm(0.5, 0.5), 
    bA7 ~ dnorm(0.5, 0.5), 
    bA8 ~ dnorm(0.5, 0.5), 
    bA9 ~ dnorm(0.5, 0.5), 
    bA10 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)




# . dh --------------------------------------------------------------------
dat <- list(C = d_lag10$c, DH1 = d_lag10$dh_lag1, DH2 = d_lag10$dh_lag2, DH3 = d_lag10$dh_lag3, DH4 = d_lag10$dh_lag4, DH5 = d_lag10$dh_lag5, DH6 = d_lag10$dh_lag6, DH7 = d_lag10$dh_lag7, DH8 = d_lag10$dh_lag8, DH9 = d_lag10$dh_lag9, DH10 = d_lag10$dh_lag10)
m.dh10 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bDH4 * DH4 + bDH5 * DH5 + bDH6 * DH6 + bDH7 * DH7 + bDH8 * DH8 + bDH9 * DH9 + bDH10 * DH10, 
    a ~ dnorm(-10, 1), 
    bDH1 ~ dnorm(0.5, 0.5), 
    bDH2 ~ dnorm(0.5, 0.5), 
    bDH3 ~ dnorm(0.5, 0.5), 
    bDH4 ~ dnorm(0.5, 0.5), 
    bDH5 ~ dnorm(0.5, 0.5), 
    bDH6 ~ dnorm(0.5, 0.5), 
    bDH7 ~ dnorm(0.5, 0.5), 
    bDH8 ~ dnorm(0.5, 0.5), 
    bDH9 ~ dnorm(0.5, 0.5), 
    bDH10 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)



# . n ---------------------------------------------------------------------
dat <- list(C = d_lag10$c, N1 = d_lag10$n_lag1, N2 = d_lag10$n_lag2, N3 = d_lag10$n_lag3, N4 = d_lag10$n_lag4, N5 = d_lag10$n_lag5, N6 = d_lag10$n_lag6, N7 = d_lag10$n_lag7, N8 = d_lag10$n_lag8, N9 = d_lag10$n_lag9, N10 = d_lag10$n_lag10)
m.n10 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bN1 * N1 + bN2 * N2 + bN3 * N3 + bN4 * N4 + bN5 * N5 + bN6 * N6 + bN7 * N7 + bN8 * N8 + bN9 * N9 + bN10 * N10, 
    a ~ dnorm(-10, 1), 
    bN1 ~ dnorm(0.5, 0.5), 
    bN2 ~ dnorm(0.5, 0.5), 
    bN3 ~ dnorm(0.5, 0.5), 
    bN4 ~ dnorm(0.5, 0.5), 
    bN5 ~ dnorm(0.5, 0.5), 
    bN6 ~ dnorm(0.5, 0.5), 
    bN7 ~ dnorm(0.5, 0.5), 
    bN8 ~ dnorm(0.5, 0.5), 
    bN9 ~ dnorm(0.5, 0.5), 
    bN10 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)




# . compare ---------------------------------------------------------------
compare(m.v10, m.a10, m.dh10, m.n10, func = WAIC)
compare(m.v10, m.a10, m.dh10, m.n10, func = PSIS)
# Best model: m.v10




# Two Predictors, Lag 5 ---------------------------------------------------
# . v + a ----
dat <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, A1 = d_lag5$a_lag1, A2 = d_lag5$a_lag2, A3 = d_lag5$a_lag3, A4 = d_lag5$a_lag4, A5 = d_lag5$a_lag5)
m.v5a5 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bA1 * A1 + bA2 * A2 + bA3 * A3 + bA4 * A4 + bA5 * A5, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bV4 ~ dnorm(0.5, 0.5), 
    bV5 ~ dnorm(0.5, 0.5), 
    bA1 ~ dnorm(0.5, 0.5), 
    bA2 ~ dnorm(0.5, 0.5), 
    bA3 ~ dnorm(0.5, 0.5), 
    bA4 ~ dnorm(0.5, 0.5), 
    bA5 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)


# . v + dh ----
dat <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, DH1 = d_lag5$dh_lag1, DH2 = d_lag5$dh_lag2, DH3 = d_lag5$dh_lag3, DH4 = d_lag5$dh_lag4, DH5 = d_lag5$dh_lag5)
m.v5dh5 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bDH4 * DH4 + bDH5 * DH5, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bV4 ~ dnorm(0.5, 0.5), 
    bV5 ~ dnorm(0.5, 0.5), 
    bDH1 ~ dnorm(0.5, 0.5), 
    bDH2 ~ dnorm(0.5, 0.5), 
    bDH3 ~ dnorm(0.5, 0.5), 
    bDH4 ~ dnorm(0.5, 0.5), 
    bDH5 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)



# . v + n ----
dat <- list(C = d_lag5$c, V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, N1 = d_lag5$n_lag1, N2 = d_lag5$n_lag2, N3 = d_lag5$n_lag3, N4 = d_lag5$n_lag4, N5 = d_lag5$n_lag5)
m.v5n5 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bV4 * V4 + bV5 * V5 + bN1 * N1 + bN2 * N2 + bN3 * N3 + bN4 * N4 + bN5 * N5, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bV4 ~ dnorm(0.5, 0.5), 
    bV5 ~ dnorm(0.5, 0.5), 
    bN1 ~ dnorm(0.5, 0.5), 
    bN2 ~ dnorm(0.5, 0.5), 
    bN3 ~ dnorm(0.5, 0.5), 
    bN4 ~ dnorm(0.5, 0.5), 
    bN5 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)




# . compare ---------------------------------------------------------------
compare(m.v5a5, m.v5dh5, m.v5n5, func = WAIC)
compare(m.v5a5, m.v5dh5, m.v5n5, func = PSIS)
# Best Model: m.v5dh5





# Three Predictors, Lag 3 -------------------------------------------------

# Three predictors: v, n, dh
dat <- list(C = d_lag3$c, V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, A1 = d_lag3$a_lag1, A2 = d_lag3$a_lag2, A3 = d_lag3$a_lag3, DH1 = d_lag3$dh_lag1, DH2 = d_lag3$dh_lag2, DH3 = d_lag3$dh_lag3, N1 = d_lag3$n_lag1, N2 = d_lag3$n_lag2, N3 = d_lag3$n_lag3)



# . v + a + dh ------------------------------------------------------------
m.v3a3dh3 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bA1 * A1 + bA2 * A2 + bA3 * A3 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bA1 ~ dnorm(0.5, 0.5), 
    bA2 ~ dnorm(0.5, 0.5), 
    bA3 ~ dnorm(0.5, 0.5), 
    bDH1 ~ dnorm(0.5, 0.5), 
    bDH2 ~ dnorm(0.5, 0.5), 
    bDH3 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)


# . v + a + n -------------------------------------------------------------
m.v3a3n3 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bA1 * A1 + bA2 * A2 + bA3 * A3 + bN1 * N1 + bN2 * N2 + bN3 * N3, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bA1 ~ dnorm(0.5, 0.5), 
    bA2 ~ dnorm(0.5, 0.5), 
    bA3 ~ dnorm(0.5, 0.5), 
    bN1 ~ dnorm(0.5, 0.5), 
    bN2 ~ dnorm(0.5, 0.5), 
    bN3 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)


# . v + dh + n ------------------------------------------------------------
m.v3dh3n3 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bV1 * V1 + bV2 * V2 + bV3 * V3 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bN1 * N1 + bN2 * N2 + bN3 * N3, 
    a ~ dnorm(-10, 1), 
    bV1 ~ dnorm(0.5, 0.5), 
    bV2 ~ dnorm(0.5, 0.5), 
    bV3 ~ dnorm(0.5, 0.5), 
    bDH1 ~ dnorm(0.5, 0.5), 
    bDH2 ~ dnorm(0.5, 0.5), 
    bDH3 ~ dnorm(0.5, 0.5), 
    bN1 ~ dnorm(0.5, 0.5), 
    bN2 ~ dnorm(0.5, 0.5), 
    bN3 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)



# . a + dh + n ------------------------------------------------------------
m.a3dh3n3 <- ulam(
  alist(
    C ~ binomial(3.3e5, p), 
    logit(p) <- a + bA1 * A1 + bA2 * A2 + bA3 * A3 + bDH1 * DH1 + bDH2 * DH2 + bDH3 * DH3 + bN1 * N1 + bN2 * N2 + bN3 * N3, 
    a ~ dnorm(-10, 1), 
    bA1 ~ dnorm(0.5, 0.5), 
    bA2 ~ dnorm(0.5, 0.5), 
    bA3 ~ dnorm(0.5, 0.5), 
    bDH1 ~ dnorm(0.5, 0.5), 
    bDH2 ~ dnorm(0.5, 0.5), 
    bDH3 ~ dnorm(0.5, 0.5), 
    bN1 ~ dnorm(0.5, 0.5), 
    bN2 ~ dnorm(0.5, 0.5), 
    bN3 ~ dnorm(0.5, 0.5)
  ), data = dat, chains = 4, cores = 4, log_lik=TRUE
)


# . compare ---------------------------------------------------------------
compare(m.v3a3dh3, m.v3a3n3, m.v3dh3n3, m.a3dh3n3, func = WAIC)
compare(m.v3a3dh3, m.v3a3n3, m.v3dh3n3, m.a3dh3n3, func = PSIS)
# Best model: m.v3a3dh3
