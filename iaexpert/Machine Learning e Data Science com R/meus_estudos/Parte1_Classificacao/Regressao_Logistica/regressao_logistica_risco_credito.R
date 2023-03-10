# A leitura do csv teve que ser feita de maneira diferente da aula. Sem o par?metro stringsAsFactors=T, ao tentar
# criar o classificador ocorria o erro
#
# Error in eval(family$initialize) : y values must be 0 <= y <= 1 
#
base = read.csv('risco_credito.csv', stringsAsFactors=T)

# Remove os registros onde o risco de cr?dito ? moderado.
base = base[base$risco != "moderado", ]

classificador = glm(as.factor(risco) ~ ., family = binomial, data = base)

# hist?ria: boa, d?vida: alta, garantias: nenhuma, renda: >35
# hist?ria: ruim, d?vida: alta, garantias: adequada, renda: <15
historia = c('boa','ruim')
divida = c('alta','alta')
garantias = c('nenhuma','adequada')
renda = c('acima_35','0_15')
df = data.frame(historia, divida, garantias, renda)

probabilidades = predict(classificador, type='response', newdata = df)
resposta = ifelse(probabilidades > 0.5, 'baixo', 'alto')
