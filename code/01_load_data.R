# This script loads data and standardizes variables of interest for later analysis



# Load Package and Data ---------------------------------------------------
library("data.table")
d <- fread("./data/wastewater_20220601.csv")



# Preprocess Data ---------------------------------------------------------
# remove the last "-" for column Sampling_Month
d[, sampling_month := substr(sampling_month, 1, 7)]

# replace 0 confirmed case with 0.1
# d$confirmed_cases_imputed <- d$confirmed_cases
# d$confirmed_cases_imputed[d$confirmed_cases == 0] <- 0.1

# log-transform virus concentration
# d$sars_cov_2_virus_log <- log(d$sars_cov_2_virus, base = 10)



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