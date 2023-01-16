base = read.csv('risco_credito.csv')

# install.packages('OneR')
library(OneR)

classificador = OneR(base)

# história: boa, dívida: alta, garantias: nenhuma, renda: >35
# história: ruim, dívida: alta, garantias: adequada, renda: <15
historia = c('boa', 'ruim')
divida = c('alta', 'alta')
garantias = c('nenhuma', 'adequada')
renda = c('acima_35', '0_15')
df = data.frame(historia, divida, garantias, renda)

previsoes = predict(classificador, newdata = df)
