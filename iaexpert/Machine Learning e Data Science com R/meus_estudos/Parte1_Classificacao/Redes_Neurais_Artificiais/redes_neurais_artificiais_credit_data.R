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

# install.packages('h2o')
library(h2o)
# Conecta-se ao servidor remoto e informa que devem ser usadas todas as CPUs disponíveis (parâmetro -1)
# OBSERVAÇÃO: para que o comando abaixo funcione, é preciso abrir as portas 54321 e 54322 no firewall rodando o seguinte
# comando como root: firewall-cmd --add-port=54321/tcp e firewall-cmd --add-port=54322/tcp
h2o.init(nthreads = -1)
classificador = h2o.deeplearning(y = 'default',
                                 training_frame = as.h2o(base_treinamento),
                                 activation = 'Rectifier',
                                 hidden = c(100),
                                 epochs = 1000)
previsoes = h2o.predict(classificador, newdata = as.h2o(base_teste[-4]))
previsoes = (previsoes > 0.5)
previsoes = as.vector(previsoes)

matriz_confusao = table(base_teste[, 4], previsoes)
library(caret)
confusionMatrix(matriz_confusao)
