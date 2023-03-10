# Leitura da base de dados
base = read.csv('census.csv')

# Apagar a coluna X
base$X = NULL

# Tratamento dos campos categóricos
base$workclass = as.numeric(factor(base$workclass, levels = c(' Federal-gov', ' Local-gov', ' Private', ' Self-emp-inc', ' Self-emp-not-inc', ' State-gov', ' Without-pay'), labels = c(1, 2, 3, 4, 5, 6, 7)))
base$education = as.numeric(factor(base$education, levels = c(' 10th', ' 11th', ' 12th', ' 1st-4th', ' 5th-6th', ' 7th-8th', ' 9th', ' Assoc-acdm', ' Assoc-voc', ' Bachelors', ' Doctorate', ' HS-grad', ' Masters', ' Preschool', ' Prof-school', ' Some-college'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)))
base$marital.status = as.numeric(factor(base$marital.status, levels = c(' Divorced', ' Married-AF-spouse', ' Married-civ-spouse', ' Married-spouse-absent', ' Never-married', ' Separated', ' Widowed'), labels = c(1, 2, 3, 4, 5, 6, 7)))
base$occupation = as.numeric(factor(base$occupation, levels = c(' Adm-clerical', ' Armed-Forces', ' Craft-repair', ' Exec-managerial', ' Farming-fishing', ' Handlers-cleaners', ' Machine-op-inspct', ' Other-service', ' Priv-house-serv', ' Prof-specialty', ' Protective-serv', ' Sales', ' Tech-support', ' Transport-moving'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)))
base$relationship = as.numeric(factor(base$relationship, levels = c(' Husband', ' Not-in-family', ' Other-relative', ' Own-child', ' Unmarried', ' Wife'), labels = c(1, 2, 3, 4, 5, 6)))
base$race = as.numeric(factor(base$race, levels = c(' Amer-Indian-Eskimo', ' Asian-Pac-Islander', ' Black', ' Other', ' White'), labels = c(1, 2, 3, 4, 5)))
base$sex = as.numeric(factor(base$sex, levels = c(' Female', ' Male'), labels = c(0, 1)))
base$native.country = as.numeric(factor(base$native.country, levels = c(' Cambodia', ' Canada', ' China', ' Columbia', ' Cuba', ' Dominican-Republic', ' Ecuador', ' El-Salvador', ' England', ' France', ' Germany', ' Greece', ' Guatemala', ' Haiti', ' Holand-Netherlands', ' Honduras', ' Hong', ' Hungary', ' India', ' Iran', ' Ireland', ' Italy', ' Jamaica', ' Japan', ' Laos', ' Mexico', ' Nicaragua', ' Outlying-US(Guam-USVI-etc)', ' Peru', ' Philippines', ' Poland', ' Portugal', ' Puerto-Rico', ' Scotland', ' South', ' Taiwan', ' Thailand', ' Trinadad&Tobago', ' United-States', ' Vietnam', ' Yugoslavia'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41)))
base$income = as.numeric(factor(base$income, levels = c(' <=50K', ' >50K'), labels = c(1, 2)))

# Escalonamento
base[, 1] = as.numeric(scale(base[, 1]))
base[, 3] = as.numeric(scale(base[, 3]))
base[, 5] = as.numeric(scale(base[, 5]))
base[, 11:13] = as.numeric(scale(base[, 11:13]))

# Divisăo entre treinamento e teste
library(caTools)
set.seed(1)
divisao = sample.split(base$income, SplitRatio = 0.85)
base_treinamento = subset(base, divisao == TRUE)
base_teste = subset(base, divisao == FALSE)

library(h2o)
# Conecta-se ao servidor remoto e informa que devem ser usadas todas as CPUs disponíveis (parâmetro -1)
# OBSERVAÇĂO: para que o comando abaixo funcione, é preciso abrir as portas 54321 e 54322 no firewall rodando o seguinte
# comando como root: firewall-cmd --add-port=54321/tcp e firewall-cmd --add-port=54322/tcp
h2o.init(nthreads = -1)
classificador = h2o.deeplearning(y = 'income',
                                 training_frame = as.h2o(base_treinamento),
                                 activation = 'Rectifier',
                                 hidden = c(100),
                                 epochs = 1000)
# Meu código năo está funcionando corretamente. Sem a conversăo do atributo income no início do script, ocorre um erro
# na biblioteca h2o. Se eu faço a conversăo, a transformaçăo dos valores na variável previsőes năo está ocorrendo como
# deveria e aí, no momento de gerar a matriz de confusăo, o número de erros está absurdamente alto.
previsoes = h2o.predict(classificador, newdata = as.h2o(base_teste[-15]))
previsoes = ifelse(previsoes > 1, 2, 1)
previsoes = as.vector(previsoes)

matriz_confusao = table(base_teste[, 15], previsoes)
library(caret)
confusionMatrix(matriz_confusao)

