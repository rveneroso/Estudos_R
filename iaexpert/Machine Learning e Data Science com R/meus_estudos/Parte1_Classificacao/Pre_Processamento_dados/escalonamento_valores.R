base = read.csv('credit_data.csv')
base$clientid = NULL
base$age[base$age < 0 | is.na(base$age)] = mean(base$age[base$age > 0], na.rm = TRUE)

# O R tem uma fun??o que faz o escalonamento de toda a base de uma s? vez. Por?m, o escalonamento n?o deve ser aplicado
# no atributo meta pois, al?m de n?o fazer sentido, dificulta o entendimento.
# Portanto, ser?o escalonados os atributos 1 a 3 em todas as linhas.
base[, 1:3] = scale(base[, 1:3])
