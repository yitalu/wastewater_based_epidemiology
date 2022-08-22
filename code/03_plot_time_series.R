# This script plots the density distributions and the time series of interested variables.



# Load Data ---------------------------------------------------------------
source("./code/01_load_data.R")



# Density Distributions ---------------------------------------------------
plot(density(c))
plot(density(v))
plot(density(a))
plot(density(n))
plot(density(p))
plot(density(h))
plot(density(dh))



# Distributions over Time -------------------------------------------------
# Confirmed Cases
plot(c ~ d$sampling_date, type = "l", ylab = "Confirmed Cases", xlab = "Time", main = "COVID-19 Confirmed Cases: Mid-2020 to Early 2022")
points(c ~ d$sampling_date, pch = 20)
grid()

# Virus
plot(v ~ d$sampling_date, type = "l", ylab = "Virus Gene Copies (Standardized)", xlab = "Time", main = "Virus Gene Copies (Mid-2020 to Early 2022)")
points(v ~ d$sampling_date, pch = 20)
grid()

# Acetaminophen
plot(a ~ d$sampling_date, type = "l", ylab = "Acetaminophen (Standardized)", xlab = "Time", main = "Acetaminophen (Mid-2020 to Early 2022)")
points(a ~ d$sampling_date, pch = 20)
grid()

# Nicotine
plot(n ~ d$sampling_date, type = "l", ylab = "Nicotine (Standardized)", xlab = "Time", main = "Nicotine (Mid-2020 to Early 2022)")
points(n ~ d$sampling_date, pch = 20)
grid()

# Paraxanthine
plot(p ~ d$sampling_date, type = "l", ylab = "Paraxanthine (Standardized)", xlab = "Time", main = "Paraxanthine (Mid-2020 to Early 2022)")
points(p ~ d$sampling_date, pch = 20)
grid()

# Hydroxychloroquine
plot(h ~ d$sampling_date, type = "l", ylab = "Hydroxychloroquine (Standardized)", xlab = "Time", main = "Hydroxychloroquine (Mid-2020 to Early 2022)")
points(h ~ d$sampling_date, pch = 20)
grid()

# Desethyl Hydroxychloroquine
plot(dh ~ d$sampling_date, type = "l", ylab = "Desethyl Hydroxychloroquine (Standardized)", xlab = "Time", main = "Desethyl Hydroxychloroquine (Mid-2020 to Early 2022)")
points(dh ~ d$sampling_date, pch = 20)
grid()



# Plot Time Series --------------------------------------------------------
plot.ts(c, ylab = "Confirmed Cases")
plot.ts(v, ylab = "Virus")
plot.ts(a, ylab = "Acetaminophen")
plot.ts(n, ylab = "Nicotine")
plot.ts(p, ylab = "Paraxanthine")
plot.ts(h, ylab = "Hydroxychloroquine")
plot.ts(dh, ylab = "Desethyl Hydroxychloroquine")



# Overlap Time Series: Standardized ---------------------------------------
# pdf("./figures/trend_standardized.pdf", width = 9, height = 6)
plot(v ~ d$sampling_date, type = "l", xlab = "Sampling Date", ylab = "Standardized Values", main = "Wastewater-Based Epidemiology")
# points(d$sars_cov_2_virus * 1e-3 ~ d$sampling_date, pch = 20)
lines(c ~ d$sampling_date, type = "l", col = "blue")

lines(a ~ d$sampling_date, col = "#ff7b00f5")
lines(n ~ d$sampling_date, col = "#ff7b00f5")
lines(p ~ d$sampling_date, col = "#ff7b00f5")
lines(h ~ d$sampling_date, col = "#ff7b00f5")
lines(dh ~ d$sampling_date, col = "#ff7b00f5")

grid(col = "black", lty = "dotted")
legend("topleft", legend = c("SARS-CoV-2 Virus", "Confirmed Cases", "Acetaminophen"), col = c("black", "blue", "orange"), lty=1)
# dev.off()



# Overlap Time Series: Unstandardized -------------------------------------
# pdf("./figures/trend_unstandardized.pdf", width = 9, height = 6)
plot(d$sars_cov_2_virus * 1e-3 ~ d$sampling_date, type = "l", xlab = "Sampling Date", ylab = "", main = "Wastewater-Based Epidemiology")
# points(d$sars_cov_2_virus * 1e-3 ~ d$sampling_date, pch = 20)
lines(d$confirmed_cases ~ d$sampling_date, type = "l", col = "blue")
lines(d$acetaminophen ~ d$sampling_date, col = "#ff7b00f5")

grid(col = "black", lty = "dotted")
legend("topleft", legend = c("SARS-CoV-2 Virus", "Confirmed Cases", "Acetaminophen"), col = c("black", "blue", "orange"), lty=1)
# dev.off()
