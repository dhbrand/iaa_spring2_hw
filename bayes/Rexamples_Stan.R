
Sys.setenv(USE_CXX14 = 1)
library("rstan")

####It is easiest to run RStan with an external file with model info####

#####First example is looking to estimate the proportion of NC State students who 
####  attend at least one football game in 2018.

#### This is the data.  You need to include data and all prior values needed.
example1.data=list(n=100, y=28,prior_p=c(0,1))

#####Now, we can run the stan code
example1.stan=stan(file='G:\\My Drive\\Bayesian\\Example1.stan',data=example1.data)

###Need to extract posterior samples
post.samp=extract(example1.stan)                  

###Let's take a look at a summary of the posterior distribution

summary(post.samp$p)

####MCMC
plot(post.samp$p,type='l')

####Graph of it

hist(post.samp$p)

###95% probability interval

quantile(post.samp$p,c(0.025,0.975))


########Poisson example
###### Estimating average number of hurricanes per year that hit NC
###     For this example, I am going to simulate the data.
###      25 years worth of number of hurricanes that have hit NC.
y=rpois(25,15)
y
n=25

####Need to list out the data
example2.data=list(y=y,n=n,prior_lamb=c(0,500))

####Run Stan code
example2.stan=stan(file='G:\\My Drive\\Bayesian\\Example2.stan',data=example2.data)

###Get posterior samples
post.samp=extract(example2.stan)

###Summary of posterior samples
summary(post.samp$lamb)

hist(post.samp$lamb)

############Regression example
####Old Faithful data....Length of time of eruptions (minutes); waiting time til next eruption (minutes)

x=faithful$eruptions
y=faithful$waiting

####Can plot the data:

plot(x,y)

n=length(x)
example3.data=list(x=x,y=y,n=n,prior_b0=c(0,500),prior_b1=c(0,500),prior_sigma=c(0,500))
example3.stan=stan(file='G:\\My Drive\\Bayesian\\example3.stan',data=example3.data)
post.samp=extract(example3.stan)

summary(post.samp$b0)
summary(post.samp$b1)
summary(post.samp$sigma)


