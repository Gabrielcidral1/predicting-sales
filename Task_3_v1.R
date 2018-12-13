pacman::p_load(xlsx, caret, corrplot, party, rpart, ggplot2, gbm)

existingproductattributes_v1 <- read.xlsx(file = "C:/Users/gabri/Desktop/Ubiqum/R/Data_Analytics_Predicting_Customer_Preference/Task_3/existingproductattributes_v1.xlsx", 
                                          sheetName = "existingproductattributes")

existingproductattributes_v1$BestSellersRank <- NULL

# Dummy conversion

dummyconversion <- dummyVars("~.", data = existingproductattributes_v1)
dummyData <- data.frame(predict(dummyconversion, newdata = existingproductattributes_v1))

## Exclusion product number

dummyData$ProductNum <- NULL

## Correlation Matrix 

existingproductattributes_v1$totalSize_D.W.H <- existingproductattributes_v1$ProductDepth*existingproductattributes_v1$ProductWidth*existingproductattributes_v1$ProductHeight
CorrData <- cor(na.omit(existingproductattributes_v1[ , c(3:12,16,18,17)]))
corrplot(CorrData, method = "number")
CorrData_Size <- cor(na.omit(dummyData[c(1:12,27)]))
corrplot(CorrData_Size, method = "number")

##  Excl.variables 

dummyData$x5StarReviews <- NULL
dummyData$x3StarReviews <- NULL
dummyData$x2StarReviews <- NULL
dummyData$x1StarReviews <- NULL
dummyData$NegativeServiceReview <- NULL


# Anova test
anova <- aov(formula = Volume ~ ProductType, data = existingproductattributes_v1)
plot(anova)

## Treating outliers
dummyData <- subset(dummyData, Volume < 6000)

## Model

set.seed(192)
inTraining <- createDataPartition(dummyData$Volume, p=.75, list = FALSE)
training <- dummyData[inTraining,]
testing <- dummyData[-inTraining,]

hist(training$Volume)
hist(testing$Volume)

fitControl <- trainControl(method = "repeatedcv", number = 10, repeats = 5, verboseIter = FALSE)

decisiontree <- ctree(Volume~.,data = training, controls = ctree_control(maxdepth = 3))
plot(decisiontree)

## Linear Model

lmFit <- train(Volume~0 + x4StarReviews,data = training,method = "lm", trControl = fitControl, tuneLength = 20, preProcess = c("center", "scale"))
summary(lmFit)
predictVolume_lm <- predict(lmFit,testing)
postResample(predictVolume_lm,testing$Volume)

## SVM

svm_fit <- train(Volume~0 + x4StarReviews+PositiveServiceReview,data = training,method = "svmRadial", 
                 na.action = na.omit, trControl = fitControl, tuneLength = 20, 
                 preProcess = c("center", "scale"))
predictVolume_svm <- predict(svm_fit,testing)
postResample(predictVolume_svm,testing$Volume)

## Random Forest

RandomForest <- train(Volume~0 + x4StarReviews+PositiveServiceReview, data = training, method = "rf", trControl = fitControl,na.action = na.omit, ntree = 50, do.trace = 10)
predictVolume_rf <- predict(RandomForest,testing)
postResample(predictVolume_rf,testing$Volume)

## XGBM

GBM <- train(Volume~0 + x4StarReviews+PositiveServiceReview, data = training, method = "gbm", trControl = fitControl,na.action = na.omit, preProcess = c("center", "scale"))
predictVolume_GBM <- predict(GBM,testing)
postResample(predictVolume_GBM,testing$Volume)

## knn

knn_fit <- train(Volume~0 + x4StarReviews+PositiveServiceReview,data = training,method = "knn", trControl = fitControl, tuneLength = 10, 
                 preProcess = c("center", "scale"),tunegrid = expand.grid(.k=1:10))
predictVolume_knn <- predict(knn_fit,testing)
postResample(predictVolume_knn,testing$Volume)

## Prediction of  new products

##          Random Forest 
newproductattributes_v2 <- read.xlsx(file = "newproductattributes_v2.xlsx", sheetName = "newproductattributes_v2")
Prediction_rf <- predict(RandomForest,newproductattributes_v2)
Prediction_rf
write.xlsx(Prediction_rf, file = "Prediction_rf.xlsx")

##          Gradient Boosted Trees
Prediction_gbm <- predict(GBM,newproductattributes_v2)
Prediction_gbm
write.xlsx(Prediction_gbm, file = "Prediction_gbm.xlsx")

## Descritive analysis
existing_and_new_productattributes_v2 <- read.xlsx(file = "existing_and_new_productattributes_v2.xlsx", sheetIndex = 1)

ggplot(existing_and_new_productattributes_v2,aes(x=ProductType,y=Price, color = Existing.New)) + 
  geom_point(size=5)+ geom_jitter(size = 5, position = position_jitter(width = 0.1, height = 0.1)) + 
  labs(title = "Price per category", x = "Product Type", y= "Price") +  theme(plot.title = element_text(hjust = 0.5))