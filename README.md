# Wastewater Based Epidemiology

**[LAST UPDATED: 03.03.2023; TO BE EDITED]**


- [Overview](#overview)
- [Data Preprocessing](#data-preprocessing)
- [Data Exploration](#data-exploration)
  - [Correlations](#correlations)
  - [Cross Correlations](#cross-correlations)
  - [Temporal Trends](#temporal-trends)
- [Models](#models)
  - [M-110s](#m-110s)
  - [M-205s](#m-205s)
  - [M-303s](#m-303s)
- [Model Validation](#model-validation)
- [Appendix](#appendix)
  - [Prior Predictive Simulation](#prior-predictive-simulation)

---

## Overview
This project aims to predict COVID-19 confirmed cases in an area by wastewater chemicals from the past few days. Three Bayesian models are built and fitted to data collected in Suffolk County, NY, USA from mid 2020 to the beginning of 2021. The first model uses the concentration of virus gene copies from the past ten days to predict the current number of confirmed case. The second model allows us to make the same prediction by looking at 1) virus concentration and 2) Desethyl-Hydroxychloroquine in the past five days. The third model shortens the recording window to three days without losing accuracy too much by adding Acetaminophen as a third predictor. These models can provide public health authorities with additional information and assist their policymaking.




## Data Preprocessing
Except for the variable Confirmed Case, all other variables are adjusted in the following ways for the ease of modeling or interpretation. First, virus concentration is log-transformed with base 10. Rather than standardizing, all predictor variables suggested by the correlation plots and prior knowledge (see [Data Exploration](#data-exploration)) are divided by their maximum value in the sample and rescaled into values between 0 and 1. This way, we retain zero as a reference point while being able to make sense of the priors across variables in our modeling. See the script [01_load_data.R](./code/01_load_data.R) for details.




## Data Exploration

### Correlations
For correlations between variables, see file [02_plot_correlations.R](./code/02_plot_correlations.R), figures [correlation_map_full.pdf](./figures/correlation_map_full.pdf) and [correlation_map_part.pdf](./figures/correlation_map_part.pdf). Correlation plots together with prior knowledge indicate strong correlations between our variables of interest, which are: 

1. Confirmed Case ($C_t$)
2. Virus ($V_t$)
3. Acetaminophen ($A_t$)
4. Nicotine ($N_t$)
5. Paraxanthine ($P_t$)
6. Hydroxychloroquine ($H_t$)
7. Desethyl-Hydroxychloroquine ($DH_t$)

### Cross Correlations
We also look at cross-correlations between Confirmed Cases and (1) Virus Concentration, (2) Acetaminophen, and (3) Desethyl-Hydroxychloroquine. That is, if there is any lead time between the peaks of any of the three variables and the Confirmed Case. Results are presented in figures [Cross Correlation with Virus](./figures/cross_correlation_case_virus.pdf), [Cross Correlation with Acetaminophem](./figures/cross_correlation_case_acetaminophem.pdf), and [Cross Correlation with DesethylHydroxychloroquine](./figures/cross_correlation_case_DesethylHydroxychloroquine.pdf), respectively. From those plots specifically, Desethyl-Hydroxychloroquine seems to be a good indicator for early warning of cases outbreak.

### Temporal Trends
For time series plots of these variables, see [03_plot_time_series.R](./code/03_plot_time_series.R) and figure [trend.pdf](./figures/trend.pdf) as an example. Variables such as Virus and Desethyl-Hydroxychloroquine show similar trends as our outcome variable, Confirmed Case, and are chosen as predictors in our models.




## Models
We regress our dependent variable, Confirmed Case at time t ($C_t$), on lags of the predictor variable(s), $X_{1, \space t-1}$, $X_{1, \space t-2}$, $X_{1, \space t-3}$, ...; $X_{2, \space t-1}$, $X_{2, \space t-2}$, $X_{2, \space t-3}$, ...; $X_{3, \space t-1}$, $X_{3, \space t-2}$, $X_{3, \space t-3}$, ..., etc., via a generalized linear model (GLM). The number of confirmed cases is modeled as a binomial distribution. The trial number equals the population in the area covered by the wastewater station where we collected data ($N = 3.3 \times 10^5$). The probability of individual infection is a logistic function of linear combinations of our predictor variables. The models have the general form: 

$$C_t \sim Binomial(N, \space p)$$

$$logit(p) = \alpha + \sum_{i=1}^{m} (\sum_{j=1}^{n} \beta_{ij} X_{i, t-j})$$

$$\alpha \sim Normal(\bar \alpha, \space \sigma_{\alpha})$$

$$\beta_{ij} \sim Normal(\bar \beta_{ij}, \space \sigma_{\beta_{ij}})$$

Three specific sets of model are considered:

1. M-110s: models with one substance and ten lags (m = 1, n = 10).
2. M-205s: models with two substances and five lags (m = 2, n = 5).
3. M-303s: models with three substances and three lags (m = 3, n = 3).

For each set of models, we test possible combinations of variables according to [Data Exploration](#data-exploration) and [Cross Correlation](#cross-correlations). We retain the model with the best predictive performance based on the [Watanabe–Akaike Information Criterion (WAIC)](https://en.wikipedia.org/wiki/Watanabe–Akaike_information_criterion). See file [06_model.R](./code/06_model.R) for further details. Two general rules are also applied in the modeling. First, we use consecutive lags because the change of predictor variables is more likely to have gradual effects on our outcome variable. Second, to avoid overfitting, we maintain at least ten observations for each predictor included in the models. Since we have about 100 observations in our sample, the number of predictors does not exceed 10. The following sections describe details of the best-performing model in each model set.

### M-110s

M-110s regress the current Confirmed Case on ten lags of a single predictor variable. Four candidate substances are considered: 1) Virus, 2) Acetaminophen, 3) Desethyl-Hydroxychloroquine, and 4) Nicotine. The Virus model has the lowest WAIC score and has the following form: 

$$C_t \sim Binomial(3.3\times 10^5, \space p)$$

$$logit(p) = \alpha + \sum_{j=1}^{10} \beta_{Vj} V_{t-j}$$

$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Vj} \sim Normal(0.5, \space 0.5)$$

[Figure 1](./figures/prediction_m110_v10.pdf) shows the out-sample prediction by this model.

### M-205s

M-205s regress the current Confirmed Case on five lags of two predictor substances. The model with Virus concentration and Desethyl-Hydroxychloroquine: 

$$C_t \sim Binomial(3.3\times 10^5, \space p)$$

$$logit(p) = \alpha + \sum_{j=1}^{5} (\beta_{Vj} V_{t-j} + \beta_{DHj} DH_{t-j})$$

$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Vj}, \space \beta_{DHj} \sim Normal(0.5, \space 0.5)$$

has the best performance. [Figure 2](./figures/prediction_m205_v5dh5.pdf) shows the out-sample prediction by this model.

### M-303s

M-303s regress the current Confirmed Case on three substances, each with three lags. The best model uses 1) Virus, 2) Desethyl-Hydroxychloroquine, and 3) Acetaminophen as predictors and has the following form:

$$C_t \sim Binomial(3.3\times 10^5, \space p)$$

$$logit(p) = \alpha + \sum_{j=1}^{3} (\beta_{Vj} V_{t-j} + \beta_{DHj} DH_{t-j} + \beta_{Aj} A_{t-j})$$

$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Vj}, \space \beta_{DHj}, \space \beta_{Aj} \sim Normal(0.5, \space 0.5)$$

[Figure 3](./figures/prediction_m303_v3dh3a3.pdf) shows the out-sample prediction of this model.

For the choice of priors in above models, please refer to the [Prior Predictive Simulation](#prior-predictive-simulation) section. 




## Model Validation

We use an additional dataset to validate our model. The data is collected from January 2022 onward and consists of 39 observations. However, since only confirmed case and virus concentration were recorded, we are only able to validete our first model --- prediction solely by virus concentration.

[Figure 4](./figures/prediction_m110_v10_validate.pdf) shows the result. We use virus concentrations from this new dataset as inputs to predict confirmed cases in the same period. The shaded area in the graph indicates that the model captures the epidemic trend quite well, except around the peak range. The difference between the predicted and actual values around the peak area might be due to measurement errors or other human factors. Without further information, it is not easy to identify the source of this difference. Nonetheless, considering the model can be calibrated by new datasets and its purpose for out-sample prediction, it should be exemplary for future use.



## Appendix

### Posterior Intervals
### MCMC diagnostics

### Prior Predictive Simulation
[OPTIONAL DETAILS; TO BE ADDED IF NEEDED ... ]

### Trace and Rank plots 