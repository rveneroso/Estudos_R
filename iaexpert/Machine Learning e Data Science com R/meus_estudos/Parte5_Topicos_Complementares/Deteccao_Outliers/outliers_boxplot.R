base = read.csv('credit_data.csv')

# outlier idade
boxplot(base$age, outline = TRUE)
# A linha abaixo apresenta os valores que são outliers. Na console do R Studio são apresentadas 3 idades com valores 
# negativos.
boxplot.stats(base$age)$out
# A linha abaixo cria um data.frame somente com os registros que representam outliers. Vale observar que, registros 
# cuja coluna age contenha NA também serão considerados como outliers.
outlier_age = base[base$age < 0, ]

# outlier loan
# Verificando outliers no atributo loan.
boxplot(base$loan)
# Os outliers do atributo loan são valores de empréstimos acima de 13 mil dólares.
boxplot.stats(base$loan)$out
# A média dos empréstimos é de 4444 dólares.
mean(base$loan)
outliers_loan = base[base$loan > 13100,]

# outlier income
# O atributo income não possui outliers.
boxplot(base$income)
