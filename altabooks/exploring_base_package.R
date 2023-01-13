5+4     # Adição
6-2     # Subtração
7*3     # Multiplicação
45/9    # Divisão
2^2     # Potência
sqrt(121) # Raiz quadrada
exp(0) # Exponencial
log(1) # Log na base e
log10(1) # Log na base 10
log2(4) # Log na base 2
log(9,3) # Log na base 3 ou qualquer outra

# Cria um vetor de 3 elementos
c(7, 4, 1)

# Cria um vetor de strings
c("sete", "quatro", "um")

# Cria uma sequência de números inteiros entre 5 e 35. A linha abaixo cria um vetor não associado a nenhuma
# variável. Em R, quando os elementos de um vetor são exibidos, a posição do primeiro elemento a ser exibido
# é mostrada entre colchetes.
5:35

# Nota de 3 avaliações do aluno 1
# Armazenada no objeto Nota.aluno1
Nota.aluno1 = c(8, 8.6, 8.8)

# Nota de 3 avaliações do aluno 2
# Armazenada no objeto Nota.aluno2
Nota.aluno2 = c(7.3, 6.7, 7)

# Exibindo o valor de uma variável
Nota.aluno1
Nota.aluno2

# Criando um dataframe onde cada coluna é um dos vetores criados acima.
notas = data.frame(Nota.aluno1, Nota.aluno2)
notas

# Visualizando os dados do dataframe de maneira semelhante a uma tabela HTML.
View(notas)

# Cria um vetor que será associado ao dataframe criado anteriormente.
Tipo = c("Prova A", "Prova B", "Prova C")

# Acrescenta o vetor Tipo ao objeto notas
notas = data.frame(notas, Tipo)
notas

# Matrizes diferem de dataframes no sentido de que nas matrizes as linhas ou colunas são formadas por vetores
# exclusivamente numéricos ou de caracteres. Em dataframes os tipos podem aparecer misturados.

# Cria uma matriz por colunas. Isto é, os dados do vetor Nota.aluno1 estarão na primeira coluna da matriz enquanto que
# os dados de Nota.aluno2 estarão na segunda coluna da matriz.
Mc = cbind(Nota.aluno1, Nota.aluno2)
Mc

# Cria uma matriz por linhas. Isto é, os dados do vetor Nota.aluno1 estarão na primeira linha da matriz enquanto que
# os dados do vetor Nota.aluno2 estrão na segunda linha da matriz.
Mr = rbind(Nota.aluno1, Nota.aluno2)
Mr

# Ao se adicionar a uma matriz vetores de tipos numérico e caracter, ocorre uma conversão implícita dos tipos numéricos
# para caracter.
M = cbind(Nota.aluno1, Nota.aluno2, Tipo)
M

# A soma abaixo é realizada sem problemas pois Mc e Mr têm valores numéricos.
Mc[1,1] + Mr[2,3]

# A mesma operação com M resulta em erro porque houve a conversão dos valores numéricos para caracter.
# Error in M[1, 1] + M[3, 2] : non-numeric argument to binary operator
M[1,1] + M[3,2]

# Analisando a estrutura do objeto M. OBSERVAÇÃO: não confundir a função str abaixo com string.
str(M)

# Acessando valores de posições específicas dos objetos
# Nota do aluno 1 na posição 2
Nota.aluno1[2]

# Posição 2 do vetor Tipo
Tipo[2]

# Valor da linha 1, coluna 2 da matriz Mc
Mc[1,2]

# Valor da linha 3, coluna 2 da matriz Mc
Mc[3,2]

# Todos os valores da coluna 2 da matriz notas
notas[,2]

# Todos os valores da linha 2 da matriz notas
notas[2,]

# Valores do vetor Nota.aluno2 contido no objeto notas. Esse comando faz entender que, quando criamos objetos a
# partir de outros objetos em R, uma referência ao objeto original é mantida dentro do novo objeto. Não é apenas
# a cópia de valores que acontece. Se assim fosse, não seria possível referenciar o vetor Nota.aluno2 dentro do
# objeto notas.
notas$Nota.aluno2
