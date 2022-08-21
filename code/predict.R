library("rethinking")


# Predict by ADL Model ----------------------------------------------------
lag_length <- 3
pred <- predict(fit_ADL, newdata = d[1:(111-lag_length+1)], interval = "confidence")

# pdf("./figures/prediction_ADL_lag3.pdf", width = 9, height = 6)

plot(pred[, 1] ~ c(lag_length:111), type = "l", xlab = "Time", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Predicted by \n Wastewater Chemicals and Past Cases")
lines(pred[, 2] ~ c(lag_length:111), type = "l", col = rangi2)
lines(pred[, 3] ~ c(lag_length:111), type = "l", col = rangi2)
lines(c, type = "l", col="red")
grid()
legend("topleft", legend = c("Confirmed Case", "Predicted Case", "Confidence Interval"), col = c("red", "black", rangi2), lty=1)

# dev.off()

# lines(fit$fitted.values, type = "l", col="orange")
# lines(a, type = "l", col="green")



# Predict by DL Model -----------------------------------------------------
lag_length <- 15
pred <- predict(fit_DL, newdata = d[1:(111-lag_length+1)], interval = "confidence")

# pdf("./figures/prediction_DL_lag15.pdf", width = 9, height = 6)

plot(pred[, 1] ~ c(lag_length:111), type = "l", xlab = "Time", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Predicted by \n Wastewater Chemicals")
lines(pred[, 2] ~ c(lag_length:111), type = "l", col = rangi2)
lines(pred[, 3] ~ c(lag_length:111), type = "l", col = rangi2)
lines(c, type = "l", col="red")
grid()
legend("topleft", legend = c("Confirmed Case", "Predicted Case", "Confidence Interval"), col = c("red", "black", rangi2), lty=1)

# dev.off()