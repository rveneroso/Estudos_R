# O parâmetro byrow = T faz com a matriz seja preenchida por linhas. Caso contrário, seria preenchida por colunas.
# Será criada uma matriz de 4 linhas com 2 colunas em cada linha.
entradas <-
  matrix(c(0, 0, 0, 1, 1, 0, 1, 1),
         nrow = 4,
         ncol = 2,
         byrow = T)

# A variávei saidas será uma matriz de 4 linhas e uma coluna. Ela contém os resultados corretos da classificação.
saidas <- data.matrix(c(0, 0, 0, 1))

# Matriz dos pesos iniciais a serem usados nos cálculos da rede neural.
pesos <- data.matrix(c(0.0, 0.0))

# Define a taxa de aprendizagem que será aplicada em cada etapa da rede neural.
taxaAprendizagem <- 0.1

# Função que retorna o resultado da função step. Somente retorna 1 se o valor de soma for maior ou igual a 1.
# Caso contrário, retorna 0.
stepFunction <- function(soma) {
  if (soma >= 1) {
    return (1)
  }
  return (0)
}

# Calcula a saída de cada par de neurônios (x1 e x2 de acordo com o slide).
calculaSaida <- function(registro) {
  # registro contém uma linha da matriz saidas. Cada linha possui duas colunas, cada coluna correspondendo a
  # um neurônio. Assim, a variável s recebe a multiplicação dos valores dos neurônios pela matriz pesos.
  # A matriz pesos terá seu valor atualizado ao longo da execução de acordo com a taxa de aprendizagem.
  s <- registro %*% pesos
  return (stepFunction(s))
}

# Esse é o algoritmo de cálculo da rede neural. O loop while será executado enquanto o erro for diferente de zero.
erroTotal <- 1
while (erroTotal != 0) {
  erroTotal <- 0
  # Percorre a matriz saidas.
  for (i in 1:length(saidas)) {
    # Obtem uma linha da matriz entradas e a submete à função calculaSaida onde os valores dos neurônios serão
    # multiplicados pelos pesos atuais.
    saidaCalculada <- calculaSaida(c(entradas[i,]))
    # Calcula a diferença entre o valor esperado, armazenado na matriz saidas, e o valor calculado para a linha
    # atual da matriz entradas.
    erro <- abs(saidas[i] - saidaCalculada)
    # Acumula o erro gerado para cada par de neurônios da matriz entradas.
    erroTotal <- erroTotal + erro
    for (j in 1:length(pesos)) {
      # Atualiza a matriz de pesos de acordo com a taxa de aprendizagem e o erro calculado para a linha atual
      # da matriz entradas.
      pesos[j] <- pesos[j] + (taxaAprendizagem * entradas[i, j] * erro)
      print(paste('Peso atualizado: ', pesos[j]))
    }
  }
  print(paste('Total de erros: ', erroTotal))
}