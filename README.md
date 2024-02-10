# logistic_regression_payment_default

##Default Payment Customers Bank

###In this Bank 23% of its customers default on their payments. Let's predict the customers that will default on their loan payments.

![Rplot](https://github.com/SelvaCamp/payment_default_logistic_reg/assets/158846801/fc365fd2-6095-4359-860f-8758eb0d0c5f)

###We first build a logistic regression model with all the variables provided. After applying stepAIC and checking the significance p-value. We built a model with the following variables: limitBal, sex, education, marriage, pay1, pay3, pay5, billAmt1, billAmt2, and finally payAmt1. The model has an **8.01 accuracy**. 

##Confusion matrix
![Rplot01_matrix](https://github.com/SelvaCamp/payment_default_logistic_reg/assets/158846801/9e772555-3cb0-4649-a7fd-1da94106b6aa)]

##AUC Curve

![Rplot01_auc](https://github.com/SelvaCamp/payment_default_logistic_reg/assets/158846801/8e2a6d75-caef-4837-bfc1-9ff6230d9eb3)]

###The curve AUC is 72%

Finally, we split the dataset into a training set and a test set to make predictions.
