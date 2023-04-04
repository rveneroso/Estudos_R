# byrow = T para preencrer a matriz por linhas, do contrario preenche por colunas
entradas <-
  matrix(c(0, 0, 0, 1, 1, 0, 1, 1),
         nrow = 4,
         ncol = 2,
         byrow = T)

# data.matrix() transforma em uma matriz de dados
saidas <- data.matrix(c(0, 0, 0, 1))
pesos <- data.matrix(c(0.0, 0.0))
taxaAprendizagem <- 0.1

stepFunction <- function(soma) {
  if (soma >= 1) {
    return (1)
  }
  return (0)
}

calculaSaida <- function(registro) {
  s <- registro %*% pesos
  return (stepFunction(s))
}

# mostrar slide com o algoritmo
erroTotal <- 1
while (erroTotal != 0) {
  erroTotal <- 0
  for (i in 1:length(saidas)) {
    saidaCalculada <- calculaSaida(c(entradas[i,]))
    erro <- abs(saidas[i] - saidaCalculada)
    erroTotal <- erroTotal + erro
    for (j in 1:length(pesos)) {
      pesos[j] <- pesos[j] + (taxaAprendizagem * entradas[i, j] * erro)
      print(paste('Peso atualizado: ', pesos[j]))
    }
  }
  print(paste('Total de erros: ', erroTotal))
}