functions {
  real[] dpop_dt(
    real t, // time
    real [] pop_init, // initial state {case, virus, treatment}
    real [] theta, // parameters
    real[] x_r, int[] x_i) {  // unused
      real V = pop_init[1];
      real A = pop_init[2];
      real C = pop_init[3];
      real b1 = theta[1];
      real b2 = theta[2];
      real b3 = theta[3];
      real b4 = theta[4];
      real b5 = theta[5];
      real dV_dt = V * (b1 - b2 * A);
      real dA_dt = A * (b3 * V - b4);
      real dC_dt = b5 * V * (b1 - b2 * A);
      return {dC_dt, dV_dt, dA_dt};
  }
}

data {
   int<lower=0> N; // number of measurement times
   real<lower=0> measure[N, 3]; // measurement
}

transformed data {
   real times_measured[N-1]; // except the initial state
   for (i in 2:N)
     times_measured[i-1] = i;
}

parameters {
   real<lower=0> theta[5];
   real<lower=0> pop_init[3];
   real<lower=0> sigma[3];
   // real<lower=0> p[3];
}

transformed parameters {
   real pop[N, 3];
   pop[1, 1] = pop_init[1];
   pop[1, 2] = pop_init[2];
   pop[1, 3] = pop_init[3];
   pop[2:N, 1:3] = integrate_ode_rk45(
    dpop_dt, pop_init, 0, times_measured, theta, rep_array(0.0, 0), rep_array(0, 0), 1e-5, 1e-3, 5e2);
}

model {
   // priors
   theta[{1, 2}] ~ normal(1, 0.5);
   theta[{3, 4}] ~ normal(0.05, 0.05);
   theta[5] ~ uniform(0, 1);
   sigma ~ exponential(1);
   pop_init[{1, 2, 3}] ~ lognormal( log(10), 1);
   //p ~ uniform(0.1, 1);
   // p[{1, 2, 3}] ~ beta(40,200);
   //observational model
   // connect latent population state to observed measures
   for (t in 1:N)
     for (k in 1:3) {
       // print("t:", t);
       // print("k:", k);
       // print("pop[t,k]:", pop[t,k]);
       // print("p[k]:", p[k]);
       // print("pop[t,k]*p[k]:", pop[t,k]*p[k]);
       // print("log(pop[t,k]*p[k]):", log(pop[t,k]*p[k]));
       // measure[t, k] ~ lognormal( log(pop[t,k]*p[k]), sigma[k] );
       measure[t, k] ~ lognormal( log(pop[t,k]), sigma[k] );
     }
}

generated quantities {
   real measure_pred[N, 3];
   for (t in 1:N)
     for(k in 1:3)
       // measure_pred[t, k] = lognormal_rng(log(p[k] * pop[t, k]), sigma[k]);
       measure_pred[t, k] = lognormal_rng(log(pop[t, k]), sigma[k]);
   //  measure_pred[t, k] = lognormal_rng(log(p[k] * pop[t, k]), sigma[k]);
   //  measure_pred[t, 2] = lognormal_rng(log(p[k] * pop[t, 2]), sigma[2]);
   //  measure_pred[t, 3] = lognormal_rng(log(p[k] * pop[t, 3]), sigma[3]);
}