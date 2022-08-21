source(file = "./code/load_data.R")
library(rethinking)
library(brms)


# Data List ---------------------------------------------------------------

data_list <- list(
  N = nrow(d),
  measure = cbind(c, v, a)
)

data_list <- list(
  C = c, 
  V = v, 
  A = a
)

data_ar1 <- list(
  C = c[2:111],
  V = v[2:111],
  A = a[2:111],
  C_lag1 = c[1:110], 
  V_lag1 = v[1:110], 
  A_lag1 = a[1:110]
)

data_ar2 <- list(
  C = c[3:111], 
  V = v[3:111], 
  A = a[3:111], 
  C_lag1 = c[2:110], 
  V_lag1 = c[2:110], 
  A_lag1 = c[2:110], 
  C_lag2 = c[1:109], 
  V_lag2 = c[1:109], 
  A_lag2 = c[1:109]
)

data_ar3 <- list(
  C = c[4:111], 
  V = v[4:111], 
  A = v[4:111], 
  C_lag1 = c[3:110], 
  V_lag1 = c[3:110], 
  A_lag1 = c[3:110], 
  C_lag2 = c[2:109], 
  V_lag2 = c[2:109], 
  A_lag2 = c[2:109], 
  C_lag3 = c[1:108], 
  V_lag3 = c[1:108], 
  A_lag3 = c[1:108]
)

data_ar4 <- list(
  C = c[5:111], 
  V = v[5:111], 
  A = v[5:111], 
  C_lag1 = c[4:110], 
  V_lag1 = c[4:110], 
  A_lag1 = c[4:110], 
  C_lag2 = c[3:109], 
  V_lag2 = c[3:109], 
  A_lag2 = c[3:109], 
  C_lag3 = c[2:108], 
  V_lag3 = c[2:108], 
  A_lag3 = c[2:108],
  C_lag4 = c[1:107], 
  V_lag4 = c[1:107], 
  A_lag4 = c[1:107]
)

data_ar5 <- list(
  C = c[6:111], 
  V = v[6:111], 
  A = v[6:111], 
  C_lag1 = c[5:110], 
  V_lag1 = c[5:110], 
  A_lag1 = c[5:110], 
  C_lag2 = c[4:109], 
  V_lag2 = c[4:109], 
  A_lag2 = c[4:109], 
  C_lag3 = c[3:108], 
  V_lag3 = c[3:108], 
  A_lag3 = c[3:108],
  C_lag4 = c[2:107], 
  V_lag4 = c[2:107], 
  A_lag4 = c[2:107], 
  C_lag5 = c[1:106], 
  V_lag5 = c[1:106], 
  A_lag5 = c[1:106]
)

# Models ------------------------------------------------------------------

fit_var_bayesian_1 <- ulam(
  alist(
   C ~ lognormal( log(mu_c), sigma_c), 
   V ~ lognormal( log(mu_v), sigma_v), 
   A ~ lognormal( log(mu_a), sigma_a), 
   mu_v <- a_v + b_vv * V_lag1 + b_va * A_lag1,
   mu_a <- a_a + b_av * V_lag1 + b_aa * A_lag1,
   mu_c <- a_c + b_cv * V_lag1,
   c(a_v, a_a, a_c) ~ exponential(1), 
   b_vv ~ normal(1, 0.5), 
   b_va ~ normal(-1, 0.5), 
   b_av ~ normal(1, 0.5), 
   b_aa ~ normal(-1, 0.5),
   b_cv ~ normal(1, 0.5),
   c(sigma_c, sigma_v, sigma_a) ~ exponential(1)
  ), 
  data = data_ar1, chains = 4, cores = 4
)

fit_var_bayesian_2 <- ulam(
  alist(
    C ~ lognormal( log(mu_c), sigma_c), 
    V ~ lognormal( log(mu_v), sigma_v), 
    A ~ lognormal( log(mu_a), sigma_a), 
    mu_v <- a_v + b_vv * V_lag1 + b_va * A_lag1 + b_vc * C_lag1,
    mu_a <- a_a + b_av * V_lag1 + b_aa * A_lag1 + b_ac * C_lag1,
    mu_c <- a_c + b_cv * V_lag1 + b_ca * A_lag1 + b_cc * C_lag1,
    c(a_v, a_a, a_c) ~ exponential(1), 
    b_vv ~ normal(1, 0.5), 
    b_va ~ normal(-1, 0.5), 
    b_vc ~ normal(1, 0.5), 
    b_av ~ normal(1, 0.5), 
    b_aa ~ normal(0, 0.5),
    b_ac ~ normal(1, 0.5),
    b_cv ~ normal(1, 0.5),
    b_ca ~ normal(-1, 0.5),
    b_cc ~ normal(1, 0.5),
    c(sigma_c, sigma_v, sigma_a) ~ exponential(1)
  ), 
  data = data_ar1, chains = 4, cores = 4
)

fit_var_bayesian_3 <- ulam(
  alist(
    C ~ lognormal( log(mu_c), sigma_c), 
    V ~ lognormal( log(mu_v), sigma_v), 
    A ~ lognormal( log(mu_a), sigma_a), 
    mu_v <- a_v + b_vv * V_lag1 + b_va * A_lag1,
    mu_a <- a_a + b_av * V_lag1 + b_aa * A_lag1,
    mu_c <- a_c + b_cv * V_lag1 + b_ca * A_lag1,
    c(a_v, a_a, a_c) ~ exponential(1), 
    b_vv ~ normal(1, 0.5), 
    b_va ~ normal(-1, 0.5), 
    # b_vc ~ normal(0, 0.5), 
    b_av ~ normal(1, 0.5), 
    b_aa ~ normal(-1, 0.5),
    # b_ac ~ normal(1, 0.5),
    b_cv ~ normal(0, 0.5),
    b_ca ~ normal(0, 0.5),
    # b_cc ~ normal(0, 0.5),
    c(sigma_c, sigma_v, sigma_a) ~ exponential(1)
  ), 
  data = data_ar1, chains = 4, cores = 4
)

fit_var_bayesian_4 <- ulam(
  alist(
    C ~ dlnorm( log(mu_c), sigma_c ), 
    mu_c <- a_c + b_v0 * V + b_a0 * A + b_v1 * V_lag1 + b_a1 * A_lag1 + b_v2 * V_lag2 + b_a2 * A_lag2 + b_v3 * V_lag3 + b_a3 * A_lag3 + b_v4 * V_lag4 + b_a4 * A_lag4 + b_v5 * V_lag5 + b_a5 * A_lag5,
    c(a_c) ~ exponential(0.5), 
    b_v0 ~ normal(0, 0.5),
    b_a0 ~ normal(0, 0.5),
    b_v1 ~ normal(0, 0.5),
    b_a1 ~ normal(0, 0.5),
    b_v2 ~ normal(0, 0.5),
    b_a2 ~ normal(0, 0.5),
    b_v3 ~ normal(0, 0.5),
    b_a3 ~ normal(0, 0.5),
    b_v4 ~ normal(0, 0.5),
    b_a4 ~ normal(0, 0.5),
    b_v5 ~ normal(0, 0.5),
    b_a5 ~ normal(0, 0.5),
    c(sigma_c) ~ exponential(0.5)
  ), 
  data = data_ar5, chains = 4, cores = 4
)

fit_var_bayesian_4_simple <- ulam(
  alist(
    C ~ dlnorm( log(mu_c), sigma_c ), 
    mu_c <- a_c + b_v0 * V + b_a0 * A + b_v1 * V_lag1 + b_a1 * A_lag1 + b_v2 * V_lag2 + b_a2 * A_lag2 + b_v3 * V_lag3 + b_a3 * A_lag3 + b_v4 * V_lag4 + b_a4 * A_lag4 + b_v5 * V_lag5 + b_a5 * A_lag5,
    c(a_c) ~ exponential(0.5), 
    b_v0 ~ normal(0, 0.5),
    b_a0 ~ normal(0, 0.5),
    b_v1 ~ normal(0, 0.5),
    b_a1 ~ normal(0, 0.5),
    b_v2 ~ normal(0, 0.5),
    b_a2 ~ normal(0, 0.5),
    b_v3 ~ normal(0, 0.5),
    b_a3 ~ normal(0, 0.5),
    b_v4 ~ normal(0, 0.5),
    b_a4 ~ normal(0, 0.5),
    b_v5 ~ normal(0, 0.5),
    b_a5 ~ normal(0, 0.5),
    c(sigma_c) ~ exponential(0.5)
  ), 
  data = data_ar5, chains = 4, cores = 4
)

fit_var_bayesian_4_uniform <- ulam(
  alist(
    C ~ dlnorm( log(mu_c), sigma_c ), 
    # mu_c <- a_c + b_v0 * V + b_a0 * A + b_v1 * V_lag1 + b_a1 * A_lag1 + b_v2 * V_lag2 + b_a2 * A_lag2 + b_v3 * V_lag3 + b_a3 * A_lag3 + b_v4 * V_lag4 + b_a4 * A_lag4 + b_v5 * V_lag5 + b_a5 * A_lag5,
    mu_c <- a_c + b_v0 * V + b_a0 * A + b_v1 * V_lag1 + b_a1 * A_lag1, 
    c(a_c) ~ exponential(0.5), 
    b_v0 ~ uniform(-2, 2),
    b_a0 ~ uniform(-2, 2),
    b_v1 ~ uniform(-2, 2),
    b_a1 ~ uniform(-2, 2),
    # b_v2 ~ uniform(0, 2),
    # b_a2 ~ uniform(0, 2),
    # b_v3 ~ uniform(0, 2),
    # b_a3 ~ uniform(0, 2),
    # b_v4 ~ uniform(0, 2),
    # b_a4 ~ uniform(0, 2),
    # b_v5 ~ uniform(0, 2),
    # b_a5 ~ uniform(0, 2),
    c(sigma_c) ~ exponential(0.5)
  ), 
  data = data_ar5, chains = 4, cores = 4
)

fit_var_bayesian_4_lagcases <- ulam(
  alist(
    C ~ dlnorm( log(mu_c), sigma_c ), 
    mu_c <- a_c + b_v0 * V + b_a0 * A + b_v1 * V_lag1 + b_a1 * A_lag1 + b_v2 * V_lag2 + b_a2 * A_lag2 + b_v3 * V_lag3 + b_a3 * A_lag3 + b_v4 * V_lag4 + b_a4 * A_lag4 + b_v5 * V_lag5 + b_a5 * A_lag5 + b_c1 * C_lag1 + b_c2 * C_lag2 + b_c3 * C_lag3 + b_c4 * C_lag4 + b_c5 * C_lag5,
    c(a_c) ~ exponential(1), 
    b_v0 ~ normal(0, 0.5),
    b_a0 ~ normal(0, 0.5),
    b_v1 ~ normal(0, 0.5),
    b_a1 ~ normal(0, 0.5),
    b_v2 ~ normal(0, 0.5),
    b_a2 ~ normal(0, 0.5),
    b_v3 ~ normal(0, 0.5),
    b_a3 ~ normal(0, 0.5),
    b_v4 ~ normal(0, 0.5),
    b_a4 ~ normal(0, 0.5),
    b_v5 ~ normal(0, 0.5),
    b_a5 ~ normal(0, 0.5),
    b_c1 ~ normal(0, 0.5),
    b_c2 ~ normal(0, 0.5),
    b_c3 ~ normal(0, 0.5),
    b_c4 ~ normal(0, 0.5),
    b_c5 ~ normal(0, 0.5),
    c(sigma_c) ~ exponential(0.5)
  ), 
  data = data_ar5, chains = 4, cores = 4
)

fit_var_bayesian_4_virus <- ulam(
  alist(
    C ~ dlnorm( log(mu_c), sigma_c ), 
    mu_c <- a_c + b_v0 * V + b_v1 * V_lag1 + b_v2 * V_lag2 + b_v3 * V_lag3 + b_v4 * V_lag4 + b_v5 * V_lag5,
    c(a_c) ~ exponential(1), 
    b_v0 ~ normal(0, 0.5),
    b_v1 ~ normal(0, 0.5),
    b_v2 ~ normal(0, 0.5),
    b_v3 ~ normal(0, 0.5),
    b_v4 ~ normal(0, 0.5),
    b_v5 ~ normal(0, 0.5),
    c(sigma_c) ~ exponential(0.5)
  ), 
  data = data_ar5, chains = 4, cores = 4
)

fit_var_bayesian_4_ace <- ulam(
  alist(
    C ~ lognormal( log(mu_c), sigma_c ), 
    mu_c <- a_c + b_a0 * A + b_a1 * A_lag1 + b_a2 * A_lag2 + b_a3 * A_lag3 + b_a4 * A_lag4 + b_a5 * A_lag5,
    c(a_c) ~ exponential(1), 
    b_a0 ~ normal(0, 0.5),
    b_a1 ~ normal(0, 0.5),
    b_a2 ~ normal(0, 0.5),
    b_a3 ~ normal(0, 0.5),
    b_a4 ~ normal(0, 0.5),
    b_a5 ~ normal(0, 0.5),
    c(sigma_c) ~ exponential(0.5)
  ), 
  data = data_ar5, chains = 4, cores = 4
)


# Predictions -------------------------------------------------------------

precis(fit)
post <- extract.samples(fit)
# pdf("./figures/trend_predicted_2_clear.pdf", width = 9, height = 6)
plot(data_ar5$C ~ d$sampling_date[6:111], type = "l", xlab = "Time", ylab = "Value", col = "red", lwd = 2, main = "COVID Confirmed Cases Predicted by \n Virus and Acetaminophen Concentration")
# lines(data_ar1$V ~ d$sampling_date[2:111], type = "l", col = "black")
# lines(data_ar1$A ~ d$sampling_date[2:111], type = "l", col = "orange")
mu <- link(fit_var_bayesian_4_ace)
for (s in 1:107) {
  lines(d$sampling_date[6:111], mu[s, ], col = col.alpha(rangi2, 0.2), lwd = 1)
  # lines(d$sampling_date[2:111], mu$mu_v[s, ], col = col.alpha("black", 0.2), lwd = 1)
  # lines(d$sampling_date[2:111], mu$mu_a[s, ], col = col.alpha("orange", 0.2), lwd = 1)
}
grid()
# legend("topleft", legend = c("Virus", "Acetaminophen", "Confirmed Cases", "Predicted Cases"), col = c("black", "orange", "red", rangi2), lty=1)
legend("topleft", legend = c("Confirmed Cases", "Predicted Cases"), col = c("red", rangi2), lty=1)
# dev.off()

compare(fit_var_bayesian_4, fit_var_bayesian_4_virus, func = WAIC)


# References --------------------------------------------------------------

data("Lynx_Hare")
dat_ar1 <- list(
  L = Lynx_Hare$Lynx[2:21],
  L_lag1 = Lynx_Hare$Lynx[1:20],
  H = Lynx_Hare$Hare[2:21],
  H_lag1 = Lynx_Hare$Hare[1:20]
)

m_H3_A <- ulam(
  alist(
    H ~ lognormal(log(muh), sigmah),
    L ~ lognormal(log(mul), sigmal),
    muh <- ah + b_hh * H_lag1 + b_hl * L_lag1,
    mul <- al + b_ll * L_lag1 + b_lh * H_lag1,
    c(ah, al) ~ normal(0, 1),
    b_hh ~ normal(1, 0.5),
    b_hl ~ normal(-1, 0.5),
    b_ll ~ normal(1, 0.5),
    b_lh ~ normal(1, 0.5),
    c(sigmah, sigmal) ~ exponential(1)
  ),
  data = dat_ar1, chains = 4, cores = 4
)
precis(m_H3_A)

post <- extract.samples(m_H3_A)
plot(dat_ar1$H, pch = 16, xlab = "Year", ylab = "pelts (thousands)", ylim = c(0, 100))
points(dat_ar1$L, pch = 16, col = rangi2)
mu <- link(m_H3_A)
for (s in 1:21) {
  lines(1:20, mu$muh[s, ], col = col.alpha("black", 0.2), lwd = 2) # hares
  lines(1:20, mu$mul[s, ], col = col.alpha(rangi2, 0.4), lwd = 2) # lynx
}
