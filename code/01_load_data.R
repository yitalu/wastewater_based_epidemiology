# This script loads data and standardizes variables of interest for later analysis



# Load Package and Data ---------------------------------------------------
library("data.table")
d <- fread("./data/wastewater_20220601.csv")



# Preprocess Data ---------------------------------------------------------
# remove the last "-" for column Sampling_Month
d[, sampling_month := substr(sampling_month, 1, 7)]



# Standardize Variables ---------------------------------------------------
# standardize with positive values
standardize_positive <- function(x){
  output <- (x - 0) / sd(x)
  return(output)
}

c <- standardize_positive(d$confirmed_cases)
v <- standardize_positive(d$sars_cov_2_virus)
a <- standardize_positive(d$acetaminophen)
n <- standardize_positive(d$nicotine)
p <- standardize_positive(d$paraxanthine)
h <- standardize_positive(d$hydroxychloroquine)
dh <- standardize_positive(d$desethyl_hydroxychloroquine)

c_d1 <- diff(c, differences = 1)
c_d2 <- diff(c, differences = 2)

tseries::adf.test(c_d1)
tseries::adf.test(c_d2)
tseries::adf.test(dh)



# Log-Transform Variables -------------------------------------------------
# replace 0 confirmed case with 1
# d$confirmed_cases_imputed <- d$confirmed_cases
# d$confirmed_cases_imputed[d$confirmed_cases == 0] <- 1
# 
# # log-transformation
# c <- log(d$confirmed_cases_imputed, base = 10)
# v <- log(d$sars_cov_2_virus, base = 10)
# a <- log(d$acetaminophen, base = 10)
# n <- log(d$nicotine, base = 10)
# p <- log(d$caffeine, base = 10)
# h <- log(d$hydroxychloroquine, base = 10)
# dh <- log(d$desethyl_hydroxychloroquine, base = 10)