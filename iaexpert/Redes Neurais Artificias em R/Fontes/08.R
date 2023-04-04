# revisar slide neurônio artificial
# testar com os 2 neurônios do slide

entradas <- c(-1, 7, 5)
pesos <- c(0.8, 0.1, 0)

soma <- function(e, p) {
  # Nessa versão do código está sendo feito o for tradicional que tem custo computacional elevado se considerarmos
  # a grande quantidade de dados que as redes neurais geralmente manipulam.
  s <- 0
  for (i in 1:3) {
    #print(entradas[i])
    #print(pesos[i])
    s <- s + (e[i] * p[i])
  }
  return (s)
}

s <- soma(entradas, pesos)

stepFunction <- function(soma) {
  if (soma >= 1) {
    return (1)
  }
  return (0)
}

r <- stepFunction(s)
