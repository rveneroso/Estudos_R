sigmoid  <- function(soma) {
  return(1 / (1 + exp(-soma)))
}

# a <- sigmoid(0)
# b <- exp(0)

entradas <- matrix(c(0, 0, 0, 1, 1, 0, 1, 1),
                   nrow = 4,
                   ncol = 2,
                   byrow = T)

saidas <- data.matrix(c(0, 1, 1, 0))

pesos0 <- matrix(
  c(-0.424,-0.740,-0.961,
    0.358,-0.577,-0.469),
  nrow = 2,
  ncol = 3,
  byrow = T
)

pesos1 <- matrix(
  c(-0.017,-0.893, 0.148),
  nrow = 3,
  ncol = 1,
  byrow = T
)

epocas <- 100

for (j in 1:epocas) {
  camadaEntrada <- entradas
  somaSinapses0 <- camadaEntrada %*% pesos0
  camadaOculta <- sigmoid(somaSinapses0)
}
