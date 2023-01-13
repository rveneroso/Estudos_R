base = read.csv('credit_data.csv')
base$age = ifelse(base$age < 0, 40.92, base$age)

# income x age
plot(base[,2], base[,3])

# income x loan
plot(base[,2], base[,4])

# age x loan
plot(base[,3], base[,4])

census = read.csv('census.csv')

# age x final weight
plot(census[,2], census[,4])
