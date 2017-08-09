library(ggplot2)
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)
library(e1071)


seaflow = read.csv('seaflow_21min.csv')
#seaflow = seaflow[seaflow$file_id!=208,]

split = sample.split(seaflow$pop,SplitRatio = 0.5)


training_set = subset(seaflow, split == TRUE)
test_set = subset(seaflow, split == FALSE)

ggplot(seaflow, aes(x= pe, y = chl_small, color = pop)) +
              geom_point(shape = 20)

# Decision Tree Model
tree_model = rpart(formula = pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small, 
              data = training_set, method='class')
print(tree_model)
printcp(tree_model)
prp(tree_model)

y_pred_tree = predict(tree_model, test_set, type='class')

table(pred = y_pred_tree, true = test_set$pop)



# Random Forest Model
forest_model = randomForest(formula = pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small,
                            data = training_set)
print(forest_model)

y_pred_forest = predict(forest_model, test_set)

table(pred = y_pred_forest, true = test_set$pop)


# Support Vector Machine Model

svm_model = svm(formula = pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small,
                data = training_set)
print(svm_model)

y_pred_svm = predict(svm_model, test_set)

table(pred = y_pred_svm, true = test_set$pop)

cat("Accuracy from Decision Tree model : " , sum(test_set$pop == y_pred_tree)*100 / nrow(test_set), "%")
cat("Accuracy from Random Forest model: " , sum(test_set$pop == y_pred_forest)*100 / nrow(test_set), "%")
cat("Accuracy from SVM model: " , sum(test_set$pop == y_pred_svm)*100 / nrow(test_set), "%")
