# Lembrando que o diret?rio de trabalho ? /home/rveneroso/Estudos_R/iaexpert/Machine Learning e Data Science com R
# L? o arquivo credit_data.csv e carrega seu conte?do na vari?vel base
base = read.csv('classifica??o/credit_data.csv')

# Remove o atributo clientId do dataframe
base$clientid = NULL

# Mostra um resumo das informa??es do dataframe
summary(base)

# Filtra as linhas nas quais o atributo age ? menor que zero e n?o pode ser nulo.
# Ap?s a v?rgula devem vir os atributos que se deseja visualizar no filtro. Em R os ?ndices dos atributos come?am em 1.
# Como aqui n?o ? informado nenhum atributo espec?fico, ent?o ser?o mostrados todos os atributos das linhas que satisfazem
# a condi??o do filtro.
base[base$age<0 & !is.na(base$age),]

# Formas de se resolver o problema de dados inv?lidos em um dataframe
# Primeira: apagar toda a coluna 
base$age = NULL

# Segunda: descartar os registros que cont?m os dados inv?lidos
base = base[base$age > 0,]

# Terceira: obter as informa??es e inclu?-las no dataframe.

# Quarta: preencher os valores faltantes com a idade m?dia do dataframe. No c?lculo da m?dia s?o desprezados os registros
# nos quais a idade est? negativa.
base$age[base$age < 0 | is.na(base$age)] = mean(base$age[base$age > 0], na.rm = TRUE)

# Uma outra forma de se fazer a atualiza??o seria:
base$age = ifelse(base$age < 0, 40.92, base$age)

# A linha acima faz o seguinte: se o valor do atributo age for < 0, ent?o ele recebe o valor 40.92. Caso contr?rio
# recebe o valor que j? existe no atributo. Vale lembrar que nesse caso, as linhas que n?o possuem valor no atributo
# age ficar?o sem atualiza??o.

mean(base$age)
