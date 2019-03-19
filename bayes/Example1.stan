data {
  int<lower=0> y;           // observed number of "successes"
  int<lower=0> n;           // sample size
  real prior_p[2];            // prior info for p
}
parameters {
  real <lower=0, upper=1> p;
}
model {
  p ~ uniform (prior_p[1], prior_p[2]);
  y~ binomial(n,p);
}
