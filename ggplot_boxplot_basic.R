library(ggplot2)
args = commandArgs(T)
	
a = unlist(strsplit(args[1], "/"))
name = a[length(a)]
name = unlist(strsplit(name,"\\."))[1]

data = read.table(args[1], header=F)
colnames(data)[value_column] <- "value"
ggplot(data,aes(y=data$value)) + 
	geom_boxplot() + 
	xlab("") + ylab("") + 
	ggtitle(name)+
	theme(legend.title=element_blank(),
	      panel.background = element_blank(),
	      axis.line = element_line(),
	      panel.border = element_rect(fill=NA),
	      )+
	scale_y_continuous(limits=c(0,150),breaks=seq(0,150,5))
	#scale_fill_manual(values=c("white","grey"))
output_file_name = paste(name,"basic.boxplot.png",sep=".")
ggsave(output_file_name)
print(paste("output file is : ",output_file_name,sep=""))
