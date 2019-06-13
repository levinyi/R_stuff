library(ggplot2)
args=commandArgs(T)
data = read.table(args[1],header=F)
#head(data)
#new_data = data[data$V3>=3,]
#head(new_data)
ggplot(data,aes(x=data$V2)) + geom_histogram(aes(y =..count..), binwidth=1)
ggsave("histogram.jpg")
print("output is : histogram.jpg")
