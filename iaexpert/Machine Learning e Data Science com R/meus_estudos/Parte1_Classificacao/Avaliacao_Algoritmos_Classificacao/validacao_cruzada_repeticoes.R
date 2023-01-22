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
controle_treinamento = trainControl(method = 'repeatedcv', number = 10, repeats = 2)
modelo = train(default ~., data = base, trControl = controle_treinamento, method = 'rf')
print(modelo)
precisao = modelo$results$Accuracy[2]
