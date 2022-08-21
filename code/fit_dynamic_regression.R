source(file = "./code/load_data.R")
library("dynlm")
library("aTSA")
library("vars")
library("car")

c <- ts(c)
v <- ts(v)
a <- ts(a)
n <- ts(n)
p <- ts(p)
h <- ts(h)
dh <- ts(dh)


lag_length <- 3
fit <- dynlm(c ~ L(c, 1:lag_length) + L(v, 1:lag_length) + L(a, 1:lag_length) + L(n, 1:lag_length) + L(p, 1:lag_length) + L(h, 1:lag_length) + L(dh, 1:lag_length))
AIC(fit) # AIC chooses lag length 13
BIC(fit) # BIC chooses lag length 3, then 13
# AIC(fit) = -98.69901

lag_length <- 3
fit <- dynlm(c ~ L(v, 1:lag_length) + L(a, 1:lag_length) + L(n, 1:lag_length) + L(p, 1:lag_length) + L(h, 1:lag_length) + L(dh, 1:lag_length))
AIC(fit) # AIC chooses lag length 15
BIC(fit) # BIC chooses lag length 15, 14, 4

fit <- dynlm(c ~ L(v, 1:3) + L(a, 3) + L(n, 1) + L(dh, 3))
# AIC(fit) = -16.14165
AIC(fit)
BIC(fit)
summary(fit)
confint(fit)
par(mfrow=c(2,2))
plot(fit)


# Model Selection ---------------------------------------------------------

library(leaps)

summary(dynlm(c[3:111] ~ v[2:110] + v[1:109]))
summary(lm(c[3:111] ~ v[2:110] + v[1:109]))
fit <- regsubsets(c ~ lag(v, 1) + lag(v, 2), data = d, nbest = 4, nvmax = 19)
fit <- regsubsets(c ~ L(v, 1:lag_length) + L(a, 1:lag_length) + L(n, 1:lag_length) + L(p, 1:lag_length) + L(h, 1:lag_length) + L(dh, 1:lag_length))

plot(fit, scale="adjr2")

# Tests -------------------------------------------------------------------


# AIC: the smaller, the better
AIC(fit)


durbinWatsonTest(fit)

# Tests for residual serial correlation
# https://www.codingprof.com/3-easy-ways-to-test-for-autocorrelation-in-r-examples/
acf(fit$residuals)

library(lmtest)

# Durbin-Watson test
dwtest(fit) # positive autocorrelation found!

# Breusch-Godfrey test
bgtest(fit, order = 1) # autocorrelated

# https://youtu.be/qyGlB4cqZ9Q
## should check: 1) serial correlation, and 2) heteroscedasticity, 3) non-normality, 4) structural breaks in residual (stability of the system)


dens(fit$residual)

# pred <- predict(fit, interval = "confidence")
pred <- predict(fit, newdata = d[1:(111-lag_length+1)], interval = "confidence")
plot(pred[, 1] ~ c(lag_length:111), type = "l")
lines(pred[, 2] ~ c(lag_length:111), type = "l", col = "blue")
lines(pred[, 3] ~ c(lag_length:111), type = "l", col = "blue")


lines(c, type = "l", col="red")
lines(a, type = "l", col="green")
lines(fit$fitted.values, type = "l", col="orange")


fit$fitted.values# serial correlation 




# pass the test if p-value > 0.05; no serial correlation
serial.test(fit, lags.pt = lag_length, type = "PT.asymptotic")


# heteroscedasticity
# pass the test if p-value > 0.05; no heteroscedasticity
arch.test(model1, lags.multi = 12, multivariate.only = TRUE)

# non-normality
# pass the test if p-value > 0.05; residuals normally distributed
normality.test(fit, multivariate.only = TRUE)

# structural breaks in the residual
# pass the test if the curve does not exceed the two red lines; the system is stable
stability1 <- stability(model1, type = "OLS-CUSUM")
plot(stability1)