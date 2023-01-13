base = read.csv('credit_data.csv')
base$clientid = NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] = scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

library(randomForest)
classificadorRandomForest = randomForest(x = base[-4], y = base$default, ntree = 30, mtry = 2)

library(h2o)
h2o.init(nthreads = -1)
classificadorRedeNeural = h2o.deeplearning(y = 'default', training_frame = as.h2o(base),
                                           activation = 'Rectifier', hidden = c(100), epochs = 100)
saveRDS(classificadorRandomForest, 'rfFinal.rds')
saveRDS(classificadorRedeNeural, 'rnaFinal.rds')

rfFinal = readRDS('rfFinal.rds')
rnaFinal = readRDS('rnaFinal.rds')

previsoesrf = predict(rfFinal, newdata = base[1,-4])
previsoesrf = as.numeric(trimws(previsoesrf))

previsoesrna = predict(rnaFinal, newdata = as.h2o(base[1,-4]))
previsoesrna = previsoesrna[1]
previsoesrna = as.numeric(as.vector(previsoesrna))

classe_0 = 0
classe_1 = 0

if (previsoesrf == 1) {
  classe_1 = classe_1 + 1
} else {
  classe_0 = classe_0 + 1
}

if (previsoesrna == 1) {
  classe_1 = classe_1 + 1
} else {
  classe_0 = classe_0 + 1
}

if (classe_0 > classe_1) {
  print('Classe 0')
} else if (classe_0 == classe_1) {
  print('Empate')
} else {
  print('Classe 1')
}