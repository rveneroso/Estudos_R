base = read.csv('risco_credito.csv')

# install.packages('e1071')
library(e1071)

# Cria o classificador indicando ao Naive Bayes que os atributos previsores serão os atributos de 1 a 4 ou, de outra
# forma, todos menos o 5 e que o atributo que define a classe é o atributo risco.
# A linha abaixo é efetivamente o treinamento do algoritmo Naive Bayes na base risco_credito.csv
classificador = naiveBayes(x = base[-5], y = base$risco)
print(classificador)

# Classificando novos registros.
#
# história: boa, dívida: alta, garantias: nenhuma, renda: >35
#
historia = c('boa')
divida = c('alta')
garantias = c('nenhuma')
renda = c('acima_35')
# Cria um dataframe com as variáveis criadas acima.
df = data.frame(historia, divida, garantias, renda)
# Faz a previsão do novo registro
previsao = predict(classificador, newdata = df, 'raw')
print(previsao)

#
# história: ruim, dívida: alta, garantias: adequada, renda: <15
#
historia = c('ruim')
divida = c('alta')
garantias = c('adequada')
renda = c('0_15')
df = data.frame(historia, divida, garantias, renda)
# Faz a previsão do novo registro
previsao = predict(classificador, newdata = df, 'raw')
print(previsao)
