base = read.csv('risco_credito.csv')

install.packages('rpart')
library(rpart)

# Cria o classificador usando rpart
# No par?metro formula deve ser informado o atributo classificador e os atributos previsores. No caso, risco ? o atributo
# classificador. O ponto (.) indica que os atributos previsores s?o todos os demais atributos, exceto risco.
# No par?metro data deve ser informada a base de dados.
# No par?metro control foram passados valores que indicam que a ?rvore deve ser constru?da ainda que exista um ?nico
# registro dentro de um split. Em bases pequenas, se esse par?metro n?o for informado, n?o ser? poss?vel imprimir 
# um gr?fico da ?rvore de decis?o gerada.
# ? nessa linha que efetivamente acontece o aprendizado do algoritmo de ?rvore de decis?o em cima da base de dados
# chamada base.
classificador = rpart(formula = risco ~., data = base, control = rpart.control(minbucket = 1))
# Imprime um gr?fico da ?rvore
plot(classificador)
# Imprime os nomes dos atributos 
text(classificador)

install.packages('rpart.plot')
# Para exibir um gr?fico mais bem elaborado da ?rvore
library(rpart.plot)
rpart.plot(classificador)

# hist?ria: boa, d?vida: alta, garantias: nenhuma, renda: >35
# hist?ria: ruim, d?vida: alta, garantias: adequada, renda: <15
historia = c('boa','ruim')
divida = c('alta','alta')
garantias = c('nenhuma','adequada')
renda = c('acima_35','0_15')
df = data.frame(historia, divida, garantias, renda)

previsoes = predict(classificador, newdata = df)
print(previsoes)
