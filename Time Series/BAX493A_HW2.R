library(readxl)
library("forecast")
library("tseries")

#setwd("C:/Users/user/Desktop")
data <- read_excel("2020_Covid_Data.xlsx")

names(data)

# Get assigned state data
NYC <- data$NYC

# remove the grand total and data from 2021
NYC <- head(data$NYC, 345)

# Convert data to time series
NYC.cases <- ts(NYC, frequency = 366, start = c(2020,22))

# plot
plot(NYC.cases)


######################################### Check if stationary ##########################################
# Use Augmented Dickey-Fuller Test to test stationarity == > large p-value (> 0.10) means non-stationary

adf.test(NYC.cases)
# p = 0.2861, larger than 0.1, indicating non-stationary


# Take the first difference
y1 <- diff(NYC.cases, differences = 1)
plot.ts(y1)
adf.test(y1)
# p = 0.8981, larger than 0.1, still indicating non-stationary


# Take the second difference
y2 <- diff(NYC.cases, differences = 2)
plot.ts(y2)
adf.test(y2)
# p = 0.01, smaller than 0.1, indicating stationary, fix d = 2 in ARIMA models to be fitted


## Decide AR(p) or MA(q) or both ARMA(p,q). Use the stationary series from Step 1. 
# Check for p: number of AR lags needed for the model using partial autocorrelation
Pacf(y2, lag.max = 10) # spikes at lag = 7, suggests p to be 7

# Check for q: moving average lag terms appropriate for the model
Acf(y2, lag.max = 10) # spikes at lag = 3, suggests q to be 3


## From adf, pacf, acf tests, (7, 2, 3) of (p, d, q) is suggested ##
model <- Arima(NYC.cases, order = c(7,2,3))
summary(model) # MAPE = 3.13

## Information criteria
(AICc_model <- model$aicc) # 5932.931
(BIC_model <- model$bic) # 5974.348

# Still go ahead and use auto ARIMA

################################## Auto ARIMA model ##################################

## Initial model
m0 <- auto.arima(NYC.cases)
summary(m0) ## Model suggests p = 2, d = 2, q = 2, and MAPE = 3.21

## Information criteria
(AICc_0 <- m0$aicc) # 5928.15
(BIC_0 <- m0$bic)  # 5947.161

## h = 41, since 41 days from 1/1/2021 to 2/10/2021
auto_forecast_0 <- forecast:::forecast.Arima(m0, h = 41, level = c(95))
plot(auto_forecast_0)
summary (auto_forecast_0)


## Fit ARIMA models +/- 1 in the neighborhood of (p = 2, q = 2) found from auto.arima
## Keep d = 2 fixed and change only if needed
## ARIMA(p, d, q)

# Model 1
m1 <- Arima(NYC.cases, order = c(1,2,2))
summary(m1) # MAPE = 3.155

## Information criteria
(AICc_1 <- m1$aicc) # 5939.868
(BIC_1 <- m1$bic) # 5955.101


# Model 2
m2 <- Arima(NYC.cases, order = c(3,2,2))
summary(m2) # MAPE = 3.234

## Information criteria
(AICc_2 <- m2$aicc) # 5927.494
(BIC_2 <- m2$bic) # 5950.271


# Model 3
m3 <- Arima(NYC.cases, order = c(2,2,1))
summary(m3) # MAPE = 3.00

## Information criteria
(AICc_3 <- m3$aicc) # 5949.348
(BIC_3 <- m3$bic) # 5964.581


# Model 4
m4 <- Arima(NYC.cases, order = c(2,2,3))
summary(m4) # MAPE = 3.219

## Information criteria
(AICc_4 <- m4$aicc) # 5928.974
(BIC_4 <- m4$bic) # 5951.75


# Model 5
m5 <- Arima(NYC.cases, order = c(1,2,1))
summary(m5) # MAPE = 3.020

## Information criteria
(AICc_5 <- m5$aicc) # 5964.727
(BIC_5 <- m5$bic) # 5976.169


## Compare models based on information criteria
aicc.out <- cbind(AICc_0, AICc_1, AICc_2, AICc_3, AICc_4, AICc_5)
(aicc.diff <- aicc.out - min(aicc.out))
# m2 is competitive with m0 according to AIC_c, due to our sample size, we focus on AICc

bic.out <- cbind(BIC_0, BIC_1, BIC_2, BIC_3, BIC_4, BIC_5)
(bic.diff <- bic.out - min(bic.out))
# m2 is competitive with m0 according to BIC as well


m2_forecast <- forecast:::forecast.Arima(m2, h = 41, level = c(95))
plot(m2_forecast)

summary(m2_forecast) # MAPE: 3.234



# Consensus Forecast (aka forecasts combination)
ybar0 <- auto_forecast_0$mean # auto.arima forecast
ybar2 <- m2_forecast$mean # m1 based forecast

ybar.avg <- (ybar0 + ybar2)/2					# consensus forecast

# Also need to find prediction intervals for consensus forecasts. First find variances and then average the variances.

low0 <- auto_forecast_0$lower
var0 <- ((ybar0 - low0[1:41])/1.96)^2 			# b/c yhat - (yhat - 1.96 x se) gives 1.96 x se

low4 <- m2_forecast$lower
var2 <- ((ybar2 - low4[1:41])/1.96)^2 

var.avg <- (var0[1:41] + var2[1:41])/2				# averaged variance



# Step 6. Provide Prediction Intervals for Consensus Forecasts

lo68 <- ybar.avg - 1 * sqrt(var.avg)				# 1 SD (68% confidence)
hi68 <- ybar.avg + 1 * sqrt(var.avg)


lo95 <- ybar.avg - 1.96 * sqrt(var.avg)			# 2 SD (95% confidence)
hi95 <- ybar.avg + 1.96 * sqrt(var.avg)

final.out <- cbind(ybar.avg, lo68, hi68, lo95, hi95)

final.out

