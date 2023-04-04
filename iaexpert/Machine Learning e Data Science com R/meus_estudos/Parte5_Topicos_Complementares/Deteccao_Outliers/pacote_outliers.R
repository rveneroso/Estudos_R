credit = read.csv('credit_data.csv')
census = read.csv('census.csv')

# install.packages('outliers')
library(outliers)

# inferior
outlier(credit$age)
# superior
outlier(credit$age, opposite = TRUE)

# income
outlier(credit$income)
outlier(credit$income, opposite = TRUE)

# loan
outlier(credit$loan)
outlier(credit$loan, opposite = TRUE)

# census
outlier(census$age)
outlier(census$final.weight)
