source("./code/load_data.R")


# Density Distributions ---------------------------------------------------
plot(density(c))
plot(density(v))
plot(density(a))




# Density Distributions over Time -----------------------------------------
plot(d$sars_cov_2_virus ~ d$sampling_date)
plot(d$confirmed_cases ~ d$sampling_date)
plot(d$acetaminophen ~ d$sampling_date)

plot(standardize_positive(d$sars_cov_2_virus) ~ d$sampling_date)
plot(standardize_positive(d$confirmed_cases) ~ d$sampling_date)
plot(standardize_positive(d$acetaminophen) ~ d$sampling_date)

plot.ts(n)
plot.ts(p)
plot.ts(h)
plot.ts(dh)




# Plot Time Series: Original -----------------------------------------------
# pdf("./figures/trend_unstandardized.pdf", width = 9, height = 6)
plot(d$sars_cov_2_virus * 1e-3 ~ d$sampling_date, type = "l", xlab = "Sampling Date", ylab = "", main = "Wastewater-Based Epidemiology")
# points(d$sars_cov_2_virus * 1e-3 ~ d$sampling_date, pch = 20)
lines(d$confirmed_cases ~ d$sampling_date, type = "l", col = "blue")
lines(d$acetaminophen ~ d$sampling_date, col = "#ff7b00f5")

grid(col = "black", lty = "dotted")
legend("topleft", legend = c("SARS-CoV-2 Virus", "Confirmed Cases", "Acetaminophen"), col = c("black", "blue", "orange"), lty=1)
# dev.off()


# Plot Time Series: Standardized -------------------------------------------


# pdf("./figures/trend_standardized.pdf", width = 9, height = 6)
plot(v ~ d$sampling_date, type = "l", xlab = "Sampling Date", ylab = "Standardized Values", main = "Wastewater-Based Epidemiology")
# points(d$sars_cov_2_virus * 1e-3 ~ d$sampling_date, pch = 20)
lines(c ~ d$sampling_date, type = "l", col = "blue")
lines(a ~ d$sampling_date, col = "#ff7b00f5")

grid(col = "black", lty = "dotted")
legend("topleft", legend = c("SARS-CoV-2 Virus", "Confirmed Cases", "Acetaminophen"), col = c("black", "blue", "orange"), lty=1)
# dev.off()

