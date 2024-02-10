
#Payment Default

#Importing libraries
library(tidyverse)
library(ggplot2)
library(descr)

#Importing dataset

churn=read.csv("Data.csv", header=TRUE, sep = ";")

head(churn)
str(churn)

churn=churn[-1]

#Let's check for NAN's

library(naniar)

n_complete(churn)
prop_miss(churn)


#Exploratory data Analysis the interest variable PaymentDefault

summary(churn$PaymentDefault)

ggplot(churn, aes(PaymentDefault))+
  geom_histogram(stat = "count")

table_Payment=table(churn$PaymentDefault)
prop.table(table_Payment)


#Let's build a logistic model with the whole churn dataset

model_all_in=glm(PaymentDefault~., family = binomial, data=churn)

summary(model_all_in)

#let's reduce variables

library(MASS)

reduced_model=stepAIC(model_all_in, trace = 0)

summary(reduced_model)


#Final logistic model with churn dataset

finallogmodel=glm(PaymentDefault ~ limitBal + sex + education + marriage + pay1 + pay3 + pay5 + billAmt1 + billAmt2 + 
                      payAmt1, family = binomial, 
                    data = churn)

summary(finallogmodel)

#Let's evaluate the finallogmodel
library(pROC)
library(yardstick)

actual_response=churn$PaymentDefault
predicted_response=round(fitted(finallogmodel))

outcome=table(predicted_response, actual_response)

confusion_matrix=conf_mat(outcome)

autoplot(confusion_matrix)

summary(confusion_matrix, event_level = "second")

acuracy=summary(confusion_matrix)%>%
  slice(1)

sens=summary(confusion_matrix)%>%
  slice(3)

specificity=summary(confusion_matrix)%>%
  slice(4)

#Plot the ROC curve and and compute the AUC

step_prob=predict(finallogmodel, type="response")

ROC=roc(churn$PaymentDefault, step_prob)

plot(ROC, col="blue")
auc(ROC)


#Split the dataset into train and test set

nrow(churn)

sample_rows=sample(18000, 13500)

churn_train=churn[sample_rows, ]
churn_test=churn[-sample_rows, ]


#Let's build the model with training set
finallogmodeltrain=glm(PaymentDefault ~ limitBal + sex + education + marriage + pay1 + pay3 + pay5 + billAmt1 + billAmt2 + 
                    payAmt1, family = binomial, 
                  data = churn_train)

summary(finallogmodeltrain)

#Let's evaluate the churn_train dataset

actual_response_train=churn_train$PaymentDefault
predicted_response_train=round(fitted(finallogmodeltrain))

outcome_train=table(predicted_response_train, actual_response_train)

confusion_matrix_1=conf_mat(outcome_train)

autoplot(confusion_matrix_1)

summary(confusion_matrix_1, event_level = "second")

acuracy_train=summary(confusion_matrix_1)%>%
  slice(1)

sens_train=summary(confusion_matrix_1)%>%
  slice(3)

specificity_train=summary(confusion_matrix_1)%>%
  slice(4)


#Let's predict the final model test dataset

churn_test$pred=predict(finallogmodeltrain, newdata = churn_test, type="response")

churn_test$pred_1=ifelse(churn_test$pred>0.5,1,0)

head(churn_test,3)








