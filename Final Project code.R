bodymeas <-
  read.table(
    "C:/Users/evia/Desktop/Desktop- Files only/bodymeas.txt",
    quote = "\"",
    comment.char = ""
  )
View(bodymeas)
attach(bodymeas)

VarNames = c(
  'Biacromial diameter',
  'Biiliac diameter',
  'Bitrochanteric diameter',
  'Chest depth',
  'Chest diameter',
  'Elbow diameter',
  'Wrist diameter',
  'Knee diameter',
  'Ankle diameter',
  'Shoulder girth',
  'Chest girth',
  'Waist girth',
  'Navel girth',
  'Hip girth',
  'Thigh girth',
  'Bicep girth',
  'Forearm girth',
  'Knee girth',
  'Calf maximum girth',
  ' Ankle minimum girth',
  'Wrist minimum girth',
  'Age',
  'Weight',
  'Height'
)
Var.meas = cbind(
  V1,
  V2,
  V3,
  V4,
  V5,
  V6,
  V7,
  V8,
  V9,
  V10,
  V11,
  V12,
  V13,
  V14,
  V15,
  V16,
  V17,
  V18,
  V19,
  V20,
  V21,
  V22,
  V23,
  V24
)

#ADD DIAGNOSTICS FOR PREDICTOR VARIABLES
#Makes box plots for each predictor variable
for (i in 1:23) {
  boxplot(Var.meas[, i], ylab = "Lot Size", xlab = VarNames[i])
}



#make a scatter correlation matrix
pairs(Var.meas, labels = VarNames)
#Too many variables to plot

#Check for highly correlated variables to V24 (Targt variable)
m = cor(Var.meas)
order(m[, 'V24'], decreasing = TRUE)
m[, 'V24']
#Most highly correlated variables, in order:
# 1 6 23 21  9  7 10 17  5 11 16  8 20 12  4 18  3 19

#SLR Model####
model.singlevar = lm(V24 ~ V1)


#MODEL REPORT for SLR
summary(model.singlevar)
model.singlevar$coefficients
confint(model.singlevar, level = 0.95)

#RESIDUAL DIAGNOSTIC REPORT for SLR
#Plot of residuals vs predictors
e = resid(model.singlevar)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#Plot of residuals vs fitted values
plot(fitted(model.singlevar), e, xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red")

#Outlier plots
boxplot(e, ylab = expression(paste("Residuals: ", e[i])))

#QQ plot/shapiro wilks
n <- length(e)
MSE <- sum(e ^ 2) / (n - 2)
expected <- NULL
for (i in 1:n) {
  expected[i] <- qnorm(i / (n + 1), 0, sqrt(MSE))
}
plot(expected, sort(e), xlab = "Expected Residuals", ylab = "Observed Residuals")
abline(0, 1, col = "red")

#BP or BF test- NEED TO LOOK UP CODE AGAIN


#SLR Model with Gender####

model.singlevar.gender = lm(V24ln ~ V1 + V25)

#MODEL REPORT for SLR
summary(model.singlevar.gender)
model.singlevar.gender$coefficients
confint(model.singlevar.gender, level = 0.95)

#RESIDUAL DIAGNOSTIC REPORT for SLR
#Plot of residuals vs predictors
e = resid(model.singlevar.gender)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#Plot of residuals vs fitted values
plot(fitted(model.singlevar.gender),
     e,
     xlab = "Fitted Values",
     ylab = "Residuals")
abline(h = 0, col = "red")

#Outlier plots
boxplot(e, ylab = expression(paste("Residuals: ", e[i])))

#QQ plot/shapiro wilks
n <- length(e)
MSE <- sum(e ^ 2) / (n - 2)
expected <- NULL
for (i in 1:n) {
  expected[i] <- qnorm(i / (n + 1), 0, sqrt(MSE))
}
plot(expected, sort(e), xlab = "Expected Residuals", ylab = "Observed Residuals")
abline(0, 1, col = "red")

#BP or BF test- NEED TO LOOK UP CODE AGAIN


#SLR Model with Transform####
library(MASS)
boxcox(model.singlevar)
#Lambda is 0, recommend a log transform

V24ln = log(V24)

model.singlevar.transform = lm(V24ln ~ V1)


#MODEL REPORT for SLR
summary(model.singlevar.transform)
model.singlevar.transform$coefficients
confint(model.singlevar.transform, level = 0.95)

#RESIDUAL DIAGNOSTIC REPORT for SLR
#Plot of residuals vs predictors
e = resid(model.singlevar.transform)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#Plot of residuals vs fitted values
plot(fitted(model.singlevar.transform),
     e,
     xlab = "Fitted Values",
     ylab = "Residuals")
abline(h = 0, col = "red")

#Outlier plots
boxplot(e, ylab = expression(paste("Residuals: ", e[i])))

#QQ plot/shapiro wilks
n <- length(e)
MSE <- sum(e ^ 2) / (n - 2)
expected <- NULL
for (i in 1:n) {
  expected[i] <- qnorm(i / (n + 1), 0, sqrt(MSE))
}
plot(expected, sort(e), xlab = "Expected Residuals", ylab = "Observed Residuals")
abline(0, 1, col = "red")

#BP or BF test- NEED TO LOOK UP CODE AGAIN


#SLR model with Transform and Gender ####
model.singlevar.transform.gender = lm(V24ln ~ V1 + V25)


#MODEL REPORT for SLR
summary(model.singlevar.transform.gender)
model.singlevar.transform.gender$coefficients
confint(model.singlevar.transform.gender, level = 0.95)

#RESIDUAL DIAGNOSTIC REPORT for SLR
#Plot of residuals vs predictors
e = resid(model.singlevar.transform.gender)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#Plot of residuals vs fitted values
plot(fitted(model.singlevar.transform.gender),
     e,
     xlab = "Fitted Values",
     ylab = "Residuals")
abline(h = 0, col = "red")

#Outlier plots
boxplot(e, ylab = expression(paste("Residuals: ", e[i])))

#QQ plot/shapiro wilks
n <- length(e)
MSE <- sum(e ^ 2) / (n - 2)
expected <- NULL
for (i in 1:n) {
  expected[i] <- qnorm(i / (n + 1), 0, sqrt(MSE))
}
plot(expected, sort(e), xlab = "Expected Residuals", ylab = "Observed Residuals")
abline(0, 1, col = "red")

#BP or BF test- NEED TO LOOK UP CODE AGAIN



#MLR: Fitting a multiple regression model based on highly correlated variables########
model.multivar = lm(V24 ~ V1 + V6 + V23)

##MODEL REPORT for MLR
summary(model.multivar)
model.multivar$coefficients
confint(model.multivar, level = 0.95)


#RESIDUAL DIAGNOSTIC REPORT for MLR
#Plot of residuals vs predictors
e = resid(model.multivar)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V6, e, xlab = expression(paste("Elbow diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V23, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#Plot of residuals vs fitted values
plot(fitted(model.multivar), e, xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = "red")

#Outlier plots
boxplot(e, ylab = expression(paste("Residuals: ", e[i])))

#QQ plot/shapiro wilks
n <- length(e)
MSE <- sum(e ^ 2) / (n - 2)
expected <- NULL
for (i in 1:n) {
  expected[i] <- qnorm(i / (n + 1), 0, sqrt(MSE))
}
plot(expected, sort(e), xlab = "Expected Residuals", ylab = "Observed Residuals")
abline(0, 1, col = "red")

#BP or BF test- NEED TO LOOK UP CODE AGAIN

########

#Code to check for transformations here
library(MASS)
boxcox(model.multivar)

#Results#####
#box cox recommends log transformation of Y variable

model.multivar.transform = lm(log(V24) ~ V1 + V6 + V23)


# MODEL REPORT for MLR with Transform

summary(model.multivar.transform)
model.multivar.transform$coefficients
confint(model.multivar.transform, level = 0.95)


# MLR with all variable with correlation greater than .4 ####
modeltemp = lm(V24 ~ V1 + V6 + V23 + V21 + V9 + V7 + V10 + V17 + V5 + V11 +
                 V16 + V8 + V20 + V12 + V4 + V18 + V3 + V19)
summary(modeltemp)

#RESIDUAL DIAGNOSTIC REPORT for MLR ####
#Plot of residuals vs predictors

e = resid(modeltemp)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V6, e, xlab = expression(paste("Elbow diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
#### Slight curvature with V6?
plot(V23, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
# Slight curvature with V23?
plot(V21, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V9, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V7, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V10, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V17, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V5, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V11, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V16, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V8, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V20, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V12, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V4, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V18, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V3, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V19, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#MLR with Poly terms ####
#create centered and polynomial variables for v6 and v23

v6cent <- (V6 - mean(V6))
v23cent <- V23 - mean(V23)
v6sq = v6cent ^ 2
v23sq <- v23cent ^ 2

var.meas.new = bodymeas
var.meas.new$v6cent = v6cent
var.meas.new$v23cent = v23cent
var.meas.new$v6sq = v6sq
var.meas.new$v23sq = v23sq
var.meas.new$V6   = NULL
var.meas.new$V23   = NULL


remove(bodymeas)

#use Leaps function to make new best model based on adjusted R square
library(leaps)
leapmodel = leaps(
  cbind(
    V1,
    V21,
    V9,
    V7,
    V10,
    V17,
    V5,
    V11,
    V16,
    V8,
    V20,
    V12,
    V4,
    V18,
    V3,
    V19
    ,
    v6cent,
    v23cent,
    v6sq,
    v23sq
  ),
  V24,
  method = c('adjr2')
)

Cp.results <- cbind(leapmodel$size, leapmodel$which, leapmodel$adjr2)
colnames(Cp.results) <-
  c(
    "Parameters",
    'V1',
    'V21',
    'V9',
    'V7',
    'V10',
    'V17',
    'V5',
    'V11',
    'V16',
    'V8',
    'V20',
    'V12',
    'V4',
    'V18',
    'V3',
    'V19',
    'v6cent',
    'v23cent',
    'v6sq',
    'v23sq',
    "Adjr2"
  )

#find the best model by ordering by Adjrsq
Cp.results = Cp.results[order(Cp.results[, 'Adjr2'], decreasing = TRUE), ]
Cp.results[1, ]
#best parameters include 1,21,9,17,11,16,8,12,3,19,6,6**2,23,23**2

model.multivar.poly = lm(V24 ~ V1 + V21 + V9 + V17 + V11 + V16 + V8 + V12 +
                           V3 + V19 + v6cent + v6sq + v23cent + v23sq)
summary(model.multivar.poly)

#RESIDUAL DIAGNOSTIC REPORT for MLR ####
#Plot of residuals vs predictors
e = resid(model.multivar.poly)
plot(V1, e, xlab = expression(paste("Biacromial diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V6, e, xlab = expression(paste("Elbow diameter: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
#### Slight curvature with V6?
plot(V23, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
# Slight curvature with V23?
plot(V21, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V9, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V7, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V10, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V17, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V5, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V11, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V16, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V8, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V20, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V12, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V4, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V18, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V3, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")
plot(V19, e, xlab = expression(paste("Weight: ", X[i])),
     ylab = expression(paste("Residuals: ", e[i])))
abline(h = 0, col = "red")

#MLR with Poly terms and gender ####

model.multivar.poly.gender = lm(V24 ~ V1 + V21 + V9 + V17 + V11 + V16 +
                                  V8 + V12 + V3 + V19 + v6cent + v6sq + v23cent + v23sq + V25)
summary(model.multivar.poly.gender)


#addedvariable plots
#check for influential points for each model