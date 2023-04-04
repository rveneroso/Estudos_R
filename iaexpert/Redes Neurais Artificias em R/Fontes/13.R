# criar novo arquivo
# operador lógico E
# byrow = T para preencrer a matriz por linhas, do contrario preenche por colunas
entradas <-
  matrix(c(0, 0 , 0, 1 , 1, 0 , 1, 1),
         nrow = 4,
         ncol = 2,
         byrow = T)

# data.matrix() transforma em uma matriz de dados
saidas <- data.matrix(c(0, 0, 0, 1))
pesos <- data.matrix(c(0.0, 0.0)) # são as sinapses, zero porque foi definido assim no slide
taxaAprendizagem <- 0.1

stepFunction <- function(soma) {
  if (soma >= 1) {
    return (1)
  }
  return (0)
}

calculaSaida <- function(registro) {
  s <- registro %*% pesos
  return (stepFunction(s)) # mostrar slide
}

treinar <- function() {
  return(0)
}