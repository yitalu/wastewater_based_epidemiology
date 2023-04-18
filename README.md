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
  - [Prior Predictive Simulations](#prior-predictive-simulations)
  - [MCMC Diagnostics](#mcmc-diagnostics)
  - [Posterior Distributions and Coefficient Intervals](#posterior-distributions-and-coefficient-intervals)

---
</br>

## Overview
This project aims to predict COVID-19 confirmed cases in an area by wastewater chemicals from the past few days. Three Bayesian models are built and fitted to data collected in Suffolk County, NY, USA from mid 2020 to the beginning of 2021. The first model uses the concentration of virus gene copies from the past ten days to predict the current number of confirmed case. The second model allows us to make the same prediction by looking at 1) virus concentration and 2) Desethyl-Hydroxychloroquine in the past five days. The third model shortens the recording window to three days without losing accuracy too much by adding Acetaminophen as a third predictor. These models can provide public health authorities with additional information and assist their policymaking.

</br>


## Data Preprocessing
Except for the variable Confirmed Case, all other variables are adjusted in the following ways for the ease of modeling or interpretation. First, virus concentration is log-transformed with base 10. Rather than standardizing, all predictor variables suggested by the correlation plots and prior knowledge (see [Data Exploration](#data-exploration)) are divided by their maximum value in the sample and rescaled into values between 0 and 1. This way, we retain zero as a reference point while being able to make sense of the priors across variables in our modeling. See the script [01_load_data.R](./code/01_load_data.R) for details.

</br>


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

</br>


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

For each set of models, we test possible combinations of variables according to [Data Exploration](#data-exploration) and [Cross Correlation](#cross-correlations). The posterior distributions of the parameters are estimated using Markov chain Monte Carlo (MCMC), and we retain the model with the best predictive performance based on the [Watanabe–Akaike Information Criterion (WAIC)](https://en.wikipedia.org/wiki/Watanabe–Akaike_information_criterion). See file [06_model.R](./code/06_model.R) for further details. In general, the convergence of the MCMC appears healthly based on the [diagnostic details](#mcmc-diagnostics), including potential scale reduction factor (PSRF, or $\hat{R}$), effective sample size (ESS), trace plots, and trace rank plots.

Two general rules are also applied in the modeling. First, we use consecutive lags because the change of predictor variables is more likely to have gradual effects on our outcome variable. Second, to avoid overfitting, we maintain at least ten observations for each predictor included in the models. Since we have about 100 observations in our sample, the numbers of predictors do not exceed 10. The following sections describe details of the best-performing model in each model set. For the choice of priors, please refer to the [Prior Predictive Simulations](#prior-predictive-simulations) section. The posterior distributions of parameters and their 95% intervals can be found in [Posterior Distributions and Coefficient Intervals](#posterior-distributions-and-coefficient-intervals).

### M-110s

M-110s regress the current Confirmed Case on ten lags of a single predictor variable. Four candidate substances are considered: 1) Virus, 2) Acetaminophen, 3) Desethyl-Hydroxychloroquine, and 4) Nicotine. The Virus model has the lowest WAIC score and has the following form: 

$$C_t \sim Binomial(3.3\times 10^5, \space p)$$

$$logit(p) = \alpha + \sum_{j=1}^{10} \beta_{Vj} V_{t-j}$$

$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Vj} \sim Normal(0.5, \space 0.5)$$

[Figure 1](./figures/prediction_m110_v10.pdf) shows the posterior prediction by this model.

### M-205s

M-205s regress the current Confirmed Case on five lags of two predictor substances. The model with Virus concentration and Desethyl-Hydroxychloroquine: 

$$C_t \sim Binomial(3.3\times 10^5, \space p)$$

$$logit(p) = \alpha + \sum_{j=1}^{5} (\beta_{Vj} V_{t-j} + \beta_{DHj} DH_{t-j})$$

$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Vj}, \space \beta_{DHj} \sim Normal(0.5, \space 0.5)$$

has the best performance. [Figure 2](./figures/prediction_m205_v5dh5.pdf) shows the posterior prediction by this model.

### M-303s

M-303s regress the current Confirmed Case on three substances, each with three lags. The best model uses 1) Virus, 2) Desethyl-Hydroxychloroquine, and 3) Acetaminophen as predictors and has the following form:

$$C_t \sim Binomial(3.3\times 10^5, \space p)$$

$$logit(p) = \alpha + \sum_{j=1}^{3} (\beta_{Vj} V_{t-j} + \beta_{DHj} DH_{t-j} + \beta_{Aj} A_{t-j})$$

$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Vj}, \space \beta_{DHj}, \space \beta_{Aj} \sim Normal(0.5, \space 0.5)$$

[Figure 3](./figures/prediction_m303_v3dh3a3.pdf) shows the posterior prediction of this model.

</br>


## Model Validation

We use an additional dataset to validate our model. The data is collected from January 2022 onward and consists of 39 observations. However, since only confirmed case and virus concentration were recorded, we are only able to validete our first model --- prediction solely by virus concentration.

[Figure 4](./figures/prediction_m110_v10_validate.pdf) shows the result. We use virus concentrations from this new dataset as inputs to predict confirmed cases in the same period. The shaded area in the graph indicates that the model captures the epidemic trend quite well, except around the peak range. The difference between the predicted and actual values around the peak area might be due to measurement errors or other human factors. Without further information, it is not easy to identify the source of this difference. Nonetheless, considering the model can be calibrated by new datasets and its purpose for out-sample prediction, it should be exemplary for future use.

</br>


## Appendix

### Prior Predictive Simulations
Common priors are applied to all parameters to regularize our estimate. The choice of priors is based on their resulted confirmed case distributions. For a specific set of priors, we calculate its infection probabilities (by taking the inverse logit of the linear combination of parameters) and the simulated confirmed cases (via a binomial process) under different distributions of virus concentration. Refer to [05_simulate_priors.R](./code/05_simulate_priors.R) for how this is performed in R. As a result, the following set of priors is chosen:
$$\alpha \sim Normal(-10, \space1)$$

$$\beta_{Xj} \sim Normal(0.5, \space 0.5)$$


Here, we show how infection probability and confirmed case are distributed under three cases of virus distributions.

</br>

***Case 1*: virus concentration distributed uniform**

$$V \sim Uniform(0, \space 1)$$

Distribution of Infection Probability ([Density Plot](./figures/prior_prediction_prob_uniform.pdf))
| Min.      | 1st. Qu.  | Median    | Mean      | 3rd Qu.   | Max.      |
|-----------|-----------|-----------|-----------|-----------|-----------|
| 0.0000016 | 0.0001322 | 0.0004810 | 0.0048370 | 0.0021727 | 0.4947711 |

Distribution of Confirmed Case ([Density Plot](./figures/prior_prediction_case_uniform.pdf))
| Min. | 1st. Qu. | Median | Mean | 3rd Qu. | Max.   |
|------|----------|--------|------|---------|--------|
| 0    | 44       | 158    | 1596 | 715     | 163123 |

</br>
</br>

***Case 2*: virus concentration at the maximum**

$$V \sim Uniform(1, \space 1)$$

Distribution of Infection Probability ([Density Plot](./figures/prior_prediction_prob_max.pdf))
| Min.      | 1st. Qu.  | Median    | Mean      | 3rd Qu.   | Max.      |
|-----------|-----------|-----------|-----------|-----------|-----------|
| 0.0000094 | 0.0019102 | 0.0067741 | 0.0264734 | 0.0227059 | 0.8991982 |


Distribution of Confirmed Case ([Density Plot](./figures/prior_prediction_case_max.pdf))
| Min. | 1st. Qu. | Median | Mean | 3rd Qu. | Max.   |
|------|----------|--------|------|---------|--------|
| 2    | 627      | 2240   | 8736 | 7501    | 296497 |

</br>
</br>

***Case 3*: virus concentration at the minimum**

$$V \sim Uniform(0, \space 0)$$

Distribution of Infection Probability ([Density Plot](./figures/prior_prediction_prob_min.pdf))
| Min.      | 1st. Qu.  | Median    | Mean      | 3rd Qu.   | Max.      |
|-----------|-----------|-----------|-----------|-----------|-----------|
| 9.011e-07 | 2.306e-05 | 4.538e-05 | 7.407e-05 | 8.776e-05 | 1.576e-03 |


Distribution of Confirmed Case ([Density Plot](./figures/prior_prediction_case_min.pdf))
| Min. | 1st. Qu. | Median | Mean  | 3rd Qu. | Max.   |
|------|----------|--------|-------|---------|--------|
| 0.00 | 7.00     | 15.00  | 24.52 | 30.00   | 542.00 |


</br>
</br>

### MCMC Diagnostics


#### M-110s: Virus
[$\hat{R}$ and ESS](./tables/coefficients_m110_v10.csv)

[Trace plot](./figures/trace_plot_m110_v10.pdf)

[Rank plot](./figures/rank_plot_m110_v10.pdf)



#### M-205s: Virus, DHCQ
[$\hat{R}$ and ESS](./tables/coefficients_m205_v5dh5.csv)

[Trace plot](./figures/trace_plot_m205_v5dh5.pdf)

[Rank plot](./figures/rank_plot_m205_v5dh5.pdf)


#### M-303s: Virus, Acetaminophen, DHCQ
[$\hat{R}$ and ESS](./tables/coefficients_m303_v3a3dh3.csv)

[Trace plot](./figures/trace_plot_m303_v3a3dh3.pdf)

[Rank plot](./figures/rank_plot_m303_v3a3dh3.pdf)

</br>
</br>

### Posterior Distributions and Coefficient Intervals

#### M-110s: Virus
[Distributions](./figures/posterior_distributions_m110_v10.pdf)

[Coefficient Intervals](./figures/posterior_intervals_m110_v10.pdf)


#### M-205s: Virus, DHCQ
[Distributions](./figures/posterior_distributions_m205_v5dh5.pdf)

[Coefficient Intervals](./figures/posterior_intervals_m205_v5dh5.pdf)


#### M-303s: Virus, Acetaminophen, DHCQ
[Distributions](./figures/posterior_distributions_m303_v3a3dh3.pdf)

[Coefficient Intervals](./figures/posterior_intervals_m303_v3a3dh3.pdf)
