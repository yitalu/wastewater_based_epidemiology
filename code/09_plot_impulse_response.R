# This script plots the impulse response functions from the Vector Autoregressive Models (VAR) in "./code/06_fit_var_models.R". Two specific VAR models are analyzed: the Cases-Virus-Nicotine (CVN) VAR model, and the Case-Virus-DesethylHydroxychloroquine (CVdH) VAR model model.



# Load Package and Data ---------------------------------------------------
source(file = "./code/06_fit_var_models.R")



# Case-Virus-Nicotine VAR model ------------------------------------------_
irf_cvn_virus <- irf(fit_var_cvn, impulse = "v", response = "c", n.ahead = 20, boot = TRUE)

irf_cvn_nicotine <- irf(fit_var_cvn, impulse = "n", response = "c", n.ahead = 20, boot = TRUE)

pdf(file = "./figures/impulse_response_cvn_by_virus.pdf", width = 9, height = 6)
plot(irf_cvn_virus, ylab = "Confirmed Case", xlab = "Past Virus Concentration", main = "Influence of Past Virus on Confirmed Case")
dev.off()

pdf(file = "./figures/impulse_response_cvn_by_nicotine.pdf", width = 9, height = 6)
plot(irf_cvn_nicotine, ylab = "Confirmed Case", xlab = "Past Nicotine Concentration", main = "Influence of Past Nicotine on Confirmed Case")
dev.off()



# Case-Virus-DesethylHydroxychloroquine VAR model -------------------------
irf_cvdh_virus <- irf(fit_var_cvdh, impulse = "v", response = "c", n.ahead = 20, boot = TRUE)

irf_cvdh_DesethylHydroxychloroquine <- irf(fit_var_cvdh, impulse = "dh", response = "c", n.ahead = 20, boot = TRUE)

pdf(file = "./figures/impulse_response_cvdh_by_virus.pdf", width = 9, height = 6)
plot(irf_cvdh_virus, ylab = "Confirmed Case", xlab = "Past Virus Concentration", main = "Influence of Past Virus on Confirmed Case")
dev.off()

pdf(file = "./figures/impulse_response_cvdh_by_nicotine.pdf", width = 9, height = 6)
plot(irf_cvdh_DesethylHydroxychloroquine, ylab = "Confirmed Case", xlab = "Past Nicotine Concentration", main = "Influence of Past DesethylHydroxychloroquine on Confirmed Case")
dev.off()