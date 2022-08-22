plot(fit_ADL)
plot(fit_DL)



# Tests for Residual Serial Correlation -----------------------------------
# https://www.codingprof.com/3-easy-ways-to-test-for-autocorrelation-in-r-examples/

# ACF plots
acf(fit_ADL$residuals)
acf(fit_DL$residuals)

# Durbin-Watson test
library("car")
durbinWatsonTest(fit_ADL)
durbinWatsonTest(fit_DL)

library("lmtest")
dwtest(fit_ADL) # no serial correlation
dwtest(fit_DL) # positive autocorrelation found!

# Breusch-Godfrey test
bgtest(fit_ADL, order = 1) # autocorrelated
bgtest(fit_DL, order = 1) # autocorrelated

# https://youtu.be/qyGlB4cqZ9Q
## should check: 1) serial correlation, and 2) heteroscedasticity, 3) non-normality, 4) structural breaks in residual (stability of the system)


dens(fit_ADL$residual)
dens(fit_DL$residual)

fit$fitted.values# serial correlation 




# pass the test if p-value > 0.05; no serial correlation
library("vars")
serial.test(fit_var_cvn, lags.pt = 3, type = "PT.asymptotic")
serial.test(fit_var_vdh, lags.pt = 5, type = "PT.asymptotic")


# heteroscedasticity
# pass the test if p-value > 0.05; no heteroscedasticity
arch.test(fit_var_cvn, lags.multi = 3, multivariate.only = TRUE)
arch.test(fit_var_vdh, lags.multi = 5, multivariate.only = TRUE)

# non-normality
# pass the test if p-value > 0.05; residuals normally distributed
normality.test(fit_var_cvn, multivariate.only = TRUE)
normality.test(fit_var_vdh, multivariate.only = TRUE)

# structural breaks in the residual
# pass the test if the curve does not exceed the two red lines; the system is stable
plot(stability(fit_var_cvn, type = "OLS-CUSUM"))
plot(stability(fit_var_vdh, type = "OLS-CUSUM"))