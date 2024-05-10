library(glmnet)

setwd("C:/Users/user/Desktop/UC Davis/WI 24/BAX442 - Advanced Statistics/HW3")
rm(list=ls(all=TRUE)) #clear data
data <- read.csv("Cars_Data.csv", header=T)

y <-  data[,17]
x <-  as.matrix(data[,2:16])
cor_mat = cor(x)


##### Principal Components Analysis #####

out1 <-  eigen(cor_mat)		# eigen decomposition of correlation matrix
va <-  out1$values			# eigenvalues
ve <-  out1$vectors			# eigenvector

# graph scree plot
plot(va, ylab = "Eigenvalues", xlab = "Component Nos")


# find eigenvalues > 1
ego <- va[va > 1]

# find number of factors to retain
nn <- nrow(as.matrix(ego))
nn

out2 <- ve[,1:nn]							# eigenvectors associated with the reatined factors
out3 <- ifelse(abs(out2) < 0.3, 0, out2)		# ignore small values < 0.3

rownames(out3) <- c("Attractive",	"Quiet",	"Unreliable",	"Poorly.Built", "Interesting",	"Sporty",	"Uncomfortable",	"Roomy", "Easy.Service",	"Prestige",	"Common",	"Economical",	"Successful",	"AvantGarde",	"Poor.Value")


# flip the eignevector so that the slopes become positive for naming the four benefits
out4 <- out3
out4[,1] <- (-1)*out3[,1]
out4[,2] <- (-1)*out3[,2]


# find z and run regression
z <- x %*% out4

out5 <- lm(y ~ z)

summary(out5)
# Only z1 and z3 are statistically significant

##### Iso Preference Line and Ideal Vector ####
# coordinates of brands in (z1, z3) space
Z1 <- z[,1]
Z3 <- z[,3]
z.out <- cbind(Z1, Z3)
rownames(z.out) = c("Infinity", "Ford", "Audi", "Toyota", "Eagle", "Honda", "Saab", "Pontiac", "BMW", "Mercury")


# Plot and label the brand map
plot(Z1, Z3, main = "Brands in Z1 and Z3 space", xlab = "Benefit Z1", ylab = "Benefit Z3", col = "lightblue", pch = 19, cex = 2)		# Brand Map in Z1-Z2 space
text(z.out, labels = row.names(z.out), font = 2, cex = 0.5, pos = 1)

# Slopes of iso-preference and ideal vector
b1 <- as.vector(coef(out5)[2])
b3 <- as.vector(coef(out5)[4])


slope.iso.preference = - b1/b3

# find ideal vector: perpendicular to the iso-preference line
slope.ideal.vector = b3/b1

# find the angles of iso-preference and ideal vector	
angle.iso.preference <- atan(slope.iso.preference)*180/pi	
angle.ideal.vector <- atan(slope.ideal.vector)*180/pi

# print the angles/slopes
angle.iso.preference # -56.21 degrees
angle.ideal.vector   # 33.79 degrees

# They are perpendicular
intercept <- Z3[1] - slope.iso.preference * Z1[1]

abline(a=intercept, b=slope.iso.preference)


##### Bootstrap for angles #####
bb <- 1000	
rsq.out2 <- matrix(0, bb, 1)				# new output matrix for R^2
nn <- nrow(ego)


# Assuming 'data' is your original dataset, 'y' is the response variable, 
# and 'x' is the matrix of predictors already defined in your environment


# Initialize a vector to store the angles for each bootstrap sample
angles <- numeric(bb)

# Bootstrap procedure
set.seed(123) # For reproducibility

for (ii in 1:bb) {
  # Create a bootstrap sample by resampling rows with replacement
  sample_indices <- sample(nrow(data), replace = TRUE)
  data_star <- data[sample_indices, ]
  
  # Assuming the first column of 'data_star' is 'y' and the rest are 'x'
  y_star <- data_star[, "Overall.Preference"]
  x_star <- as.matrix(data_star[,2:16])
  
  # Perform PCA on the bootstrap sample (x_star) similar to your original approach
  cor_mat_star <- cor(x_star)
  pca_result_star <- eigen(cor_mat_star)
  ve_star <- pca_result_star$vectors
  va_star <- pca_result_star$values
  ego_star <- va_star[va_star > 1]
  nn_star <- length(ego_star)
  out2_star <- ve_star[, 1:nn_star]
  out3_star <- ifelse(abs(out2_star) < 0.3, 0, out2_star)
  out4_star <- (-1) * out3_star
  z_star <- x_star %*% out4_star
  
  model_star <- lm(y_star ~ z_star)
  b1_star <- abs(coef(model_star)[2] )
  b2_star <- abs(coef(model_star)[4]) 
  
  angle_star <- atan(b2_star / b1_star) * (180 / pi)
  angles[ii] <- angle_star
}

angle_ci <- quantile(angles, probs = c(0.025, 0.975), na.rm = TRUE)

print(angle_ci)

