# This script does the best subset selection of models
source(file = "./code/load_data.R")
library(leaps)

# Lag Variables ------------------------------------
lag_length <- 5
num_parameters <- lag_length * 6
start <- 1 + lag_length
end <- length(c)

for (i in 1:lag_length) {
  assign(paste0("v_lag", as.character(i)), v[(start-i) : (end-i)])
  assign(paste0("a_lag", as.character(i)), a[(start-i) : (end-i)])
  assign(paste0("n_lag", as.character(i)), n[(start-i) : (end-i)])
  assign(paste0("p_lag", as.character(i)), p[(start-i) : (end-i)])
  assign(paste0("h_lag", as.character(i)), h[(start-i) : (end-i)])
  assign(paste0("dh_lag", as.character(i)), dh[(start-i) : (end-i)])
}

d_lag5 <- data.frame(
  c = c[start : end], 
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

d_lag3 <- data.frame(
  c = c[start : end], 
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

d_lag7 <- data.frame(
  c = c[start : end], 
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



# Fit Models --------------------------------------------------------------
fit_subsets_7 <- regsubsets(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + v_lag6 + v_lag7 + a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + a_lag6 + a_lag7 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + n_lag6 + n_lag7 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + p_lag6 + p_lag7 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + h_lag6 + h_lag7 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5 + dh_lag6 + dh_lag7, data = d_lag7, nvmax = num_parameters)

fit_subsets_5 <- regsubsets(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + a_lag1 + a_lag2 + a_lag3 + a_lag4 + a_lag5 + n_lag1 + n_lag2 + n_lag3 + n_lag4 + n_lag5 + p_lag1 + p_lag2 + p_lag3 + p_lag4 + p_lag5 + h_lag1 + h_lag2 + h_lag3 + h_lag4 + h_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5, nvmax = 11)

fit_subsets_3 <- regsubsets(c ~ v_lag1 + v_lag2 + v_lag3 + a_lag1 + a_lag2 + a_lag3 + n_lag1 + n_lag2 + n_lag3 + p_lag1 + p_lag2 + p_lag3 + h_lag1 + h_lag2 + h_lag3 + dh_lag1 + dh_lag2 + dh_lag3, data = d_lag3, nvmax = num_parameters, nbest = 1)


fit_summary <- summary(fit_subsets_3)
names(fit_summary)

plot(fit_subsets, scale = "adjr2")
plot(fit_subsets_3, scale = "bic")
plot(fit_summary$bic)
plot(fit_subsets_3, scale = "Cp") # proportional to AIC
grid(nx = 11 + 1)


