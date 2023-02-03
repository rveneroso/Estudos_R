library(arules)

base = read.transactions('mercado2.csv', sep = ',', rm.duplicates = TRUE)
summary(base)

itemFrequencyPlot(base, topN = 7)

regras = apriori(data = base, parameter = list(support = 0.003, confidence = 0.2))

inspect(sort(regras, by = 'lift')[1:20])