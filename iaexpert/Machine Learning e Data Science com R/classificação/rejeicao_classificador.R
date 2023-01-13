base = read.csv('credit_data.csv')
base$clientid = NULL
base$age = ifelse(base$age < 0, 40.92, base$age)
base$age = ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)
base[, 1:3] = scale(base[, 1:3])
base$default = factor(base$default, levels = c(0,1))

rfFinal = readRDS('rfFinal.rds')
rnaFinal = readRDS('rnaFinal.rds')

previsoesrf = predict(rfFinal, newdata = base[4,-4])
previsoesrf = as.numeric(trimws(previsoesrf))

previsoesrna = predict(rnaFinal, newdata = as.h2o(base[4,-4]))
previsoesrna = previsoesrna[1]
previsoesrna = as.numeric(as.vector(previsoesrna))

probrf = predict(rfFinal, newdata = base[4,-4], type = 'prob')
confiancarf = max(probrf)

probrna = predict(rnaFinal, newdata = as.h2o(base[4,-4]))
confiancarna = max(probrna[2:3])

classe_0 = 0
classe_1 = 0
confianca_minima = 1

if (confiancarf >= confianca_minima) {
  if (previsoesrf == 1) {
    classe_1 = classe_1 + 1
  } else {
    classe_0 = classe_0 + 1
  }
}

if (confiancarna >= confianca_minima) {
  if (previsoesrna == 1) {
    classe_1 = classe_1 + 1
  } else {
    classe_0 = classe_0 + 1
  }
}

if (classe_0 > classe_1) {
  print('Classe 0')
} else if (classe_0 == classe_1) {
  print('Empate')
} else {
  print('Classe 1')
}