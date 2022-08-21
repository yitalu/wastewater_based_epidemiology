# This script does the best subset selection of models
# Two general rules to consider: 1) 10 observations for each predictor; 2) use consecutive lags
source(file = "./code/load_data.R")
# library(leaps)
sample_per_predictor <- 10



# Lag Variables -----------------------------------------------------------
lag_length <- 5
sample_size <- nrow(d) - lag_length
max_predictors <- floor(sample_size / sample_per_predictor)
max_predictor_sets <- floor(max_predictors / lag_length)

start <- 1 + lag_length
end <- length(c)

for (i in 1:lag_length) {
  assign(paste0("c_lag", as.character(i)), c[(start-i) : (end-i)])
  assign(paste0("v_lag", as.character(i)), v[(start-i) : (end-i)])
  assign(paste0("a_lag", as.character(i)), a[(start-i) : (end-i)])
  assign(paste0("n_lag", as.character(i)), n[(start-i) : (end-i)])
  assign(paste0("p_lag", as.character(i)), p[(start-i) : (end-i)])
  assign(paste0("h_lag", as.character(i)), h[(start-i) : (end-i)])
  assign(paste0("dh_lag", as.character(i)), dh[(start-i) : (end-i)])
}




# Lagged Data Frame -------------------------------------------------------
# .  Lag 1 ----------------------------------------------------------------
d_lag1 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  v_lag1 = v_lag1, 
  a_lag1 = a_lag1, 
  n_lag1 = n_lag1, 
  p_lag1 = p_lag1, 
  h_lag1 = h_lag1, 
  dh_lag1 = dh_lag1
)

# .  Lag 2 ----------------------------------------------------------------
d_lag2 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2
)

# .  Lag 3 ----------------------------------------------------------------
d_lag3 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3
)

# .  Lag 4 ----------------------------------------------------------------
d_lag4 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4
)

# .  Lag 5 ----------------------------------------------------------------
d_lag5 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5,
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  a_lag5 = a_lag5,
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  n_lag5 = n_lag5,
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  p_lag5 = p_lag5,
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  h_lag5 = h_lag5,
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4,
  dh_lag5 = dh_lag5
)

# .  Lag 6 ----------------------------------------------------------------
d_lag6 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  c_lag6 = c_lag6, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5, 
  v_lag6 = v_lag6, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  a_lag5 = a_lag5, 
  a_lag6 = a_lag6, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  n_lag5 = n_lag5, 
  n_lag6 = n_lag6, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  p_lag5 = p_lag5, 
  p_lag6 = p_lag6, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  h_lag5 = h_lag5, 
  h_lag6 = h_lag6, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4,
  dh_lag5 = dh_lag5, 
  dh_lag6 = dh_lag6
)

# .  Lag 7 ----------------------------------------------------------------
d_lag7 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  c_lag6 = c_lag6, 
  c_lag7 = c_lag7, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5, 
  v_lag6 = v_lag6, 
  v_lag7 = v_lag7, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  a_lag5 = a_lag5, 
  a_lag6 = a_lag6, 
  a_lag7 = a_lag7, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  n_lag5 = n_lag5, 
  n_lag6 = n_lag6, 
  n_lag7 = n_lag7, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  p_lag5 = p_lag5, 
  p_lag6 = p_lag6, 
  p_lag7 = p_lag7, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  h_lag5 = h_lag5, 
  h_lag6 = h_lag6, 
  h_lag7 = h_lag7, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4,
  dh_lag5 = dh_lag5, 
  dh_lag6 = dh_lag6, 
  dh_lag7 = dh_lag7
)

# .  Lag 8 ----------------------------------------------------------------
d_lag8 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  c_lag6 = c_lag6, 
  c_lag7 = c_lag7, 
  c_lag8 = c_lag8, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5, 
  v_lag6 = v_lag6, 
  v_lag7 = v_lag7, 
  v_lag8 = v_lag8, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  a_lag5 = a_lag5, 
  a_lag6 = a_lag6, 
  a_lag7 = a_lag7, 
  a_lag8 = a_lag8, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  n_lag5 = n_lag5, 
  n_lag6 = n_lag6, 
  n_lag7 = n_lag7, 
  n_lag8 = n_lag8, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  p_lag5 = p_lag5, 
  p_lag6 = p_lag6, 
  p_lag7 = p_lag7, 
  p_lag8 = p_lag8, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  h_lag5 = h_lag5, 
  h_lag6 = h_lag6, 
  h_lag7 = h_lag7, 
  h_lag8 = h_lag8, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4,
  dh_lag5 = dh_lag5, 
  dh_lag6 = dh_lag6, 
  dh_lag7 = dh_lag7, 
  dh_lag8 = dh_lag8
)

# .  Lag 9 ----------------------------------------------------------------
d_lag9 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  c_lag6 = c_lag6, 
  c_lag7 = c_lag7, 
  c_lag8 = c_lag8, 
  c_lag9 = c_lag9, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5, 
  v_lag6 = v_lag6, 
  v_lag7 = v_lag7, 
  v_lag8 = v_lag8, 
  v_lag9 = v_lag9, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  a_lag5 = a_lag5, 
  a_lag6 = a_lag6, 
  a_lag7 = a_lag7, 
  a_lag8 = a_lag8, 
  a_lag9 = a_lag9, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  n_lag5 = n_lag5, 
  n_lag6 = n_lag6, 
  n_lag7 = n_lag7, 
  n_lag8 = n_lag8, 
  n_lag9 = n_lag9, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  p_lag5 = p_lag5, 
  p_lag6 = p_lag6, 
  p_lag7 = p_lag7, 
  p_lag8 = p_lag8, 
  p_lag9 = p_lag9, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  h_lag5 = h_lag5, 
  h_lag6 = h_lag6, 
  h_lag7 = h_lag7, 
  h_lag8 = h_lag8, 
  h_lag9 = h_lag9, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4,
  dh_lag5 = dh_lag5, 
  dh_lag6 = dh_lag6, 
  dh_lag7 = dh_lag7, 
  dh_lag8 = dh_lag8, 
  dh_lag9 = dh_lag9
)

# .  Lag 10 ---------------------------------------------------------------
d_lag10 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  c_lag6 = c_lag6, 
  c_lag7 = c_lag7, 
  c_lag8 = c_lag8, 
  c_lag9 = c_lag9, 
  c_lag10 = c_lag10, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5, 
  v_lag6 = v_lag6, 
  v_lag7 = v_lag7, 
  v_lag8 = v_lag8, 
  v_lag9 = v_lag9, 
  v_lag10 = v_lag10, 
  a_lag1 = a_lag1, 
  a_lag2 = a_lag2, 
  a_lag3 = a_lag3, 
  a_lag4 = a_lag4,
  a_lag5 = a_lag5, 
  a_lag6 = a_lag6, 
  a_lag7 = a_lag7, 
  a_lag8 = a_lag8, 
  a_lag9 = a_lag9, 
  a_lag10 = a_lag10, 
  n_lag1 = n_lag1, 
  n_lag2 = n_lag2, 
  n_lag3 = n_lag3, 
  n_lag4 = n_lag4,
  n_lag5 = n_lag5, 
  n_lag6 = n_lag6, 
  n_lag7 = n_lag7, 
  n_lag8 = n_lag8, 
  n_lag9 = n_lag9, 
  n_lag10 = n_lag10, 
  p_lag1 = p_lag1, 
  p_lag2 = p_lag2, 
  p_lag3 = p_lag3, 
  p_lag4 = p_lag4,
  p_lag5 = p_lag5, 
  p_lag6 = p_lag6, 
  p_lag7 = p_lag7, 
  p_lag8 = p_lag8, 
  p_lag9 = p_lag9, 
  p_lag10 = p_lag10, 
  h_lag1 = h_lag1, 
  h_lag2 = h_lag2, 
  h_lag3 = h_lag3, 
  h_lag4 = h_lag4,
  h_lag5 = h_lag5, 
  h_lag6 = h_lag6, 
  h_lag7 = h_lag7, 
  h_lag8 = h_lag8, 
  h_lag9 = h_lag9, 
  h_lag10 = h_lag10, 
  dh_lag1 = dh_lag1, 
  dh_lag2 = dh_lag2, 
  dh_lag3 = dh_lag3, 
  dh_lag4 = dh_lag4,
  dh_lag5 = dh_lag5, 
  dh_lag6 = dh_lag6, 
  dh_lag7 = dh_lag7, 
  dh_lag8 = dh_lag8, 
  dh_lag9 = dh_lag9, 
  dh_lag10 = dh_lag10
)



# Lag Length: 1 -----------------------------------------------------------
# max_predictor_sets: 11
fit_subsets_lag1 <- regsubsets(c ~ c_lag1 + v_lag1 + a_lag1 + n_lag1 + p_lag1 + h_lag1 + dh_lag1, data = d_lag1, nbest = 1, nvmax = 11)

fit_summary <- summary(fit_subsets_lag1)
names(fit_summary)
plot(fit_summary$cp)

AIC(dynlm(c ~ c_lag1, data = d_lag1))

AIC(dynlm(c ~ c_lag1 + v_lag1, data = d_lag1))

AIC(dynlm(c ~ c_lag1 + v_lag1 + n_lag1, data = d_lag1))

AIC(dynlm(c ~ c_lag1 + v_lag1 + n_lag1 + p_lag1, data = d_lag1))

AIC(dynlm(c ~ c_lag1 + v_lag1 + n_lag1 + p_lag1 + dh_lag1, data = d_lag1)) # -18.54858

AIC(dynlm(c ~ c_lag1 + v_lag1 + n_lag1 + p_lag1 + h_lag1 + dh_lag1, data = d_lag1))

AIC(dynlm(c ~ c_lag1 + v_lag1 + a_lag1 + n_lag1 + p_lag1 + h_lag1 + dh_lag1, data = d_lag1))

plot(fit_subsets_lag1, scale = "adjr2")
plot(fit_subsets_lag1, scale = "bic")
plot(fit_subsets_lag1, scale = "Cp") # proportional to AIC
grid(nx = num_parameters + 2)

# min value of Cp: 5.9
# Model: c ~ c_lag1 + v_lag1 + n_lag1 + p_lag1 + dh_lag1



# Lag Length: 2 -----------------------------------------------------------
# max_predictor_sets: 5
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2)) # -43.3828
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2)) # -43.52235
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2)) # -43.98809
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2)) # 130.1069

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))


# predictor_sets: 4
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2)) # -46.54003
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2)) # 130.8391

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))


AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2)) # -43.08046
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2)) # 128.2237

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))



# predictor_sets: 3
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + n_lag1 + n_lag2, data = d_lag2)) # -46.42368
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ c_lag1 + c_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2 + dh_lag1 + dh_lag2, data = d_lag2)) # 127.2301

AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ v_lag1 + v_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ v_lag1 + v_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ n_lag1 + n_lag2 + p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))


# predictor_sets: 2
AIC(dynlm(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2, data = d_lag2)) # -11.55133
AIC(dynlm(c ~ c_lag1 + c_lag2 + a_lag1 + a_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + n_lag1 + n_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ c_lag1 + c_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ v_lag1 + v_lag2 + a_lag1 + a_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + n_lag1 + n_lag2, data = d_lag2)) # 128.381
AIC(dynlm(c ~ v_lag1 + v_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ v_lag1 + v_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ a_lag1 + a_lag2 + n_lag1 + n_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ n_lag1 + n_lag2 + p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ n_lag1 + n_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ n_lag1 + n_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ p_lag1 + p_lag2 + h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ p_lag1 + p_lag2 + dh_lag1 + dh_lag2, data = d_lag2))

AIC(dynlm(c ~ h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2))


# predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2, data = d_lag2)) # 16.60088
AIC(dynlm(c ~ v_lag1 + v_lag2, data = d_lag2))
AIC(dynlm(c ~ a_lag1 + a_lag2, data = d_lag2))
AIC(dynlm(c ~ n_lag1 + n_lag2, data = d_lag2))
AIC(dynlm(c ~ p_lag1 + p_lag2, data = d_lag2))
AIC(dynlm(c ~ h_lag1 + h_lag2, data = d_lag2))
AIC(dynlm(c ~ dh_lag1 + dh_lag2, data = d_lag2))





# Lag Length: 3 -----------------------------------------------------------
# max_predictor_sets: 3
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3)) # -69.50629 (GLOBAL MIN with c)
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3)) # -47.28687

AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + a_lag1 + a_lag2 + a_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + a_lag1 + a_lag2 + a_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + a_lag1 + a_lag2 + a_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + n_lag1 + n_lag2 + n_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + n_lag1 + n_lag2 + n_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + p_lag1 + p_lag2 + p_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3)) # 62.53413

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + p_lag1 + p_lag2 + p_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + p_lag1 + p_lag2 + p_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))



# predictor_sets: 2
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3, data = d_lag3)) # -40.9948
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + a_lag1 + a_lag2 + a_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3)) # -2.7753
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3)) # 60.573

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))

# predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3, data = d_lag3)) # 19.48214
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3, data = d_lag3)) # 69.08195
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3, data = d_lag3))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3, data = d_lag3))
AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3, data = d_lag3))
AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3, data = d_lag3))
AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3))


# Lag Length: 4 -----------------------------------------------------------
# max_predictor_sets: 2
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + v_lag1 + v_lag2 + v_lag3 + v_lag4, data = d_lag4)) # -35.88518
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + a_lag1 + a_lag2 + a_lag3 + a_lag4, data = d_lag4))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + n_lag1 + n_lag2 + n_lag3 + n_lag4, data = d_lag4)) # -3.309136
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + p_lag1 + p_lag2 + p_lag3 + p_lag4, data = d_lag4))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + h_lag1 + h_lag2 + h_lag3 + h_lag4, data = d_lag4))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + a_lag1 + a_lag2 + a_lag3 + a_lag4, data = d_lag4))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + n_lag1 + n_lag2 + n_lag3 + n_lag4, data = d_lag4))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + p_lag1 + p_lag2 + p_lag3 + p_lag4, data = d_lag4))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + h_lag1 + h_lag2 + h_lag3 + h_lag4, data = d_lag4))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4)) # 11.11243

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + n_lag1 + n_lag2 + n_lag3 + n_lag4, data = d_lag4))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + p_lag1 + p_lag2 + p_lag3 + p_lag4, data = d_lag4))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + h_lag1 + h_lag2 + h_lag3 + h_lag4, data = d_lag4))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + p_lag1 + p_lag2 + p_lag3 + p_lag4, data = d_lag4))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + h_lag1 + h_lag2 + h_lag3 + h_lag4, data = d_lag4))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + h_lag1 + h_lag2 + h_lag3 + h_lag4, data = d_lag4))
AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4))


# predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4, data = d_lag4)) # 21.21652
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4, data = d_lag4)) # 27.40498
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4, data = d_lag4))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4, data = d_lag4))
AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4, data = d_lag4))
AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4, data = d_lag4))
AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4, data = d_lag4))



# Lag Length: 5 -----------------------------------------------------------
# max_predictor_sets: 2
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5, data = d_lag5)) # -39.44621
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5, data = d_lag5))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5, data = d_lag5))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5, data = d_lag5))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5, data = d_lag5))
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5, data = d_lag5))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5, data = d_lag5))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5, data = d_lag5))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5, data = d_lag5))
AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5)) # 5.304252 (GLOBAL MIN without c)

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5, data = d_lag5))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5, data = d_lag5))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5, data = d_lag5))
AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5, data = d_lag5))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5, data = d_lag5))
AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5, data = d_lag5))
AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5))


# predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5, data = d_lag5)) # 14.72657

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5, data = d_lag5)) # 20.76768

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5, data = d_lag5))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5, data = d_lag5))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5, data = d_lag5))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5, data = d_lag5))

AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5))


# Lag Length: 6 -----------------------------------------------------------
# max_predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + c_lag6, data = d_lag6))

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6, data = d_lag6)) # 11.53252

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6, data = d_lag6))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6, data = d_lag6))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6, data = d_lag6))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6, data = d_lag6))

AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6, data = d_lag6))



# Lag Length: 7 -----------------------------------------------------------
# max_predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + c_lag6 + c_lag7, data = d_lag7)) # 4.786252

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6 + v_lag7, data = d_lag7)) # 5.611666

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6 + a_lag7, data = d_lag7))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6 + n_lag7, data = d_lag7))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6 + p_lag7, data = d_lag7))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6 + h_lag7, data = d_lag7))

AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6 + dh_lag7, data = d_lag7))

# Lag Length: 8 -----------------------------------------------------------
# max_predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + c_lag6 + c_lag7 + c_lag8, data = d_lag8)) # 7.514695

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6 + v_lag7 + v_lag8, data = d_lag8)) # 8.125897

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6 + a_lag7 + a_lag8, data = d_lag8))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6 + n_lag7 + n_lag8, data = d_lag8))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6 + p_lag7 + p_lag8, data = d_lag8))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6 + h_lag7 + h_lag8, data = d_lag8))

AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6 + dh_lag7 + dh_lag8, data = d_lag8))

# Lag Length: 9 -----------------------------------------------------------
# max_predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + c_lag6 + c_lag7 + c_lag8 + c_lag9, data = d_lag9)) # 7.207297

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6 + v_lag7 + v_lag8 + v_lag9, data = d_lag9)) # 10.26664

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6 + a_lag7 + a_lag8 + a_lag9, data = d_lag9))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6 + n_lag7 + n_lag8 + n_lag9, data = d_lag9))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6 + p_lag7 + p_lag8 + p_lag9, data = d_lag9))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6 + h_lag7 + h_lag8 + h_lag9, data = d_lag9))

AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6 + dh_lag7 + dh_lag8 + dh_lag9, data = d_lag9))

# Lag Length: 10 -----------------------------------------------------------
# max_predictor_sets: 1
AIC(dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + c_lag4 + c_lag5 + c_lag6 + c_lag7 + c_lag8 + c_lag9 + c_lag10, data = d_lag10)) # 5.513185

AIC(dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6 + v_lag7 + v_lag8 + v_lag9 + v_lag10, data = d_lag10)) # 10.2101

AIC(dynlm(c ~ a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6 + a_lag7 + a_lag8 + a_lag9 + a_lag10, data = d_lag10))

AIC(dynlm(c ~ n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6 + n_lag7 + n_lag8 + n_lag9 + n_lag10, data = d_lag10))

AIC(dynlm(c ~ p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6 + p_lag7 + p_lag8 + p_lag9 + p_lag10, data = d_lag10))

AIC(dynlm(c ~ h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6 + h_lag7 + h_lag8 + h_lag9 + h_lag10, data = d_lag10))

AIC(dynlm(c ~ dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6 + dh_lag7 + dh_lag8 + dh_lag9 + dh_lag10, data = d_lag10))






# Fit Models --------------------------------------------------------------
# .  Lag 1 ----------------------------------------------------------------
fit_subsets_lag1 <- regsubsets(c ~ c_lag1 + v_lag1 + a_lag1 + n_lag1 + p_lag1 + h_lag1 + dh_lag1, data = d_lag1, nbest = 1, nvmax = 11)

fit_summary <- summary(fit_subsets_lag1)
names(fit_summary)
plot(fit_summary$cp)

plot(fit_subsets_lag1, scale = "adjr2")
plot(fit_subsets_lag1, scale = "bic")
plot(fit_subsets_lag1, scale = "Cp") # proportional to AIC
grid(nx = num_parameters + 2)

# min value of Cp: 5.9
# Model: c ~ c_lag1 + v_lag1 + n_lag1 + p_lag1 + dh_lag1


AIC(dynlm(c ~ c_lag1 + v_lag1 + a_lag1 + n_lag1 + p_lag1 + h_lag1 + dh_lag1, data = d_lag1, data = d_lag3))


# .  Lag 2 ----------------------------------------------------------------
fit_subsets_lag2 <- regsubsets(c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + a_lag2 + n_lag1 + n_lag2 + p_lag1 + p_lag2 + h_lag1 + h_lag2 + dh_lag1 + dh_lag2, data = d_lag2, nbest = 1, nvmax = 11)

fit_summary <- summary(fit_subsets_lag2)
names(fit_summary)
plot(fit_summary$cp)

plot(fit_subsets_lag2, scale = "Cp") # proportional to AIC
grid(nx = num_parameters + 2)

# min value of Cp: 4.3
# Model: c ~ c_lag1 + c_lag2 + v_lag1 + v_lag2 + a_lag1 + n_lag1 + n_lag2 + p_lag1 + h_lag1 + dh_lag1 + dh_lag2



# .  Lag 3 ----------------------------------------------------------------
fit_subsets_lag3 <- regsubsets(c ~ c_lag1 + c_lag2 + c_lag3 +  v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3, nbest = 1, nvmax = 11)

fit_summary <- summary(fit_subsets_lag3)
names(fit_summary)
plot(fit_summary$cp)

plot(fit_subsets_lag3, scale = "Cp") # proportional to AIC
grid(nx = num_parameters + 2)

# min value of Cp: 6
# Model: c ~ c_lag1 + c_lag2 + c_lag3 +  v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag3

# .  Lag 4 ----------------------------------------------------------------

# .  Lag 5 ----------------------------------------------------------------

# .  Lag 6 ----------------------------------------------------------------

# .  Lag 7 ----------------------------------------------------------------

fit_subsets_3 <- regsubsets(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3, nbest = 1, nvmax = 11)

fit_summary <- summary(fit_subsets_3)

AIC(dynlm(c ~ c_lag1 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + p_lag1 + dh_lag1 + dh_lag3, data = d_lag3))


fit_subsets_5 <- regsubsets(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5, nvmax = 11)

fit_subsets_7 <- regsubsets(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6 + v_lag7 + a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6 + a_lag7 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6 + n_lag7 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6 + p_lag7 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6 + h_lag7 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6 + dh_lag7, data = d_lag7, nvmax = 11)


fit_summary <- summary(fit_subsets_3)
names(fit_summary)

plot(fit_subsets, scale = "adjr2")
plot(fit_subsets_7, scale = "bic")
plot(fit_summary$bic)
plot(fit_subsets_7, scale = "Cp") # proportional to AIC
grid(nx = num_parameters + 1)


