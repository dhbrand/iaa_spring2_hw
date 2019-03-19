library(rstan)
setwd("bayes/")

# Example 1: Eight Schools ####
schools_dat <- list(
  J = 8,
  y = c(28, 8, -3, 7, -1, 1, 18, 12),
  sigma = c(15, 10, 16, 11, 9, 11, 10, 18)
)

fit <- stan(file = "8schools.stan", data = schools_dat)


print(fit)
plot(fit)
pairs(fit, pars = c("mu", "tau", "lp__"))

la <- extract(fit, permuted = TRUE) # return a list of arrays
mu <- la$mu

### return an array of three dimensions: iterations, chains, parameters
a <- extract(fit, permuted = FALSE)

### use S3 functions on stanfit objects
a2 <- as.array(fit)
m <- as.matrix(fit)
d <- as.data.frame(fit)

# Example 2: Rats ####
y <- as.matrix(read.table('https://raw.github.com/wiki/stan-dev/rstan/rats.txt', header = TRUE))
x <- c(8, 15, 22, 29, 36)
xbar <- mean(x)
N <- nrow(y)
T <- ncol(y)
rats_fit <- stan('https://raw.githubusercontent.com/stan-dev/example-models/master/bugs_examples/vol1/rats/rats.stan')

print(rats_fit)

# Example 3: Anything ####
model <- stan_demo()
