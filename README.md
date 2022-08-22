# Wastewater Based Epidemiology

## Goals
This project aims to predict COVID-19 confirmed cases by previous confirmed cases, concentration of virus gene copies and other chemicals in wastewater. The data was collected in Suffolk County, NY, USA from mid 2020 to begining of 2021.


## Data Preprocessing
Since variables might have different units, in order to compare, we adjust their scales for all the following analysis. All variables of interest suggested by the correlation plots and prior knowledge (see [Data Exploration](#data-exploration)) are standardized into positive values. See the final part of script [01_load_data.R](./code/01_load_data.R) for details.


## Data Exploration
For correlations between variables, see file [02_plot_correlations.R](./code/02_plot_correlations.R), figures [correlation_map_full.pdf](./figures/correlation_map_full.pdf) and [correlation_map_part.pdf](./figures/correlation_map_part.pdf). Correlation plots together with prior knowledge indicate strong correlations between our variables of interest, which are: 

1. Confirmed Case
2. Virus
3. Acetaminophen
4. Nicotine
5. Paraxanthine
6. Hydroxychloroquine
7. Desethyl Hydroxychloroquine

We plot time series of these variables to further see if they have similar trends over time. Not all pairs of them show consistent patterns, but we keep them all for now and determine which to retain in our model selection process.


## Models
We fit three sets of model:

1. Autoregressive Distributed Lag (ADL) models
2. Distributed Lag (ADL) models
3. Vector Autoregressive Models and their corresponding Impulse Response Functions.

ADL models regress our dependent variable (Confirmed Case) on its own lags and the lags of other independent variables. Specifically, the models have the following form:

$Y_t = \alpha + \beta_0 \sum_{i=1}^{p} Y_{t-i} + \sum_{k=1}^{p} (\beta_k \sum_{i=1}^{q} X_{k, t-i}) + \epsilon_t$

DL models are just similar to ADL without the lagged dependent variable. The form for a typical model is

$Y_t = \alpha + \sum_{k=0}^{p} (\beta_k \sum_{i=1}^{q} X_{k, t-i}) + \epsilon_t$

(VAR and IRF to be added soon ...)


## Stationarity in Time Series
(To be added I promise ...)


## Model Selection
To decide which variables to include into the above models, we use [Akaike information Criterion (AIC)](https://en.wikipedia.org/wiki/Akaike_information_criterion) as our rule of thumb. Two general rules are applied when selecting the models. First, we use consecutive lags. Second, to avoid overfitting, we maintain at least 10 observations for each predictor included in the models. For other details, please see file [04_select_model.R](./code/04_select_model.R).


## Predictions
See [prediction_ADL_lag3.pdf](./figures/prediction_ADL_lag3.pdf) and [prediction_DL_lag5.pdf](./figures/prediction_DL_lag5.pdf) for now. 

(Explanation will be added ....)