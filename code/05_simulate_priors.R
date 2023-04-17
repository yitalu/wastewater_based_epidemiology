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
v_sim <- runif(N, 0, 0)


# Infection probabilities
prob <- inv_logit(a + bV1 * lag(v_sim, 1) + bV2 * lag(v_sim, 2) + bV3 * lag(v_sim, 3) + bV4 * lag(v_sim, 4) + bV5 * lag(v_sim, 5) + bV6 * lag(v_sim, 6) + bV7 * lag(v_sim, 7) + bV8 * lag(v_sim, 8) + bV9 * lag(v_sim, 9) + bV10 * lag(v_sim, 10))
summary(prob)

# pdf("./figures/prior_prediction_prob_uniform.pdf", width = 9, height = 6)
# pdf("./figures/prior_prediction_prob_max.pdf", width = 9, height = 6)
# pdf("./figures/prior_prediction_prob_min.pdf", width = 9, height = 6)
dens(prob, adj = 0.1, lwd = 2, main = "Distribution of Infection Probability (Virus Concentration: Minimum)")
grid()
# dev.off()


# Simulate Confirmed Cases
c_sim <- rbinom(N, 3.3e5, prob)
summary(c_sim)

# pdf("./figures/prior_prediction_case_uniform.pdf", width = 9, height = 6)
# pdf("./figures/prior_prediction_case_max.pdf", width = 9, height = 6)
# pdf("./figures/prior_prediction_case_min.pdf", width = 9, height = 6)
dens(c_sim, adj = 0.1, lwd = 2, main = "Distribution of Confirmed Case (Virus Concentration: Minimum)")
grid()
# dev.off()
