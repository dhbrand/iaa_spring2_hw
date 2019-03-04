# Isolation Forests #
df <- data.frame(
  inc = ins$Income_Claim,
  pc = ins$Number_Changes
)

inc_for_100 <- iForest(X = df, nt = 100, phi = 5000, seed = 12345, multicore = TRUE)
inc_score_100 <- predict(inc_for_100, newdata = df)

ins_for_500 <- iForest(X = df, nt = 500, phi = 1000, seed = 12345)
ins_score_500 <- predict(ins_for, newdata = df)

hist(ins_score_500)
df$iso_score <- inc_score_100

plot(pc ~ inc,
     data = df, cex = iso_score, pch = 20
)
head(df$iso_score, n=100)
df$outlier <- ifelse(df$iso_score>.8, TRUE, FALSE)
sum(df$outlier)
df$inc[which(df$outlier)]
df$pc[which(df$outlier)]
df$cust_id <- ins$Cust_ID
df$cust_id[which(df$outlier)]
hist(df$pc)
