source(file = "./code/load_data.R")

library("tseries")
library("vars")
library("aTSA")
library("dynlm")

colnames(d)

# focusing on confirmed cases and virus first


# Difference variables for use ----
confirmed_cases <- ts(d$confirmed_cases)
confirmed_cases_d1 <- diff(confirmed_cases)
confirmed_cases_d2 <- diff(confirmed_cases_d1)
confirmed_cases_d3 <- diff(confirmed_cases_d2)
confirmed_cases_d4 <- diff(confirmed_cases_d3)

sars_cov_2_virus <- ts(d$sars_cov_2_virus)
sars_cov_2_virus_d1 <- diff(sars_cov_2_virus)
sars_cov_2_virus_d2 <- diff(sars_cov_2_virus_d1)
sars_cov_2_virus_d3 <- diff(sars_cov_2_virus_d2)
sars_cov_2_virus_d4 <- diff(sars_cov_2_virus_d3)

acetaminophen <- ts(d$acetaminophen)
acetaminophen_d1 <- diff(acetaminophen)
acetaminophen_d2 <- diff(acetaminophen_d1)
acetaminophen_d3 <- diff(acetaminophen_d2)
acetaminophen_d4 <- diff(acetaminophen_d3)

# Check Stationarity and Level of Integration ----
# variable: confirmed_cases
adf.test(confirmed_cases) # p-value = 0.2673, non-stationary, Lag order = 4
aadf.test(confirmed_cases_d1)
adf.test(confirmed_cases_d2)
tseries::adf.test(confirmed_cases_d1)
tseries::adf.test(confirmed_cases_d2)

kpss.test(confirmed_cases)
tseries::kpss.test(confirmed_cases)

kpss.test(confirmed_cases_d1)
tseries::kpss.test(confirmed_cases_d1)


# variable: sars_cov_2_virus

adf.test(sars_cov_2_virus) # p-value = 0.7987, non-stationary, Lag order = 4
adf.test(sars_cov_2_virus_d1)
tseries::adf.test(sars_cov_2_virus)
tseries::adf.test(sars_cov_2_virus_d1)

kpss.test(sars_cov_2_virus)
kpss.test(sars_cov_2_virus_d1)
tseries::kpss.test(sars_cov_2_virus)
tseries::kpss.test(sars_cov_2_virus_d1)

plot(sars_cov_2_virus)
plot(sars_cov_2_virus_d1)


# variable: acetaminophen
adf.test(acetaminophen)
adf.test(acetaminophen_d1)

kpss.test(acetaminophen)
kpss.test(acetaminophen_d1)

# level of integration:
# confirmed_cases: 2
# sars_cov_2_virus: 1
# # acetaminophen: 1
# use the differenced twice series



# Lag Length Selection

VARselect(confirmed_cases_d2) 
# AIC(n)  HQ(n)  SC(n) FPE(n)  
   8      8      8      8

   VARselect(sars_cov_2_virus_d2)
# AIC(n)  HQ(n)  SC(n) FPE(n) 
     9      7      5      9

VARselect(cbind(confirmed_cases_d2, sars_cov_2_virus_d2))
# AIC(n)  HQ(n)  SC(n) FPE(n) 
     9      7      5      9

VARselect(cbind(confirmed_cases, sars_cov_2_virus))
# AIC(n)  HQ(n)  SC(n) FPE(n) 
     7      3      3      7

     

VARselect(cbind(c, v, a)) # AIC: 5
VARselect(cbind(c, v, a, n, p)) # AIC: 10
VARselect(cbind(c, v, a, n, p, h, dh)) # AIC: 10




# Check Normality ect. ----
L(confirmed_cases, k = 1)
b <- lag(confirmed_cases, k = 10)

sars_cov_2_virus
lag(sars_cov_2_virus, k = 1:5)

var_eq1 <- dynlm(confirmed_cases_d2 ~ lag(confirmed_cases_d2, 1:lag_length) + L())

var_eq1 <- dynlm(d.gini ~ L(d.gini, 1:lag_length) + L(d.rice_vot_h, 1:lag_length), start = 1913, end = 2018)
var_eq2 <- dynlm(d.rice_vot_h ~ L(d.gini, 1:lag_length) + L(d.rice_vot_h, 1:lag_length), start = 1913, end = 2018)


# Cointegration Test ----
coint.test(confirmed_cases, sars_cov_2_virus)
coint.test(sars_cov_2_virus, confirmed_cases)
