library(rstan)

ex1_data=list(n=100, y=29, prior_p=c(0,1))

ex1_fit <- stan('Example1.stan', data=ex1_data)

ex1_post <- extract(ex1_fit)

summary(ex1_post$p)

plot(ex1_post$p, type='l')

hist(ex1_post$p)

quantile(ex1_post$p, c(0.025, 0.975))
