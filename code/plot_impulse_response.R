rm(list = ls())
source(file = "./code/load_data.R")

library("tseries")
library("vars")
library("rethinking")
# library("aTSA")
# library("dynlm")


lag_length <- 10
fit <- VAR(cbind(c, v, a, n, p, h, dh), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
fit <- VAR(cbind(c, v, a), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
fit <- VAR(cbind(c, v, n), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
fit <- VAR(cbind(c, v), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
summary(fit)
WAIC(fit, n = 1000)


irf_by_virus <- irf(fit, impulse = "v", response = "c", n.ahead = 20, boot = TRUE)
plot(irf_by_virus)

irf_by_acetaminophen <- irf(fit, impulse = "a", response = "c", n.ahead = 20, boot = TRUE)
plot(irf_by_acetaminophen)

irf_by_nicotine <- irf(fit, impulse = "n", response = "c", n.ahead = 20, boot = TRUE)
plot(irf_by_nicotine)

irf_by_paraxanthine <- irf(fit, impulse = "p", response = "c", n.ahead = 20, boot = TRUE)
plot(irf_by_paraxanthine)

irf_by_hydroxychloroquine <- irf(fit, impulse = "h", response = "c", n.ahead = 20, boot = TRUE)
plot(irf_by_hydroxychloroquine)

irf_by_desethyl_hydroxychloroquine <- irf(fit, impulse = "dh", response = "c", n.ahead = 20, boot = TRUE)
plot(irf_by_desethyl_hydroxychloroquine)














model <- VAR(cbind(confirmed_cases_d2, sars_cov_2_virus_d2), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
summary(model)

irf_virus <- irf(model, impulse = "confirmed_cases_d2", response = "sars_cov_2_virus_d2", n.ahead = 20, boot = TRUE)

irf_cases <- irf(model, impulse = "sars_cov_2_virus_d2", response = "confirmed_cases_d2", n.ahead = 20, boot = TRUE)

plot(irf_virus, main = "Shock from Confirmed Cases", ylab = "Virus D(2) Series")
plot(irf_cases, main = "Shock from Virus", ylab = "Confirmed Cases D(2) Series")




lag_length <- 7
model <- VAR(cbind(confirmed_cases, sars_cov_2_virus), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
summary(model)

irf_virus <- irf(model, impulse = "confirmed_cases", response = "sars_cov_2_virus", n.ahead = 20, boot = TRUE)

irf_cases <- irf(model, impulse = "sars_cov_2_virus", response = "confirmed_cases", n.ahead = 20, boot = TRUE)

pdf(file = "./figures/impulse_response_virus_by_cases.pdf", width = 9, height = 6)
plot(irf_virus, main = "How Confirmed Cases x Periods Before Affect Virus Concentration", ylab = "Virus Concentration", xlab = "Confirmed Cases")
dev.off()


pdf(file = "./figures/impulse_response_cases_by_virus.pdf", width = 9, height = 6)
plot(irf_cases, main = "How Virus Concentration x Periods Before Affects Confirmed Cases", ylab = "Confirmed Cases", xlab = "Virus")
dev.off()


VARselect(cbind(acetaminophen, sars_cov_2_virus))
lag_length <- 2
model <- VAR(cbind(acetaminophen, sars_cov_2_virus), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
summary(model)

irf_virus <- irf(model, impulse = "acetaminophen_d1", response = "sars_cov_2_virus_d1", n.ahead = 20, boot = TRUE)

irf_acetaminophen <- irf(model, impulse = "sars_cov_2_virus_d1", response = "acetaminophen_d1", n.ahead = 20, boot = TRUE)

pdf(file = "./figures/impulse_response_virus_by_acetaminophen.pdf", width = 9, height = 6)
plot(irf_virus, main = "How Acetaminophen x Periods Before Affect Virus Concentration", ylab = "Virus Concentration", xlab = "Acetaminophen")
dev.off()

pdf(file = "./figures/impulse_response_acetaminophen_by_virus.pdf", width = 9, height = 6)
plot(irf_acetaminophen, main = "How Virus Concentration x Periods Before Affects Acetaminophen", ylab = "Acetaminophen", xlab = "Virus")
dev.off()

WAIC(model, n = 1000)
