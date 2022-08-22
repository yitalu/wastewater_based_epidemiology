# This script creates predictive plots based on the ADL and DL model.



# Predict by ADL Model ----------------------------------------------------
lag_length <- 3
pred <- predict(fit_ADL, newdata = d[1:(111-lag_length)], interval = "confidence")

# pdf("./figures/prediction_ADL_lag3.pdf", width = 9, height = 6)

plot(pred[, 1] ~ c((lag_length+1):111), type = "l", xlab = "Time", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Predicted by \n Past Cases, Virus Gene Copies, and Nicotine")
lines(pred[, 2] ~ c((lag_length+1):111), type = "l", col = rangi2)
lines(pred[, 3] ~ c((lag_length+1):111), type = "l", col = rangi2)
lines(c, type = "l", col="red")
grid()
legend("topleft", legend = c("Confirmed Case", "Predicted Case", "Confidence Interval"), col = c("red", "black", rangi2), lty=1)

# dev.off()

# lines(fit$fitted.values, type = "l", col="orange")
# lines(a, type = "l", col="green")



# Predict by DL Model -----------------------------------------------------
lag_length <- 5
pred <- predict(fit_DL, newdata = d[1:(111-lag_length)], interval = "confidence")

# pdf("./figures/prediction_DL_lag5.pdf", width = 9, height = 6)

plot(pred[, 1] ~ c((lag_length+1):111), type = "l", xlab = "Time", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Predicted by \n Virus Gene Copies and Desethyl Hydroxychloroquine")
lines(pred[, 2] ~ c((lag_length+1):111), type = "l", col = rangi2)
lines(pred[, 3] ~ c((lag_length+1):111), type = "l", col = rangi2)
lines(c, type = "l", col="red")
grid()
legend("topleft", legend = c("Confirmed Case", "Predicted Case", "Confidence Interval"), col = c("red", "black", rangi2), lty=1)

# dev.off()
