library(brms)

plot(density(d$confirmed_cases))
plot(density(d$sars_cov_2_virus))
plot(density(log(d$sars_cov_2_virus)))

# prior(lognormal(130, 1), class = b, coef = confirmed_cases)
# priors <- c(prior(lognormal(130, 1), class = b, coef = confirmed_cases))

m1 <- brm(formula = confirmed_cases ~ I(sars_cov_2_virus * 1e-3), data = d, iter = 4000)
m2 <- brm(formula = confirmed_cases ~ I(sars_cov_2_virus * 1e-3) + sampling_date, data = d, iter = 4000)

summary(m1)
summary(m2)

plot(m1)
plot(m2)

prior_summary(m1)
pp_check(m1, type = "stat", stat = "mean")
mean(d$confirmed_cases)

pp_check(m2, prefix = "ppd")
pp_check(m2, ndraws = 50)
pp_check(m2, type = "xyz", )
pp_check(m2, type = "ribbon")

p1 <- pp_check(m1, type = "ribbon", ndraws = 100)
p2 <- pp_check(m2, type = "ribbon", ndraws = 100)

pdf(file = "./figures/predicted_confirmed_cases.pdf", width = 9, height = 6)
plot(p1)
# title(main = "Posterior Predictive Plot", xlab = "Time", ylab = "Predictive Confirmed Cases")
dev.off()

stanplot(m1)
stanplot(m2)
