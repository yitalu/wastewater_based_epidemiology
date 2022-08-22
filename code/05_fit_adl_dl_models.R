# This script fits the two models selected in "./code/04_select_model.R": an Autoregressive Distributed Lag (ADL) model and a Distributed Lag (ADL) model.



# Load Package and Data ---------------------------------------------------
library("dynlm")
source(file = "./code/01_load_data.R")

c <- ts(c)
v <- ts(v)
a <- ts(a)
n <- ts(n)
p <- ts(p)
h <- ts(h)
dh <- ts(dh)



# Fit Autoregressive Distributed Lag Model --------------------------------
lag_length <- 3
fit_ADL <- dynlm(c ~ L(c, 1:lag_length) + L(v, 1:lag_length) + L(n, 1:lag_length))

summary(fit_ADL)
confint(fit_ADL)
par(mfrow=c(2,2))
plot(fit_ADL)
dev.off()
AIC(fit_ADL)
BIC(fit_ADL)



# Fit Distributed Lag Model -----------------------------------------------
lag_length <- 5
fit_DL <- dynlm(c ~ L(v, 1:lag_length) + L(dh, 1:lag_length))

lag_length <- 6
fit_DL <- dynlm(c ~ L(v, 1:lag_length))

lag_length <- 4
fit_DL <- dynlm(c ~ L(v, 1:lag_length) + L(dh, 1:lag_length))

lag_length <- 3
fit_DL <- dynlm(c ~ L(v, 1:lag_length) + L(a, 1:lag_length) + L(dh, 1:lag_length))


summary(fit_DL)
confint(fit_DL)
par(mfrow=c(2,2))
plot(fit_DL)
dev.off()
AIC(fit_DL)
BIC(fit_DL)