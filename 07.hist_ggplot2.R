# NO.1
data = read.csv("C:\\Users\\cy006\\Desktop\\01.R_test.csv", header=T)

# NO.2
data = read.table("C:\\Users\\cy006\\Desktop\\01.R_test.txt", header=T)

# NO.3
ID = c(0,1,2,3,4,5)
Gender = c('male','female','male','female','male','female')
Height = c(178,156,170,158,168,155)

# NO.4
# 次数直方图或频数直方图，
hist(Height,freq = T)
# 频率直方图
hist(Height,freq = F)
#NO.5
#install.packages("ggplot2")
library(ggplot2)

ggplot(data, aes(x=Height, y=..count..  )) + geom_histogram(stat="bin", binwidth = 4, colour="black", fill="white")
ggplot(data, aes(x=Height, y=..density..)) + geom_histogram(stat="bin", binwidth = 4, colour="black", fill="white")
