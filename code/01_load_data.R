# This script loads data and standardizes variables of interest for later analysis



# Load Package and Data ---------------------------------------------------
library("data.table")
# d <- fread("./data/wastewater_20220601.csv")
d <- fread("./data/wastewater_20221019.csv")


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



# Replace 0 Confirmed Case (for Transformation) ---------------------------
# replace 0 confirmed case with 0.1
d$confirmed_cases_imputed <- d$confirmed_cases
d$confirmed_cases_imputed[d$confirmed_cases == 0] <- 0.1
c <- standardize_positive(d$confirmed_cases_imputed)



# Log-Transform Variables -------------------------------------------------
# # log-transformation
# c <- log(d$confirmed_cases_imputed, base = 10)
# v <- log(d$sars_cov_2_virus, base = 10)
# a <- log(d$acetaminophen, base = 10)
# n <- log(d$nicotine, base = 10)
# p <- log(d$caffeine, base = 10)
# h <- log(d$hydroxychloroquine, base = 10)
# dh <- log(d$desethyl_hydroxychloroquine, base = 10)



# Box-Cox Transformation --------------------------------------------------
# Box, G. E. P., & Cox, D. R. (1964). An analysis of transformations. Journal of the Royal Statistical Society. Series B, Statistical Methodology, 26(2), 211–252.
# library("MASS")
lambda <- BoxCox.lambda(c) # lambda = 0.3427084
c <- BoxCox(c, lambda)[1:111]
# c <- (c^lambda - 1) / lambda

# plot(c ~ d$sampling_date)
# plot(BoxCox(c, lambda) ~ d$sampling_date)

# plot(density(c))
# plot(density(BoxCox(c, lambda)))



# Difference Variables ----------------------------------------------------
# tseries::adf.test(diff(c, differences = 1))

# c_d1 <- diff(c, differences = 1)
# plot.ts(diff(c, differences = 1))
# plot.ts(cumsum(c_d1))

num_difference <- 1
c <- diff(c, differences = num_difference)
v <- v[(1+num_difference):nrow(d)]
# v <- diff(v, differences = num_difference)
a <- a[(1+num_difference):nrow(d)]
n <- n[(1+num_difference):nrow(d)]
# n <- diff(n, differences = num_difference)
p <- p[(1+num_difference):nrow(d)]
h <- h[(1+num_difference):nrow(d)]
dh <- dh[(1+num_difference):nrow(d)]