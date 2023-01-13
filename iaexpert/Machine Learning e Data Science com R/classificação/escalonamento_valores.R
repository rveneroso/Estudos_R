base = read.csv('classificação/credit_data.csv')
base$clientid = NULL
base$age[base$age < 0 | is.na(base$age)] = mean(base$age[base$age > 0], na.rm = TRUE)

# O R tem uma função que faz o escalonamento de toda a base de uma só vez. Porém, o escalonamento não deve ser aplicado
# no atributo meta pois, além de não fazer sentido, dificulta o entendimento.
# Portanto, serão escalonados os atributos 1 a 3 em todas as linhas.
base[, 1:3] = scale(base[, 1:3])
