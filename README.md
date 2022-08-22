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


## Predictions

