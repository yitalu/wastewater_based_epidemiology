source(file = "./code/load_data.R")
library("dynlm")

c <- ts(c)
v <- ts(v)
a <- ts(a)
n <- ts(n)
p <- ts(p)
h <- ts(h)
dh <- ts(dh)



# Fit Autoregressive Distributed Lag Model --------------------------------
lag_length <- 3
fit_ADL <- dynlm(c ~ c_lag1 + c_lag2 + c_lag3 + v_lag1 + v_lag2 + v_lag3 + n_lag1 + n_lag2 + n_lag3, data = d_lag3)

# fit_ADL <- dynlm(c ~ L(c, 1:lag_length) + L(v, 1:lag_length) + L(n, 1:lag_length), data = d_lag3)

# fit_ADL <- dynlm(c ~ L(c, 1:lag_length) + L(v, 1:lag_length) + L(n, 1:lag_length))

summary(fit_ADL)
AIC(fit_ADL)
BIC(fit_ADL)




# Fit Distributed Lag Model -----------------------------------------------
lag_length <- 5

fit_DL <- dynlm(c ~ v_lag1 + v_lag2 + v_lag3 + v_lag4 + v_lag5 + dh_lag1 + dh_lag2 + dh_lag3 + dh_lag4 + dh_lag5, data = d_lag5)

# fit_DL <- dynlm(c ~ L(v, 1:lag_length) + L(dh, 1:lag_length), data = d_lag5)

summary(fit_DL)
AIC(fit_DL)
BIC(fit_DL)
