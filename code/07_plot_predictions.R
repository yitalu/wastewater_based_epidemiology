
# One Predictor, Lag 10 ---------------------------------------------------
post_sim <- sim(m.v10, data = list(V1 = d_lag10$v_lag1, V2 = d_lag10$v_lag2, V3 = d_lag10$v_lag3, V4 = d_lag10$v_lag4, V5 = d_lag10$v_lag5, V6 = d_lag10$v_lag6, V7 = d_lag10$v_lag7, V8 = d_lag10$v_lag8, V9 = d_lag10$v_lag9, V10 = d_lag10$v_lag10), n = 1e4)

post_sim <- sim(m.a10, data = list(A1 = d_lag10$a_lag1, A2 = d_lag10$a_lag2, A3 = d_lag10$a_lag3, A4 = d_lag10$a_lag4, A5 = d_lag10$a_lag5, A6 = d_lag10$a_lag6, A7 = d_lag10$a_lag7, A8 = d_lag10$a_lag8, A9 = d_lag10$a_lag9, A10 = d_lag10$a_lag10), n = 1e4)

post_sim <- sim(m.dh10, data = list(DH1 = d_lag10$dh_lag1, DH2 = d_lag10$dh_lag2, DH3 = d_lag10$dh_lag3, DH4 = d_lag10$dh_lag4, DH5 = d_lag10$dh_lag5, DH6 = d_lag10$dh_lag6, DH7 = d_lag10$dh_lag7, DH8 = d_lag10$dh_lag8, DH9 = d_lag10$dh_lag9, DH10 = d_lag10$dh_lag10), n = 1e4)

post_sim <- sim(m.n10, data = list(N1 = d_lag10$n_lag1, N2 = d_lag10$n_lag2, N3 = d_lag10$n_lag3, N4 = d_lag10$n_lag4, N5 = d_lag10$n_lag5, N6 = d_lag10$n_lag6, N7 = d_lag10$n_lag7, N8 = d_lag10$n_lag8, N9 = d_lag10$n_lag9, N10 = d_lag10$n_lag10), n = 1e4)


# Two Predictors, Lag 5 ---------------------------------------------------
post_sim <- sim(m.v5a5, data = list(V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, A1 = d_lag5$a_lag1, A2 = d_lag5$a_lag2, A3 = d_lag5$a_lag3, A4 = d_lag5$a_lag4, A5 = d_lag5$a_lag5), n = 1e4)

post_sim <- sim(m.v5dh5, data = list(V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, DH1 = d_lag5$dh_lag1, DH2 = d_lag5$dh_lag2, DH3 = d_lag5$dh_lag3, DH4 = d_lag5$dh_lag4, DH5 = d_lag5$dh_lag5), n = 1e4)

post_sim <- sim(m.v5n5, data = list(V1 = d_lag5$v_lag1, V2 = d_lag5$v_lag2, V3 = d_lag5$v_lag3, V4 = d_lag5$v_lag4, V5 = d_lag5$v_lag5, N1 = d_lag5$n_lag1, N2 = d_lag5$n_lag2, N3 = d_lag5$n_lag3, N4 = d_lag5$n_lag4, N5 = d_lag5$n_lag5), n = 1e4)




# Three Predictors, Lag 3 -------------------------------------------------
post_sim <- sim(m.v3a3dh3, data = list(V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, A1 = d_lag3$a_lag1, A2 = d_lag3$a_lag2, A3 = d_lag3$a_lag3, DH1 = d_lag3$dh_lag1, DH2 = d_lag3$dh_lag2, DH3 = d_lag3$dh_lag3), n = 1e4)

post_sim <- sim(m.v3a3n3, data = list(V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, A1 = d_lag3$a_lag1, A2 = d_lag3$a_lag2, A3 = d_lag3$a_lag3, N1 = d_lag3$n_lag1, N2 = d_lag3$n_lag2, N3 = d_lag3$n_lag3), n = 1e4)

post_sim <- sim(m.v3dh3n3, data = list(V1 = d_lag3$v_lag1, V2 = d_lag3$v_lag2, V3 = d_lag3$v_lag3, DH1 = d_lag3$dh_lag1, DH2 = d_lag3$dh_lag2, DH3 = d_lag3$dh_lag3, N1 = d_lag3$n_lag1, N2 = d_lag3$n_lag2, N3 = d_lag3$n_lag3), n = 1e4)

post_sim <- sim(m.a3dh3n3, data = list(A1 = d_lag3$a_lag1, A2 = d_lag3$a_lag2, A3 = d_lag3$a_lag3, DH1 = d_lag3$dh_lag1, DH2 = d_lag3$dh_lag2, DH3 = d_lag3$dh_lag3, N1 = d_lag3$n_lag1, N2 = d_lag3$n_lag2, N3 = d_lag3$n_lag3), n = 1e4)




# Plot Prediction ---------------------------------------------------------
lag_length <- dim(d)[1] - dim(post_sim)[2]

# plot(NULL, xlim = c(0, 111), ylim = c(0, 1000), xlab = "Day", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Prediction \n by Virus Gene Copies from the Past 10 Days")
# plot(NULL, xlim = c(0, 111), ylim = c(0, 1000), xlab = "Day", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Prediction \n by Virus and Desethyl-Hydroxychloroquine from the Past 5 Days")
plot(NULL, xlim = c(0, 111), ylim = c(0, 1000), xlab = "Day", ylab = "Confirmed Case", main = "COVID-19 Confirmed Case Prediction by Virus, \n Desethyl-Hydroxychloroquine, and Acetaminophen from the Past 3 Days")
for (i in 1:50) {
  # lines(1:(111-lag_length), post_sim[i, ], lty = 1, col = 2, lwd = 1)
  lines((lag_length+1):111, post_sim[i, ], lty = 1, col = 2, lwd = 1)
}
lines((lag_length+1):111, d$confirmed_cases[(lag_length+1):111], col = 4, lwd = 2)
grid()
PI_sim <- apply(post_sim, 2, function(x) PI(x, prob = 0.95))
lines((lag_length+1):111, PI_sim[1, ], lty = 2, lwd = 1.5)
lines((lag_length+1):111, PI_sim[2, ], lty = 2, lwd = 1.5)

# legend(0, 1000, legend = c("Predicted Case (Model)", "Confirmed Case (Data)", "95% Confidence Interval"), fill=c(2, 4, 1))
# legend(0, 1000, legend = c("Predicted Case (Model)", "Confirmed Case (Data)", "95% Confidence Interval"), col=c(2, 4, 1), lty=c(1, 1, 3), cex=0.8)
legend("topleft", inset = 0.02, legend = c("Predicted Case (Model)", "Confirmed Case (Data)", "95% Confidence Interval"), col=c(2, 4, 1), lty=c(1, 1, 2), lwd = c(2, 2, 2), cex=1)
