entradas <- c(-11, 7, 5)
pesos <- c(0.8, 0.1, 0)

soma <- function(e, p) {
  # A linha abaixo substitui o for e a multiplicação individual dos elementos dos vetores entradas e pesos.
  return (e %*% p)
  # dot product / produto escalar
}

s <- soma(entradas, pesos)

stepFunction <- function(soma) {
  if (soma >= 1) {
    return (1)
  }
  return (0)
}

r <- stepFunction(s)
