base = read.csv('risco_credito.csv')

install.packages('e1071')
library(e1071)

classificador = naiveBayes(x = base[-5], y = base$risco)
print(classificador)

# história: boa, dívida: alta, garantias: nenhuma, renda: >35
# hitóstia: ruim, dívida: alta, garantias: adequada, renda: <15
historia = c('ruim')
divida = c('alta')
garantias = c('adequada')
renda = c('0_15')
df = data.frame(historia, divida, garantias, renda)

previsao = predict(classificador, newdata = df, 'raw')
print(previsao)