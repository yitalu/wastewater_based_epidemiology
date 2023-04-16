# This script diagnoses MCMC (Markov Chain Monte Carlo) of the selected model in each model set by looking at: 1) R-hat, 2) effective sample size (ESS), 3) trace plot, and 4) trace rank plot




# M-110s: one predictor, ten lags -----------------------------------------

# Rhat and n_eff
precis(m.v10, prob=0.95)

# Trace plot
pdf("./figures/trace_plot_m110_v10.pdf", width = 9, height = 6)
traceplot(m.v10, pars = c("a", "bV1", "bV2", "bV3", "bV4", "bV5", "bV6", "bV7", "bV8", "bV9", "bV10"))
dev.off()

# Rank plot
pdf("./figures/rank_plot_m110_v10.pdf", width = 9, height = 6)
trankplot(m.v10, pars = c("a", "bV1", "bV2", "bV3", "bV4", "bV5", "bV6", "bV7", "bV8", "bV9", "bV10"))
dev.off()



# M-205s: two predictors, five lags ---------------------------------------

# Rhat and n_eff
precis(m.v5dh5, prob=0.95)

# Trace plot
pdf("./figures/trace_plot_m205_v5dh5.pdf", width = 9, height = 6)
traceplot(m.v5dh5, pars = c("a", "bV1", "bV2", "bV3", "bV4", "bV5", "bDH1", "bDH2", "bDH3", "bDH4", "bDH5"))
dev.off()

# Rank plot
pdf("./figures/rank_plot_m205_v5dh5.pdf", width = 9, height = 6)
trankplot(m.v5dh5, pars = c("a", "bV1", "bV2", "bV3", "bV4", "bV5", "bDH1", "bDH2", "bDH3", "bDH4", "bDH5"))
dev.off()




# M-303s: three predictors, three lags ------------------------------------

# Rhat and n_eff
precis(m.v3a3dh3, prob=0.95)

# Trace plot
pdf("./figures/trace_plot_m303_v3a3dh3.pdf", width = 9, height = 6)
traceplot(m.v3a3dh3, pars = c("a", "bV1", "bV2", "bV3", "bA1", "bA2", "bA3", "bDH1", "bDH2", "bDH3"))
dev.off()

# Rank plot
pdf("./figures/rank_plot_m303_v3a3dh3.pdf", width = 9, height = 6)
trankplot(m.v3a3dh3, pars = c("a", "bV1", "bV2", "bV3", "bA1", "bA2", "bA3", "bDH1", "bDH2", "bDH3"))
dev.off()

