# Lembrando que o diretório de trabalho é /home/rveneroso/Estudos_R/iaexpert/Machine Learning e Data Science com R
# Lê o arquivo credit_data.csv e carrega seu conteúdo na variável base
base = read.csv('classificação/credit_data.csv')

# Remove o atributo clientId do dataframe
base$clientid = NULL

# Mostra um resumo das informações do dataframe
summary(base)

# Filtra as linhas nas quais o atributo age é menor que zero e não pode ser nulo.
# Após a vírgula devem vir os atributos que se deseja visualizar no filtro. Em R os índices dos atributos começam em 1.
# Como aqui não é informado nenhum atributo específico, então serão mostrados todos os atributos das linhas que satisfazem
# a condição do filtro.
base[base$age<0 & !is.na(base$age),]

# Formas de se resolver o problema de dados inválidos em um dataframe
# Primeira: apagar toda a coluna 
base$age = NULL

# Segunda: descartar os registros que contém os dados inválidos
base = base[base$age > 0,]

# Terceira: obter as informações e incluí-las no dataframe.

# Quarta: preencher os valores faltantes com a idade média do dataframe. No cálculo da média são desprezados os registros
# nos quais a idade está negativa.
base$age[base$age < 0 | is.na(base$age)] = mean(base$age[base$age > 0], na.rm = TRUE)

# Uma outra forma de se fazer a atualização seria:
base$age = ifelse(base$age < 0, 40.92, base$age)

# A linha acima faz o seguinte: se o valor do atributo age for < 0, então ele recebe o valor 40.92. Caso contrário
# recebe o valor que já existe no atributo. Vale lembrar que nesse caso, as linhas que não possuem valor no atributo
# age ficarão sem atualização.

mean(base$age)
