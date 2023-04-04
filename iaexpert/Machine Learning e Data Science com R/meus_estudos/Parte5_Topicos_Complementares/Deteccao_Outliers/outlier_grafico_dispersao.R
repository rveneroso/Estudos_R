credit = read.csv('credit_data.csv')
# Substitui as idades negativas presentes na base de dados pelo valor 40.92 que é a média da idade nessa base.
# Antes desse ajustes os gráficos de dispersão estavam apresentando outliers justamente por causa das idades negativas.
# Após o ajuste, não há mais outliers nos gráficos.
credit$age = ifelse(credit$age < 0, 40.92, credit$age)

census = read.csv('census.csv')

# income x age
plot(credit$income, credit$age)

# income x loan
plot(credit$income, credit$loan)

# age x loan
plot(credit$age, credit$loan)

# age x final weight
# Existem outliers no atributo final.weight mas eles não foram explorados na aula.
plot(census$age, census$final.weight)
max(census$final.weight)
census_outliers = census[census$final.weight> 1100000, ]
