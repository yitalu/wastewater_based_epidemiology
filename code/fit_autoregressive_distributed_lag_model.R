source(file = "./code/load_data.R")
library("dynlm")
library("leaps")

c <- ts(c)
v <- ts(v)
a <- ts(a)
n <- ts(n)
p <- ts(p)
h <- ts(h)
dh <- ts(dh)



# Fit Autoregressive Distributed Lag Model --------------------------------
lag_length <- 3
fit_ADL <- dynlm(c ~ L(c, 1:lag_length) + L(v, 1:lag_length) + L(a, 1:lag_length) + L(n, 1:lag_length) + L(p, 1:lag_length) + L(h, 1:lag_length) + L(dh, 1:lag_length))

summary(fit_ADL)
AIC(fit_ADL)
BIC(fit_ADL)




# Fit Distributed Lag Model -----------------------------------------------
lag_length <- 15
fit_DL <- dynlm(c ~ L(v, 1:lag_length) + L(a, 1:lag_length) + L(n, 1:lag_length) + L(p, 1:lag_length) + L(h, 1:lag_length) + L(dh, 1:lag_length))

summary(fit_DL)
AIC(fit_DL)
BIC(fit_DL)
