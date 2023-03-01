# This script tests the model with a new data set collected from 2022-01-10 to 2022-05-10.


# Build Test Data ----------------------------------------------------------
d_new <- fread("./data/wastewater_20230217.csv")

c_new <- d_new$confirmed_cases
v_new <- log10(d_new$sars_cov_2_virus) / max(log10(d_new$sars_cov_2_virus))

d_test <- data.frame(confirmed_cases = c(c, c_new), sars_cov_2_virus = c(v, v_new))

c <- d_test$confirmed_cases
v <- d_test$sars_cov_2_virus




# Construct Lagged Data ---------------------------------------------------

sample_per_predictor <- 10
lag_length <- 10
sample_size <- nrow(d_test) - lag_length
max_predictors <- floor(sample_size / sample_per_predictor)
max_predictor_sets <- floor(max_predictors / lag_length)

start <- 1 + lag_length
end <- dim(d_test)[1]

for (i in 1:lag_length) {
  assign(paste0("c_lag", as.character(i)), c[(start-i) : (end-i)])
  assign(paste0("v_lag", as.character(i)), v[(start-i) : (end-i)])
}

d_test_lag10 <- data.frame(
  c = c[start : end], 
  c_lag1 = c_lag1, 
  c_lag2 = c_lag2, 
  c_lag3 = c_lag3, 
  c_lag4 = c_lag4, 
  c_lag5 = c_lag5, 
  c_lag6 = c_lag6, 
  c_lag7 = c_lag7, 
  c_lag8 = c_lag8, 
  c_lag9 = c_lag9, 
  c_lag10 = c_lag10, 
  v_lag1 = v_lag1, 
  v_lag2 = v_lag2, 
  v_lag3 = v_lag3, 
  v_lag4 = v_lag4,
  v_lag5 = v_lag5, 
  v_lag6 = v_lag6, 
  v_lag7 = v_lag7, 
  v_lag8 = v_lag8, 
  v_lag9 = v_lag9, 
  v_lag10 = v_lag10
)




# One Predictor, Lag 10 ---------------------------------------------------
post_sim <- sim(m.v10, data = list(V1 = d_test_lag10$v_lag1, V2 = d_test_lag10$v_lag2, V3 = d_test_lag10$v_lag3, V4 = d_test_lag10$v_lag4, V5 = d_test_lag10$v_lag5, V6 = d_test_lag10$v_lag6, V7 = d_test_lag10$v_lag7, V8 = d_test_lag10$v_lag8, V9 = d_test_lag10$v_lag9, V10 = d_test_lag10$v_lag10), n = 1e4)




# Plot Prediction ---------------------------------------------------------
lag_length <- dim(d_test)[1] - dim(post_sim)[2]

plot(NULL, xlim = c(0, 150-lag_length), ylim = c(0, 1000), xlab = "Day", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Prediction \n by Virus Gene Copies from Past 10 Days")

rect(xleft = 101, xright = 150, ybottom = par("usr")[3], ytop = par("usr")[4], border = NA, col = adjustcolor("#6BD7AF", alpha = 0.3))

for (i in 1:50) {
  lines(1:(150-lag_length), post_sim[i, ], lty = 1, col = 2, lwd = 1)
}
lines(d_test$confirmed_cases[(lag_length+1):150], col = 4, lwd = 2)
grid()
PI_sim <- apply(post_sim, 2, function(x) PI(x, prob = 0.95))
lines(PI_sim[1, ], lty = 2, lwd = 1.5)
lines(PI_sim[2, ], lty = 2, lwd = 1.5)

# legend(0, 1000, legend = c("Predicted Case (Model)", "Confirmed Case (Data)", "95% Confidence Interval"), fill=c(2, 4, 1))
legend("topleft", inset = 0.02, legend = c("Predicted Case (Model)", "Confirmed Case (Data)", "95% Confidence Interval"), col=c(2, 4, 1), lty=c(1, 1, 2), lwd = c(2, 2, 2), cex=1)

text(40, 600, "Model is trained by data from this unshaded area.")
text(127, 600, "Model predicts \n confirm case.")
