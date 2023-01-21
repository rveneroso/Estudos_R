base = read.csv('credit_data.csv')
base$clientid = NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] = scale(base[, 1:3])

base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] = scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

library(caret)
controle_treinamento = trainControl(method = 'cv', number = 10)
# Avaliando o algoritmo Naive Bayes
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'nb')
# Avaliando o algoritmo de árvores de decisão
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'rpart')
# Avaliando o algoritmo de random forests
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'rf')
# Avaliando o algoritmo de regras
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'C5.0Rules')
# Avaliando o algoritmo knn
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'knn')
# Avaliando o algoritmo de regressão logística
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'glm', family = 'binomial')
# Avaliando o algoritmo SVM
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'svmRadial')
# Avaliando o algoritmo de redes neurais (não é da biblioteca h2o)
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'avNNet')
precisao = modelo$results$Accuracy[2]
