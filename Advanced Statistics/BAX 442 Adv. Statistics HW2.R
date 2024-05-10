library(readxl)
library(tidyverse)


preference_rank_tp = read_excel("preference_rank_tp.xlsx")
head(preference_rank_tp, 5)


ranks = preference_rank_tp[, c(1, 4, 7, 10, 13)]
head(ranks, 5)


design_matrix = read_excel("design_matrix.xlsx")
head(design_matrix, 10)


if(is.list(design_matrix)) {
  design_matrix_df <- as.data.frame(design_matrix)
  # check the structure to ensure it's a dataframe
  str(design_matrix_df)
}


x = design_matrix_df %>%
  rename("screen_75" = "Screen 75 inch") %>%
  rename("screen_85" = "Screen 85 inch") %>%
  rename("is_4k" = "Resolution 4K = 1") %>%
  rename("is_sony" = "Sony = 1") %>%
  rename("price_is_hi" = "Price \r\n(low = 0; high =1)")

head(x, 5)


## Fit the model
# Use the first column in preference rank as y1
y1 = ranks$Vivienne_PreferenceRank
lm = lm(y1 ~ screen_75 + screen_85 + is_4k + is_sony + price_is_hi, data = x)
summary(lm)$coef


## Bootstrap

### Residual Bootstrap
wtp = function(y, x) {
  # bootstrap
  out = lm(y ~ ., data = x)
  nn = nrow(x)
  yhat = predict(out)
  rr = out$resid
  bb = 1000
  coef.out = matrix(0, bb, length(coef(out)))
  wtp_values = matrix(0, bb, 4)
  
  for(ii in 1:bb) {
	ystar = yhat + rr[sample(nn, nn, replace = TRUE)]
	out.star = lm(ystar ~ ., data = x)						
	coef.out[ii, ] = coef(out.star)
	
	per_util = 500 / abs(coef.out[ii, 6]) 
  wtp_screen_75 = coef.out[ii, 2] * per_util
  wtp_screen_85 = coef.out[ii, 3] * per_util
  wtp_4k = coef.out[ii, 4] * per_util
  wtp_sony = coef.out[ii, 5] * per_util
  
  wtp_values[ii, ] = c(wtp_screen_75, wtp_screen_85, wtp_4k, wtp_sony)
  }
  
  results = matrix(0, 3, 4)
  colnames(results) = c("screen_75", "screen_85", "4K", "Sony")
  rownames(results) = c("2.5%", "97.5%", "mean")
  
  for(i in 1:4) {
    results[1, i] = quantile(wtp_values[, i], probs = 0.025)
    results[2, i] = quantile(wtp_values[, i], probs = 0.975)
  }
  results[3, ] = colMeans(wtp_values)
  
  return(results)
}

wtp(y = ranks$Vivienne_PreferenceRank, x = design_matrix_df)

### Data Bootstrap
wtp2 = function(y, x) {
  x$y = y
  nn = nrow(x)
  bb = 1000
  coef.out2 = matrix(0, bb, length(coef(lm(y ~ ., data = x))))
  wtp_values = matrix(0, bb, 4)
  
  for(ii in 1:bb) {
    data.star = x[sample(nn, nn, replace = TRUE), ]
    out.star = lm(y ~ ., data = data.star)
    coef.out2[ii, ] = coef(out.star)
    
    per_util = 500 / abs(coef.out2[ii, 6]) 
    wtp_screen_75 = coef.out2[ii, 2] * per_util
    wtp_screen_85 = coef.out2[ii, 3] * per_util
    wtp_4k = coef.out2[ii, 4] * per_util
    wtp_sony = coef.out2[ii, 5] * per_util
    
    wtp_values[ii, ] = c(wtp_screen_75, wtp_screen_85, wtp_4k, wtp_sony)
  }
  
  results = matrix(0, 3, 4)
  colnames(results) = c("screen_75", "screen_85", "4K", "Sony")
  rownames(results) = c("2.5%", "97.5%", "mean")
  
  for(i in 1:4) {
    results[1, i] = quantile(wtp_values[, i], probs = 0.025)
    results[2, i] = quantile(wtp_values[, i], probs = 0.975)
  }
  results[3, ] = colMeans(wtp_values)
  
  return(results)
}


wtp2(y = ranks$Vivienne_PreferenceRank, x = design_matrix_df)


-----------

# Vivi
wtp(y = ranks$Vivienne_PreferenceRank, x = design_matrix_df)
wtp2(y = ranks$Vivienne_PreferenceRank, x = design_matrix_df)

# Leo
wtp(y = ranks$Leo_PreferenceRank, x = design_matrix_df)
wtp2(y = ranks$Leo_PreferenceRank, x = design_matrix_df)

# Meitong
wtp(y = ranks$Eva_PreferenceRank, x = design_matrix_df)
wtp2(y = ranks$Eva_PreferenceRank, x = design_matrix_df)

# Aditya
wtp(y = ranks$Aditya_PreferenceRank, x = design_matrix_df)
wtp2(y = ranks$Aditya_PreferenceRank, x = design_matrix_df)

# Abby
wtp(y = ranks$Abby_PreferenceRank, x = design_matrix_df)
wtp2(y = ranks$Abby_PreferenceRank, x = design_matrix_df)

