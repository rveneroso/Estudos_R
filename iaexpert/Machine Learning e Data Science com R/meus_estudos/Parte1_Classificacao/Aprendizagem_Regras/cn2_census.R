# Leitura da base de dados
base = read.csv('census.csv')

# Apagar a coluna X
base$X = NULL

# Para algoritmos baseados em regras não é interessante categorizar nem escalonar atributos

# Divisão entre treinamento e teste
library(caTools)
set.seed(1)
# Esse algoritmo é lento. Por isso está sendo usado apenas 5% da base para treinamento.
divisao = sample.split(base$income, SplitRatio = 0.05)
base_treinamento = subset(base, divisao == TRUE)
base_teste = subset(base, divisao == FALSE)

# ZeroR - base line classifier
table(base_teste$income)

library(RoughSets)

dt_treinamento = SF.asDecisionTable(dataset = base_treinamento, decision.attr = 15)
dt_teste = SF.asDecisionTable(dataset = base_teste, decision.attr = 15)

# Categoriza os atributos numéricos gerando intervalos de frequência
intervalos = D.discretization.RST(dt_treinamento, nOfIntervals = 4)

# Substitui os valores numéricos nas bases de treinamento e de teste pelos intervalos calculados acima
dt_treinamento = SF.applyDecTable(dt_treinamento, intervalos)
dt_teste = SF.applyDecTable(dt_teste, intervalos)

# Esse algoritmo é lento. Por isso o valor de K foi reduzido a 1.
classificador = RI.CN2Rules.RST(dt_treinamento, K = 1)

previsoes = predict(classificador, newdata = dt_teste[-15])
matriz_confusao = table(dt_teste[, 15], unlist(previsoes))

library(caret)
confusionMatrix(matriz_confusao)

