# Leitura da base de dados
base = read.csv('credit_data.csv')

# Apaga a coluna clientid
base$clientid = NULL

# Valores inconsistentes
base$age = ifelse(base$age < 0, 40.92, base$age)

# Valores faltantes
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)

# Escalonamento
base[, 1:3] = scale(base[, 1:3])

# Divisão entre treinamento e teste
library(caTools)
set.seed(1)
divisao = sample.split(base$income, SplitRatio = 0.75)
base_treinamento = subset(base, divisao == TRUE)
base_teste = subset(base, divisao == FALSE)

library(e1071)
classificador = svm(formula = default ~., data = base_treinamento, type = 'C-classification', 
                    kernel = 'radial', cost = 5.0)

previsoes = predict(classificador, newdata = base_teste[, -4])
matriz_confusao = table(base_teste[, 4], previsoes)

library(caret)
confusionMatrix(matriz_confusao)
