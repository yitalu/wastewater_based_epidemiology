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