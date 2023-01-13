base = read.csv('credit_data.csv')

# outlier idade
boxplot(base$age, outline = TRUE)
boxplot.stats(base$age)$out
outlier_age = base[base$age < 0, ]

# outlier loan
boxplot(base$loan)
boxplot.stats(base$loan)$out
outliers_loan = base[base$loan > 13100,]

# outlier income
boxplot(base$income)