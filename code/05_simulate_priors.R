# This script performs prior predictive simulation to regularize our estimate



# Set Priors --------------------------------------------------------------
N <- 1e4

mean_a <- -10
sigma_a <- 1

mean_b <- 0.5
sigma_b <- 0.5
# max(c) / 3.3e5 = 0.003

a <- rnorm(N, mean_a, sigma_a)
bV1 <- rnorm(N, mean_b, sigma_b)
bV2 <- rnorm(N, mean_b, sigma_b)
bV3 <- rnorm(N, mean_b, sigma_b)
bV4 <- rnorm(N, mean_b, sigma_b)
bV5 <- rnorm(N, mean_b, sigma_b)
bV6 <- rnorm(N, mean_b, sigma_b)
bV7 <- rnorm(N, mean_b, sigma_b)
bV8 <- rnorm(N, mean_b, sigma_b)
bV9 <- rnorm(N, mean_b, sigma_b)
bV10 <- rnorm(N, mean_b, sigma_b)




# Simulate Confirmed cases ------------------------------------------------

# Distribution of virus concentration
v_sim <- runif(N, 1, 1)


# Infection probabilities
prob <- inv_logit(a + bV1 * lag(v_sim, 1) + bV2 * lag(v_sim, 2) + bV3 * lag(v_sim, 3) + bV4 * lag(v_sim, 4) + bV5 * lag(v_sim, 5) + bV6 * lag(v_sim, 6) + bV7 * lag(v_sim, 7) + bV8 * lag(v_sim, 8) + bV9 * lag(v_sim, 9) + bV10 * lag(v_sim, 10))
summary(prob)
dens(prob, adj = 0.1, main = "probability distribution")


# Simulate Confirmed Cases
c_sim <- rbinom(N, 3.3e5, prob)
summary(c_sim)
dens(c_sim, adj = 0.1, main = "confirmed case")
