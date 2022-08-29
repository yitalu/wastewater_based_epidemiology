# Wastewater Based Epidemiology

**[LAST UPDATED: 08.29.2022]**


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

1. Confirmed Case
2. Virus
3. Acetaminophen
4. Nicotine
5. Paraxanthine
6. Hydroxychloroquine
7. Desethyl Hydroxychloroquine

We plot time series of these variables to further see if they have similar trends over time. Not all pairs of them show consistent patterns, but we keep them all for now and leave the judgements of what to retain to the model selection process (section [WHAT]).


## Models
For the purpose introduced in the [Overview](#overview) section, we fit three sets of model:

1. Autoregressive Distributed Lag (ADL) models
2. Distributed Lag (ADL) models
3. Vector Autoregressive Models and their corresponding Impulse Response Functions.

ADL models regress our dependent variable (Confirmed Case) on its own lags and the lags of other independent variables. Specifically, the models have the following form:

$Y_t = \alpha_{0} + \sum_{i=1}^{p} \alpha_i  Y_{t-i} + \sum_{k=1}^{n} (\sum_{j=1}^{q} \beta_{k, j} X_{k, t-j}) + \epsilon_t$

DL models are just similar to ADL without the lagged dependent variable. The form for a typical model is

$Y_t = \alpha_{0} + \sum_{k=1}^{n} (\sum_{j=1}^{q} \beta_{k, j} X_{k, t-j}) + \epsilon_t$

(VAR and IRF to be added soon ...)

Following sections describe 


### ADL Model

### DL Model
*Stationarity in Time Series*
[To be added I promise ...]

### VAR Model


## Model Selection
To decide which variables to include into the above models, we use [Akaike information Criterion (AIC)](https://en.wikipedia.org/wiki/Akaike_information_criterion) as our rule of thumb. Two general rules are applied when selecting the models. First, we use consecutive lags. Second, to avoid overfitting, we maintain at least 10 observations for each predictor included in the models. For other details, please see file [04_select_model.R](./code/04_select_model.R).


## Model Diagnosis

## Predictions
See [prediction_ADL_lag3.pdf](./figures/prediction_ADL_lag3.pdf) and [prediction_DL_lag5.pdf](./figures/prediction_DL_lag5.pdf) for now. 

(Explanation will be added ....)
