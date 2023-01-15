base = read.csv('credit_data.csv')
base$clientid = NULL
base$age[base$age < 0 | is.na(base$age)] = mean(base$age[base$age > 0], na.rm = TRUE)
base[, 1:3] = scale(base[, 1:3])

# Instala a biblioteca caTools
# install.packages('caTools')

# Usando a biblioteca caTools
library(caTools)

# O comando abaixo é para garantir que a divisão da base de dados seja a mesma utilizada pelo Jones na aula
set.seed(1)

# Define o conjunto de registros que irão compor a base de dados de treinamento com 75% dos dados
divisao = sample.split(base$default, SplitRatio = 0.75)

#
# Ao se visualizar o conteúdo da variável divisao (através da console no RStudio), os registros marcados com TRUE
# são aqueles que irão fazer parte da base de treinamento. Os que estão marcados com FALSE não irão compor a base
# de treinamento.
#
#
# Cria a base de treinamento
base_treinamento = subset(base, divisao == TRUE)

# Cria a base de testes
base_teste = subset(base, divisao == FALSE)
