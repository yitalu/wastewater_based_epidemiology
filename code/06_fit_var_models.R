# This script fits the vector autoregressive models, considering all variables as a system with mutual influence.



# Load Package and Data ---------------------------------------------------
library("vars")
source(file = "./code/01_load_data.R")

lag_length <- 3
fit_var_cvn <- VAR(cbind(c, v, n), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
summary(fit_var_cvn)

lag_length <- 5
fit_var_cvdh <- VAR(cbind(c, v, dh), p = lag_length, type = c("const"), season = NULL, exogen = NULL)
summary(fit_var_cvdh)