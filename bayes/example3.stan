data {
         int<lower=0> n;                 // number of observations
         real x[n];                            // length of eruptions
         real y[n];                           // waiting time til next eruption
         real prior_b0[2];            // prior values for b0
         real prior_b1[2];            // prior values for b1
         real prior_sigma[2];     // prior values for sigma
       }
       parameters {
         real b0;
         real b1;
         real <lower=0> sigma;
       }
       model {
         b0~normal(prior_b0[1],prior_b0[2]);
         b1~normal(prior_b1[1],prior_b1[2]);
         sigma~uniform(prior_sigma[1],prior_sigma[2]);
         for (i in 1:n)
         y[i]~ normal(b0+b1*x[i],sigma);
       }
