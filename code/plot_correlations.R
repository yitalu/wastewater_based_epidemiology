source("./code/load_data.R")
library(psych)

# Correlation Matrices ----------------------------------------------------
matrix_full <- d[, -c("sampling_date", "sampling_month")]
matrix_part <- m[, c("confirmed_cases", "sars_cov_2_virus", "acetaminophen", "atenolol", "caffeine", "carbamazepine", "cotinine", "paraxanthine", "venlafaxine", "chloroquine", "desethyl_chloroquine", "hydroxychloroquine")]

correlation_matrix_full <- cor(matrix_full)
correlation_matrix_part <- cor(matrix_part)

View(correlation_matrix_full)
View(correlation_matrix_part)



# Correlation Maps --------------------------------------------------------
# pdf(file = "./figures/correlation_map_full.pdf",  width = 20, height = 20)
tiff(filename = "./figures/correlation_map_full.tiff", width = 4800, height = 4800, res = 280)
pairs.panels(m)
# dev.off()

# pdf(file = "./figures/correlation_map_part.pdf",  width = 12, height = 12)
pairs.panels(mp)
# dev.off()



# Heatmaps ----------------------------------------------------------------
heatmap(correlation_matrix, Colv = NA, Rowv = NA)
heatmap(correlation_matrix, Colv = NA, Rowv = NA, scale = "column")



# Pairwise Correlations ---------------------------------------------------
cor(d$confirmed_cases, d$sars_cov_2_virus)
cor(d$acetaminophen, d$sars_cov_2_virus)
cor(d$acetaminophen, d$confirmed_cases)

cor(d$chloroquine, d$desethyl_chloroquine)
cor(d$sulfamethoxazole, d$trimethoprim)