library(ggplot2)
args = commandArgs(T)
for (each_file in args){
	a = unlist(strsplit(each_file,"/"))
	name = a[length(a)]
	name = unlist(strsplit(name,"\\."))[1]
	data = read.table(each_file,header=F)

	ggplot(data,aes(y=data$V2)) + 
		geom_boxplot() + 
		xlab("") + ylab("") + 
		#ggtitle("sample SR")+
		theme(legend.title=element_blank(),
		      panel.background = element_blank(),
		      axis.line = element_line(),
		      panel.border = element_rect(fill=NA),
		      )+
		scale_y_continuous(limits=c(0,150),breaks=seq(0,150,5))
		#scale_fill_manual(values=c("white","grey"))
	ggsave("boxplot.png")
}
