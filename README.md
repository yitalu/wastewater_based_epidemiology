# Wastewater Based Epidemiology

**[LAST UPDATED: 08.29.2022; TO BE CONTINUED]**


## Table of contents
- [Overview](#overview)
- [Data Preprocessing](#data-preprocessing)
- [Data Exploration](#data-exploration)
- [Models](#models)
    - [ADL Model](#adl-model)
    - [DL Model](#dl-model)
    - [VAR Model](#var-model)
- [Model Selection](#model-selection)
- [Model Diagnosis](#model-diagnosis)
- [Predictions](#predictions)

---

## Overview
This project aims to predict COVID-19 confirmed cases in an area with previous confirmed cases and wastewater chemicals from the past few days. Two time series models are built and fitted to data collected in Suffolk County, NY, USA from mid 2020 to the begining of 2021. Specifically, the first model allows us to predict current number of confirm case by looking at 1) confirmed cases, 2) concentration of virus gene copies, and 3) nicotine in wastewater from the three previous days. The second model removes the predictor of past confirmed case (and hence the need to record this number) and uses only 1) virus concentration, and 2) Desethyl Hydroxychloroquine from five previous days to achieve the same goal. Both models could potentially give some leeway to the public health authorities and facilitate their policymaking.


## Data Preprocessing
We do two things to pre-process our data. First, in the later steps it appears needs to avoid heteroscedasticity (non-constant variance of error terms) by transforming data (see [CROSS-REFERENCE HERE]). Therefore, we replace 0 confirmed case with value 0.1. Given the scale of the variable and the purpose of forecasting the macro-level outbreak, this shouldn't be a problem.

Since variables have different units, in order to compare, we also adjust their scales for all the following analysis. All variables of interest suggested by the correlation plots and prior knowledge (see [Data Exploration](#data-exploration)) are standardized into positive values. See the Standardize Variables part of the script [01_load_data.R](./code/01_load_data.R) for details.


## Data Exploration
For correlations between variables, see file [02_plot_correlations.R](./code/02_plot_correlations.R), figures [correlation_map_full.pdf](./figures/correlation_map_full.pdf) and [correlation_map_part.pdf](./figures/correlation_map_part.pdf). Correlation plots together with prior knowledge indicate strong correlations between our variables of interest, which are: 

1. Confirmed Case ($C_t$)
2. Virus ($V_t$)
3. Acetaminophen ($A_t$)
4. Nicotine ($N_t$)
5. Paraxanthine ($P_t$)
6. Hydroxychloroquine ($H_t$)
7. Desethyl Hydroxychloroquine ($DH_t$)

We plot time series of these variables to further see if they have similar trends over time. Not all pairs of them show consistent patterns, but we keep them all for now and leave the judgements of what to retain to the model selection process (section [WHAT]).


## Cross Correlations
We look at cross correlations between Confirmed Case and (1) Virus Concentration, (2) Acetaminophem, and (3) DesethylHydroxychloroquine. That is, if there is any lead time between any of the three variables and the Confirmed Case. Results are presented in figures [Cross Correlation with Virus](./figures/cross_correlation_case_virus.pdf), [Cross Correlation with Acetaminophem](./figures/cross_correlation_case_acetaminophem.pdf), and [Cross Correlation with DesethylHydroxychloroquine](./figures/cross_correlation_case_DesethylHydroxychloroquine.pdf), respectively. From these plots specifically, DesethylHydroxychloroquine seems to be a good indicator for early warning of cases outbreak.


## Models
For the purpose introduced in the [Overview](#overview) section, we fit three sets of model:

1. Autoregressive Distributed Lag (ADL) models
2. Distributed Lag (ADL) models
3. Vector Autoregressive Models and their corresponding Impulse Response Functions.

The following sections describe details specific to each model.


### *ADL Model*
ADL models regress our dependent variable (Confirmed Case) on its own lags and the lags of other independent variables. Specifically, the models have the following form:

$Y_t = \alpha_{0} + \sum_{i=1}^{p} \alpha_i  Y_{t-i} + \sum_{k=1}^{n} (\sum_{j=1}^{q} \beta_{k, j} X_{k, t-j}) + \epsilon_t$

In our case then, applying the procedure in the [Model Selection](#model-selection) section, we regress confirmed case at time t on past confirm case, virus, and nicotine. In particular,

$C_{t} = \alpha_{0} + \sum_{i=1}^{3} \alpha_i  C_{t-i} + \sum_{j=1}^{3} \beta_{V, j} V_{t-j} + \sum_{j=1}^{3} \beta_{N, j} N_{t-j}$.

The above model gives us the smallest AIC score and past most of the standard diagnosis tests. Error terms are normally distributed and not serially correlated. It appears to have slight heteroscedasticity, but this might be caused by the fact that extreme values are relatively few that we are not able to overcome. As a heap-up, the estimator might be inefficient (which means we could have better prediction due to data quality improvement) and the forecast could be a little volatile at extreme values. Nevertheless, the overall performance of the model should be fine as the estimator is still unbiased.



*Stationarity in Time Series:* Typically, a time series grows over time and fluctuate seasonally (e.g., the growth of stock market index). Since those trend and cycle are not what we are interested in generally, stationary or differenced series is used in time series analysis. In our case, however, there is no apparent trend and cycle in our series $C_t$ (this is confirmed by the *decompose* function in R). All we care about is the original pattern of confirmed cases over time. Since differencing effectively remove information from our series, we analyze our series *at level* for the ADL model. 


### *DL Model*
DL models are just similar to ADL without the lagged dependent variable. The form for a typical model is

$Y_t = \alpha_{0} + \sum_{k=1}^{n} (\sum_{j=1}^{q} \beta_{k, j} X_{k, t-j}) + \epsilon_t$

and the selected model (see [Model Selection](#model-selection)) we fit is 

$C_{t} = \alpha_{0} + \sum_{j=1}^{3} \beta_{V, j} V_{t-j} + \sum_{j=1}^{3} \beta_{DH, j} DH_{t-j}$.


*Box-Cox Transformation:* We do a Box-Cox transformation [^1] to reduce the heteroscedasticity. 

*Differencing the Series* Since the model we first fitted suffers from residual autocorrelation and this could result a larger predictive interval (inefficient), we difference the series once.


### *VAR Model*
[VAR AND IRF HERE]

[TO BE ADDED I PROMISE ...]







## Model Selection
To decide which variables to include into the above models, we use [Akaike information Criterion (AIC)](https://en.wikipedia.org/wiki/Akaike_information_criterion) as our rule of thumb. Two general rules are applied when selecting the models. First, we use consecutive lags. Second, to avoid overfitting, we maintain at least 10 observations for each predictor included in the models. We exhaust all combinations of variables and select the model with the lowest AIC score. For other details, please see file [04_select_model.R](./code/04_select_model.R).


## Model Diagnosis

[Stardard tests for autocorrelation, normality, homoskedasticity go here.]


## Predictions
See [prediction_ADL_lag3.pdf](./figures/prediction_ADL_lag3.pdf) and [prediction_DL_lag5.pdf](./figures/prediction_DL_lag5.pdf) for now. 


[EXPLANATION WILL BE ADDED ....]



[^1]: Box, G. E. P., & Cox, D. R. (1964). An analysis of transformations. *Journal of the Royal Statistical Society. Series B, Statistical Methodology, 26*(2), 211–252.