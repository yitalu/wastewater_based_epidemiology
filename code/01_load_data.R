# This script loads data and standardizes variables of interest for later analysis


# Load Package and Data ---------------------------------------------------
library("data.table")
library("rethinking")
d <- fread("./data/wastewater_20220601.csv")
# d <- fread("./data/wastewater_20221019.csv")




# Preprocess Data ---------------------------------------------------------
# remove the last "-" for column Sampling_Month
d[, sampling_month := substr(sampling_month, 1, 7)]




# Short-Named Variables ---------------------------------------------------
c <- d$confirmed_cases
v <- log10(d$sars_cov_2_virus) / max(log10(d$sars_cov_2_virus))
a <- d$acetaminophen / max(d$acetaminophen)
n <- d$nicotine / max(d$nicotine)
p <- d$paraxanthine / max(d$paraxanthine)
h <- d$hydroxychloroquine / max(d$hydroxychloroquine)
dh <- d$desethyl_hydroxychloroquine / max(d$desethyl_hydroxychloroquine)


# c <- d$confirmed_cases
# v <- standardize(log10(d$sars_cov_2_virus))
# a <- standardize(d$acetaminophen)
# n <- standardize(d$nicotine)
# p <- standardize(d$paraxanthine)
# h <- standardize(d$hydroxychloroquine)
# dh <- standardize(d$desethyl_hydroxychloroquine)