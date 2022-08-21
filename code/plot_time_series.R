source("./code/load_data.R")


# Density Distributions ---------------------------------------------------
plot(density(c))
plot(density(v))
plot(density(a))
plot(density(n))
plot(density(p))
plot(density(h))
plot(density(dh))




# Distributions over Time -------------------------------------------------
plot(c ~ d$sampling_date, type = "l", ylab = "Confirmed Cases", xlab = "Time")
points(c ~ d$sampling_date, pch = 20)
grid()

plot(v ~ d$sampling_date, type = "l", ylab = "Virus", xlab = "Time")
points(v ~ d$sampling_date, pch = 20)
grid()

plot(a ~ d$sampling_date, type = "l", ylab = "Acetaminophen", xlab = "Time")
points(a ~ d$sampling_date, pch = 20)
grid()

plot(n ~ d$sampling_date, type = "l", ylab = "Nicotine", xlab = "Time")
points(n ~ d$sampling_date, pch = 20)
grid()

plot(p ~ d$sampling_date, type = "l", ylab = "Paraxanthine", xlab = "Time")
points(p ~ d$sampling_date, pch = 20)
grid()

plot(h ~ d$sampling_date, type = "l", ylab = "Hydroxychloroquine", xlab = "Time")
points(h ~ d$sampling_date, pch = 20)
grid()

plot(dh ~ d$sampling_date, type = "l", ylab = "Desethyl Hydroxychloroquine", xlab = "Time")
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
