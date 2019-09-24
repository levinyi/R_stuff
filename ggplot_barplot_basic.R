library(ggplot2)
args= commandArgs(T)


data = read.table(args[1],header=F)
ggplot(data, aes(x=data$1,y=..count..)) + geom_bar() +
	xlab() + ylab()

