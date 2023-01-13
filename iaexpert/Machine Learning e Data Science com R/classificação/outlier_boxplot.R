base = read.csv('credit_data.csv')

# outlier idade
boxplot(base[,3], outline = TRUE)
boxplot.stats(base[,3])$out
outliers_age = base[base$age < 0,]

# outlier loan
boxplot(base[,4])
boxplot.stats(base[,4])$out
outliers_loan = base[base$loan > 13200,]