data {
         int<lower=0> n;                 // number of observations
         int<lower=0> y[n];           // observed number of hurricanes
         real prior_lamb[2];            // prior info for lambda
       }
       parameters {
         real <lower=0> lamb;
       }
       model {
         lamb ~ uniform (prior_lamb[1], prior_lamb[2]);
         for (i in 1:n)
         y[i]~ poisson(lamb);
       }
