base = read.csv('risco_credito.csv')

install.packages('rpart')
library(rpart)

# Cria o classificador usando rpart
# No parâmetro formula deve ser informado o atributo classificador e os atributos previsores. No caso, risco é o atributo
# classificador. O ponto (.) indica que os atributos previsores são todos os demais atributos, exceto risco.
# No parâmetro data deve ser informada a base de dados.
# No parâmetro control foram passados valores que indicam que a árvore deve ser construída ainda que exista um único
# registro dentro de um split. Em bases pequenas, se esse parâmetro não for informado, não será possível imprimir 
# um gráfico da árvore de decisão gerada.
# É nessa linha que efetivamente acontece o aprendizado do algoritmo de árvore de decisão em cima da base de dados
# chamada base.
classificador = rpart(formula = risco ~., data = base, control = rpart.control(minbucket = 1))
# Imprime um gráfico da árvore
plot(classificador)
# Imprime os nomes dos atributos 
text(classificador)

install.packages('rpart.plot')
# Para exibir um gráfico mais bem elaborado da árvore
library(rpart.plot)
rpart.plot(classificador)

# história: boa, dívida: alta, garantias: nenhuma, renda: >35
# história: ruim, dívida: alta, garantias: adequada, renda: <15
historia = c('boa','ruim')
divida = c('alta','alta')
garantias = c('nenhuma','adequada')
renda = c('acima_35','0_15')
df = data.frame(historia, divida, garantias, renda)

previsoes = predict(classificador, newdata = df)
print(previsoes)
