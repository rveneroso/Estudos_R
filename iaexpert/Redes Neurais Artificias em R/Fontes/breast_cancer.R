# Implementação manual da função sigmoide. Essa função nunca retorna valores negativos. O seu retorno será sempre
# um número entre 0 e 1.
sigmoid  <- function(soma) {
  return(1 / (1 + exp(-soma)))
}

# Calcula a derivada do valor de retorno da função sigmoide
sigmoidDerivada <- function(sig) {
  return(sig * (1 - sig))
}

a <- sigmoid(0)
# b <- exp(0)
# Ainda que o valor passado à função sigmoide seja negativo, o retorno da função sigmoide não será negativo: será um
# valor entre 0 e 1.
neg_number = -13
neg_sigmoide <- sigmoid(-13)
# print(paste("sigmoide de ", neg_number, " é ", format(neg_sigmoide,scientific = FALSE)))

# Quanto maior o valor passado à função signmoide, mais próximo de1 será o resultado da função. No exemplo abaixo o
# retorno é 1 embora tenha sido passado o valor 1 milhão à função. Novamente: o retorno da função será um valor entre
# 0 e 1.
higher <- sigmoid(1000000)
# print(higher)

# Início da criação da rede neural

# Cria a matriz contendo os dados de entrada a partir do arquivo entradas.csv
entradas <- read.csv("entradas.csv")
entradas <- data.matrix(entradas)

# Cria a matriz contendo os dados de saída a partir do arquivo saidas
saidas <- read.csv("saidas.csv")
saidas <- data.matrix(saidas)

# Criando a matriz pesos0 com valores aleatórios
pesos0 <- matrix(runif(90, min = -1, max = 1), nrow = 30, ncol = 3, byrow = T)

# Criando a matriz pesos1 com valores aleatórios.
pesos1 <- matrix(runif(3, min = -1, max = 1), nrow = 3, ncol = 1, byrow = T)

# Cria a variável que irá definir quantas vezes será executado o processo de ajustes dos pesos até se obter o melhor
# resultado. Em problemas do mundo real é muito difícil chegar a uma condição em que o erro seja 0 (como foi feito no
# exemplo do perceptron de 1 camada). Por isso, geralmente se define o número máximo de ajustes a serem realizados nos
# pesos. O que se espera é que, dentro desse número de ajustes, chegue-se ao melhor resultado da rede neural.
epocas <- 100000

# Em todo o curso os cálculos foram feitos considerando-se a variável momento com valor 1
momento <- 1
taxaAprendizagem <- 0.1

# Executa 100 vezes o processo de ajuste dos pesos
for (j in 1:epocas) {
  
  # A variável camadaEntrada recebe o valor da variável entradas. Isso foi feito para não se alterar a camada inicial.
  camadaEntrada <- entradas
  
  # Realiza o dot product entre a matriz definida em camadaEntrada e a matriz pesos0. A matriz somaSinapses0 será uma
  # matriz de 3 linhas e 4 colunas. São 3 linhas porque há 3 neurônios na primeira camada oculta e são 4 colunas
  # porque há 4 linhas na camada inicial, cada linha contendo os 2 neurônios da camada inicial.
  somaSinapses0 <- camadaEntrada %*% pesos0
  
  # A variável camadaOculta receberá o resultado da função de ativação (sigmoide) aplicada a cada soma da multiplicação
  # dos pesos de cada neurônio da camada principal pelos pesos definidos em relação aos neurônios da primeira camada
  # oculta.
  # Em caso de dúvidas, rever os números apresentados nos slides 12 a 15 do pdf 'Redes neurais multicamadas'.
  camadaOculta <- sigmoid(somaSinapses0)
  
  # A variável somaSinapses1 conterá a soma da multiplicação dos valores dos neurônios da primeira camada oculta
  # pelos pesos calculados para esses neurônios. Ela é uma matriz de 4 linhas e (porque a matriz entradas tem 4 linhas
  # e 1 coluna porque é o resultado da soma para aquela linha).
  somaSinapses1 <- camadaOculta %*% pesos1
  
  # A variável camadaSaida conterá o resultado da aplicação da função sigmoide sobre cada um dos valores presentes
  # na variável somaSinapses1. Assim como a matriz somaSinapses1, ela é uma matriz de 4 linhas e 1 coluna.
  camadaSaida <- sigmoid(somaSinapses1)
  
  # Calcula o erro. Com o R, a subtração de matrizes pode ser feita com uma única operação. Assim, basta subtrair
  # a matriz de saídas (resultado conhecido) da matriz de saídas calculadas pela rede neural.
  erroCamadaSaida <- saidas - camadaSaida
  
  # Obtém o valor do erro médio desconsiderando-se valores negativos.
  mediaAbsoluta <- mean(abs(erroCamadaSaida))
  print(paste("Erro: ", mediaAbsoluta))
  
  # Calcula a derivada para o valor da camada de saída. Observar que trata-se de uma operação envolvendo
  # matrizes.
  derivadaSaida <- sigmoidDerivada(camadaSaida)
  
  # Calcula o delta com base no erro e na derivada da camada de saída.
  deltaSaida <- erroCamadaSaida * derivadaSaida
  
  # A linha abaixo resulta em erro porque as matrizes deltaSaida e pesos1 são
  # de diferentes dimensões. Portanto, não é possível multiplicá-las diretamente.
  # deltaSaidaXPeso <- deltaSaida %*% pesos1
  # A solução para o problema acima é fazer a transposição de uma das matrizes.
  # A transposição abaixo gera uma matriz de 1 linha e 3 colunas (pesos1 é uma
  # matriz de 3 linhas e 1 coluna).
  pesos1Transposta = t(pesos1)
  
  # Agora é possível realizar a multiplicação de matrizes para obtermos
  # deltaSaidaXPeso. O resultado é uma matriz de 4 linhas e 3 colunas. As
  # 4 linhas correspondem aos pares de neurônios da camada oculta e as 3
  # linhas correspondem aos 3 pesos existentes entre a camada oculta e a
  # camada de saída. Em caso de dúvida, rever slides.
  deltaSaidaXPeso = deltaSaida %*% pesos1Transposta
  
  # Calcula o delta da camada oculta.
  deltaCamadaOculta <-deltaSaidaXPeso * sigmoidDerivada(camadaOculta)
  
  # Faz a transposição da matriz da camada oculta. Cada coluna da matriz gerada corresponde a cada um dos
  # registros utilizados na rede neural (os 4 registros das combinações do operador XOR). Cada coluna dessa
  # mesma matriz corresponde a um neurônio da camada oculta.
  camadaOcultaTransposta <- t(camadaOculta)
  
  pesosNovo1 <- camadaOcultaTransposta %*% deltaSaida
  pesos1 <- (pesos1 * momento) + (pesosNovo1 * taxaAprendizagem)
  
  # Revisar essa parte do código acompanhando com os slides ou com a aula "Implementação rede multicamada 10".
  # Sinceramente, já me perdi nos cálculos nesse ponto do código.
  camadaEntradaTransposta <- t(camadaEntrada)
  pesosNovo0 <- camadaEntradaTransposta %*% deltaCamadaOculta
  pesos0 <- (pesos0 * momento) + (pesosNovo0 * taxaAprendizagem)
  
  camadaEntradaTransposta <- t(camadaEntrada)
  pesosNovo0 <- camadaEntradaTransposta %*% deltaCamadaOculta
  pesos0 <- (pesos0 * momento) + (pesosNovo0 * taxaAprendizagem)
}
