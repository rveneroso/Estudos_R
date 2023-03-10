base = read.csv('plano_saude.csv')

# Determina a correla??o entre os dois atributos. Quanto maior o valor, maior a correla??o entre os dois atributos.
cor(base$idade, base$custo)

# Linear model. Essa fun??o faz o escalonamento de atributos de forma autom?tica.
regressor = lm(formula = custo ~ idade, data = base)
summary(regressor)

b0 = regressor$coefficients[1]
b1 = regressor$coefficients[2]
cr = summary(regressor)$adj.r.squared

previsoes = predict(regressor, newdata = base[-2])

#install.packages('ggplot2')
library(ggplot2)
ggplot() + geom_point(aes(x = base$idade, y = base$custo), colour = 'blue') +
  geom_line(aes(x = base$idade, y = previsoes), colour = 'red') +
  ggtitle('Idade x custo') + xlab('Idade') + ylab('Custo')

idade = c(40)
df = data.frame(idade)

previsao1 = predict(regressor, newdata = df)
previsao2 = b0 + b1 * 40