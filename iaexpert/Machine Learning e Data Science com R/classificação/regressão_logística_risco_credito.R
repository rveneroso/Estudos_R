base = read.csv('risco_credito.csv')
base = base[base$risco != "moderado", ]

classificador = glm(as.factor(base$risco) ~ ., family = binomial, data = base)

# hist?ria: boa, d?vida: alta, garantias: nenhuma, renda: >35
# hit?stia: ruim, d?vida: alta, garantias: adequada, renda: <15
historia = c('boa', 'ruim')
divida = c('alta', 'alta')
garantias = c('nenhuma', 'adequada')
renda = c('acima_35', '0_15')
df = data.frame(historia, divida, garantias, renda)

probabilidades = predict(classificador, type = 'response', newdata = df)
resposta = ifelse(probabilidades > 0.5, 'baixo', 'alto')