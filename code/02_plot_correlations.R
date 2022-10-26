# This script finds potential correlations between variables; this helps determine what variables to include in our model.



# Load Package and Data ---------------------------------------------------
library(psych)
source("./code/01_load_data.R")



# Correlation Matrices ----------------------------------------------------
matrix_full <- d[, -c("sampling_date", "sampling_month")]
matrix_part <- d[, c("confirmed_cases", "sars_cov_2_virus", "acetaminophen", "atenolol", "caffeine", "carbamazepine", "cotinine", "paraxanthine", "venlafaxine", "chloroquine", "desethyl_chloroquine", "hydroxychloroquine")]

correlation_matrix_full <- cor(matrix_full)
correlation_matrix_part <- cor(matrix_part)

View(correlation_matrix_full)
View(correlation_matrix_part)



# Correlation Maps --------------------------------------------------------
# pdf(file = "./figures/correlation_map_full.pdf",  width = 20, height = 20)
# tiff(filename = "./figures/correlation_map_full.tiff", width = 4800, height = 4800, res = 280)
pairs.panels(matrix_full)
# dev.off()

# pdf(file = "./figures/correlation_map_part.pdf",  width = 12, height = 12)
pairs.panels(matrix_part)
# dev.off()



# Heatmaps ----------------------------------------------------------------
heatmap(correlation_matrix_full, Colv = NA, Rowv = NA)
heatmap(correlation_matrix_part, Colv = NA, Rowv = NA)
heatmap(correlation_matrix_full, Colv = NA, Rowv = NA, scale = "column")
heatmap(correlation_matrix_part, Colv = NA, Rowv = NA, scale = "column")



# Pairwise Correlations ---------------------------------------------------
cor(d$confirmed_cases, d$sars_cov_2_virus)
cor(d$acetaminophen, d$sars_cov_2_virus)
cor(d$acetaminophen, d$confirmed_cases)
cor(d$chloroquine, d$desethyl_chloroquine)
cor(d$sulfamethoxazole, d$trimethoprim)




# Pearson Correlations between Lagged/Lead Variables ----------------------
lag <- 1
start <- 1 + lag
c_lagged <- c[start : length(c)]
v_lagged <- v[start : length(v)]
a_lagged <- a[start : length(a)]
dh_lagged <- dh[start : length(dh)]

cor(v[1:(length(v)-lag)], c_lagged, method = "pearson")
cor(c[1:(length(c)-lag)], v_lagged, method = "pearson")

cor(a[1:(length(a)-lag)], c_lagged, method = "pearson")
cor(c[1:(length(c)-lag)], a_lagged, method = "pearson")

cor(dh[1:(length(dh)-lag)], c_lagged, method = "pearson")
cor(c[1:(length(c)-lag)], dh_lagged, method = "pearson")



# Cross Correlation Functions ---------------------------------------------
# https://online.stat.psu.edu/stat510/lesson/8/8.2
ccfvalues <- ccf(v, c)
ccfvalues
# pdf("./figures/cross_correlation_case_virus.pdf", width = 9, height = 6)
plot(ccf(v, c), ylab = "Cross Correlation", xlab = "Time-Adjusted Virus Concentration", main = "Peak of Virus Concentration Leads About 1 Time Step")
# dev.off()

ccfvalues <- ccf(c, a)
ccfvalues
# pdf("./figures/cross_correlation_case_acetaminophem.pdf", width = 9, height = 6)
plot(ccf(a, c), ylab = "Cross Correlation", xlab = "Time-Adjusted Acetaminophem",  main = "No Lead of Acetaminophem")
# dev.off()

ccfvalues <- ccf(dh, c)
ccfvalues
# pdf("./figures/cross_correlation_case_DesethylHydroxychloroquine.pdf", width = 9, height = 6)
plot(ccf(dh, c), ylab = "Cross Correlation", xlab = "Time-Adjusted DesethylHydroxychloroquine",  main = "Peak of DesethylHydroxychloroquine Leads About 10 Time Steps")
# dev.off()

# [**NOTE**] Previous studies use Maximum Pearson correlation to gauge the lead time. We do not advocate this method on time series data as Pearson correlation is more appropriate when there is no serial correlation, i.e. no spurious correlation, within variables. Otherwise, the coefficients tend to be inflated due to the dependence within series, even though the relative relationships of coefficients could be equivalent to our approach.