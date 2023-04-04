sigmoid  <- function(soma) {
  return(1 / (1 + exp(-soma)))
}

sigmoidDerivada <- function(sig) {
  return(sig * (1 - sig))
}

# dados de entrada
entradas <- read.csv("entradas.csv")
entradas <- data.matrix(entradas)

# dados de saidas
saidas <- read.csv("saidas.csv")
saidas <- data.matrix(saidas)

pesos0 <- matrix(
  # gera um valor aleatório entre -1 e 1
  runif(90, min = -1, max = 1),
  nrow = 30,
  ncol = 3,
  byrow = T
)

pesos1 <- matrix(
  runif(3, min = -1, max = 1),
  nrow = 3,
  ncol = 1,
  byrow = T
)

epocas <- 100000
taxaAprendizagem <- 0.5
momento <- 1

for (j in 1:epocas) {
  camadaEntrada <- entradas
  
  somaSinapses0 <- camadaEntrada %*% pesos0
  camadaOculta <- sigmoid(somaSinapses0)
  
  somaSinapses1 <- camadaOculta %*% pesos1
  camadaSaida <- sigmoid(somaSinapses1)
  
  erroCamadaSaida <- saidas - camadaSaida
  mediaAbsoluta <- mean(abs(erroCamadaSaida))
  print(paste("Erro: ", mediaAbsoluta))
  
  derivadaSaida <- sigmoidDerivada(camadaSaida)
  deltaSaida <- erroCamadaSaida * derivadaSaida
  
  pesos1Trasposta <- t(pesos1)
  deltaSaidaXPeso <- deltaSaida %*% pesos1Trasposta
  deltaCamadaOculta <-
    deltaSaidaXPeso * sigmoidDerivada(camadaOculta)
  
  camadaOcultaTransposta <- t(camadaOculta)
  pesosNovo1 <- camadaOcultaTransposta %*% deltaSaida
  pesos1 <- (pesos1 * momento) + (pesosNovo1 * taxaAprendizagem)
  
  camadaEntradaTransposta <- t(camadaEntrada)
  pesosNovo0 <- camadaEntradaTransposta %*% deltaCamadaOculta
  pesos0 <- (pesos0 * momento) + (pesosNovo0 * taxaAprendizagem)
}
