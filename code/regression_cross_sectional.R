source("./code/load_data.R")
library(dagitty)

# DAGs and Implied Conditional Independencies -----------------------------
drug_dag <- dagitty('dag{ V -> C -> A <- V }')
impliedConditionalIndependencies(drug_dag)
# no independency for this DAG

m1 <- lm(d$confirmed_cases ~ d$sars_cov_2_virus)
summary(m1)

m2 <- lm(d$confirmed_cases ~ d$acetaminophen)
summary(m2)

m3 <- lm(d$acetaminophen ~ d$sars_cov_2_virus)
summary(m3)

m4 <- lm(d$acetaminophen ~ d$confirmed_cases)
summary(m4)

m5 <- lm(d$sars_cov_2_virus ~ d$acetaminophen)
summary(m5)

m6 <- lm(d$sars_cov_2_virus ~ d$confirmed_cases)
summary(m6)

summary( lm(d$confirmed_cases ~ d$sars_cov_2_virus + d$acetaminophen))