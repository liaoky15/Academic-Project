library(MASS)
library(ggplot2)
library(matrixStats)

## Load data
data <- read.csv("Gillette_data.csv")

## Check for column names
colnames(data)

## Create variables
Year <- data$year
m <- data$Margin
k <- data$Sales_Multiple
lag.Rev <- data$Lag.Revenues
rev <- data$Revenues
root.Ad <- data$Sqrt_Advtg
rho <- 0.062 ## Paper mentions average discount rate = 6.2%

## Plot target variable against time
plot(data$year, root.Ad)

## Put target variables Profit margin and Deal attractiveness in df

df0 <- as.data.frame(cbind(m,k))

################# Linear model to estimate ad effectiveness and the carryover effect #################

## R(t) = beta * sqrt(Ad(t)) + lambda * R(t-1)

m0 <- lm(rev ~ root.Ad + lag.Rev - 1)
summary(m0)

cov.lm <- vcov(m0)
se <- sqrt(diag(cov.lm))

beta <- unname(coef(m0)[1]) ## Get Ad effectiveness
lambda <- unname(coef(m0)[2]) ## Get Carryover effect

delta <- 1 - lambda ## As mentioned in the paper lambda = 1 - delta

# A = beta / (2*(rho + delta + theta))
# B = beta * theta / (2*(rho + delta + theta))

## model: root.Ad = beta * m/(2*(rho + delta + theta)) + beta * theta * k / (2*(rho + (1-lambda) + theta)))

########### Fit non-linear model #########

m1 <- nls(root.Ad ~ (beta / (2*(rho + (1-lambda) + theta))) * m + (beta * theta / (2*(rho + (1-lambda) + theta))) * k,
          data = df0,
          start = list(theta = 0.05),
          control = nls.control(maxiter = 1000))


summary(m1)

theta <- unname(coefficients(m1)) ## Get theta mean. estimate indicates acquisition hazard = ~6%

## Get confidence intervals for theta
CI.m1 <- confint(m1, level = 0.95) 	# 95% CI
print(round(CI.m1, digits = 4)) ## Theta is significant since CI does not contain 0

yhat1 <- predict(m1)					# predicted root ad $
rho1 <- cor(root.Ad, yhat1) 				# correlation b/w actual and predicted root ad $
print(rho1)

## Plot Actual and Predicted Model
plot(Year, root.Ad)
lines(Year, yhat1, lty = 2, col = "red", lwd = 3)


## Create the variance-covariance matrix for Monte Carlo Simulation
cov.nls <- vcov(m1)

cov.mc <- matrix(0, nrow = 3, ncol = 3)

cov.mc[1:2, 1:2] <- cov.lm
cov.mc[3,3] <- cov.nls


################ Monte Carlo simulation to estimate 95% intervals for A = f(theta) and B= f(theta) ########

# A = beta / (2*(rho + delta + theta))
# B = beta * theta / (2*(rho + delta + theta))

## root.Ad = A * m + B * k

set.seed(123)

n <- 1000

mu <- matrix(c(beta, lambda, theta), nrow = 3, ncol = 1) ## Mean values of estimates
Sigma <- cov.mc ## Variance covariance matrix

b.out <- mvrnorm(n = n, mu, Sigma)

A <- b.out[,1]/ (2*(rho + (1-b.out[,2]) + b.out[,3]))
B <- b.out[,1] * b.out[,3] / (2*(rho + (1-b.out[,2]) + b.out[,3]))

estimates <- cbind(A,B)

## Plot distributions for A and B

hist(estimates[,1])
hist(estimates[,2])

## Get 95% confidence intervals for A and B
y.ci <- colQuantiles(estimates, prob = c(0.025, 0.5, 0.975)) ## Indicates both A and B are significant since CI has no 0
## i.e both Profit margin and Deal attractiveness are significant in determining the amount of $ needed to be spent on advertising

################### Optimal root.Ad spend without possibility of acquisition ############

## from paper, root.Ad = Beta * m/ (2*(rho + delta))
## root.Ad = X * m

## Run Monte Carlo for optimal ad spend without possibility of acquisition

set.seed(123)

n <- 1000

mu <- matrix(c(beta, lambda), nrow = 2, ncol = 1) ## Mean values of estimates
Sigma <- cov.lm ## Variance covariance matrix

b.out1 <- mvrnorm(n = n, mu, Sigma)

X <- b.out1[,1]/(2* (rho + (1 - b.out1[,2])))

ci <- c(quantile(X, c(0.025, 0.5, 0.975)))

root.Ad.without.aq.hat <- ci[2] * m
root.Ad.without.aq.hat_lb <- ci[1] * m
root.Ad.without.aq.hat_ub <- ci[3] * m

df <- data.frame(year = data$year, L = root.Ad.without.aq.hat_lb, 
                 M = root.Ad.without.aq.hat, U = root.Ad.without.aq.hat_ub)

plot(df$year, df$M, 
     ylim = c(min(df$L), max(df$U)), 
     type = "l", 
     xlab = "Year", ylab = "Predicted root.ad optimal",
     main = "Optimal Ad without acquisition" )

polygon(c(df$year, rev(df$year)), c(df$L, rev(df$U)), col = "grey90", border = FALSE) 
lines(df$year, df$M, col = "blue", lwd = 1.5)

par(new = TRUE)								
points(y = data$Sqrt_Advtg, x = df$year, col = "red", pch = "o", cex = 0.75)
par(new = FALSE)

legend("bottomright", legend = c("Forecast", "Actual"), 
       col = c("blue", "red"), lty = c(1, NA), pch = c(NA, "o"), cex = 0.75, bty = "n")

## From the plot, it can be observed that the actual values of the Ad spend are way outside the prediction interval
## This is true for the whole time frame, none of the actual spends falls within the CIs of the no-acquisition strategy
## Hence, the no-acquisition strategy does not adequately describe managers’ decisions over time



########## Optimal root.Ad spend with possibility of acquisition #############

root.Ad.with.aq.hat <- y.ci[1,2] * m + y.ci[2,2] * k
root.Ad.with.aq.hat_lb <- y.ci[1,1] * m + y.ci[2,1] * k
root.Ad.with.aq.hat_ub <- y.ci[1,3] * m + y.ci[2,3] * k

df <- data.frame(year = data$year, L = root.Ad.with.aq.hat_lb, 
                                     M = root.Ad.with.aq.hat, U = root.Ad.with.aq.hat_ub)

plot(df$year, df$M, 
     ylim = c(min(df$L), max(df$U)), 
     type = "l", 
     xlab = "Year", ylab = "Predicted root.ad optimal",
     main = "Optimal Ad with acquisition" )

polygon(c(df$year, rev(df$year)), c(df$L, rev(df$U)), col = "grey90", border = FALSE) 
lines(df$year, df$M, col = "blue", lwd = 1.5)

par(new = TRUE)		# suppreses overwriting of the previous plot							
points(y = data$Sqrt_Advtg, x = df$year, col = "red", pch = "o", cex = 0.75)	# overlays points on the previous plot
par(new = FALSE)

legend("bottomright", legend = c("Forecast", "Actual"), 
       col = c("blue", "red"), lty = c(1, NA), pch = c(NA, "o"), cex = 0.75, bty = "n")

## From the plot, it can be observed that In contrast to no acquisition strategy, 
## the CIs of optimal advertising with acquisition contain actual spends. 
## Eleven out of fourteen observations fall within the CIs of the ad strategy that incorporates the acquisition (from 1990)
## This is especially true after 1990, as the acquisition approaches, the with acquisition formula captures almost 
## all the points within the CI.

## Hence, we can conclude that Gillette managers set their advertising spends 
## taking into account a future possibility of acquisition
