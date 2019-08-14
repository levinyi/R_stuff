library(ggplot2)
args=commandArgs(T)
data = read.table(args[1],header=F)
#head(data)
#new_data = data[data$V3>=3,]
#head(new_data)

ggplot(data,aes(x=data$V2)) + 
	geom_histogram(aes(y =..count..), binwidth=1) +
	xlab("") +
	scale_x_continuous(limits=c(0, max(data$V2)), breaks=seq(0,100,1)) +
	
	theme(
	      panel.background = element_blank(),
	      axis.line = element_line(),
	      panel.border = element_rect(fill=NA)
	)

ggsave("Basic_histogram.jpg")
print("output is : Basic_histogram.jpg")
