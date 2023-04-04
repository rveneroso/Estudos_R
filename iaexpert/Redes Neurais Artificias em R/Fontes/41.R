sigmoid  <- function(soma) {
  return(1 / (1 + exp(-soma)))
}

sigmoidDerivada <- function(sig) {
  return(sig * (1 - sig))
}

# a <- sigmoid(0.5)
# b <- sigmoidDerivada(a)

# a <- sigmoid(0)
# b <- exp(0)

entradas <- matrix(c(0, 0, 0, 1, 1, 0, 1, 1),
                   nrow = 4,
                   ncol = 2,
                   byrow = T)

saidas <- data.matrix(c(0, 1, 1, 0))

#pesos0 <- matrix(c(-0.424, -0.740, -0.961,
#                   0.358, -0.577, -0.469),
#                 nrow = 2, ncol = 3, byrow = T)

#pesos1 <- matrix(c(-0.017, -0.893, 0.148),
#                 nrow = 3, ncol = 1, byrow = T)

pesos0 <- matrix(
  runif(6, min = -1, max = 1),
  nrow = 2,
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
taxaAprendizagem <- 0.3
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
