library(ggplot2)
args = commandArgs(T)
index = 0
for (each_file in args) {
    a = unlist(strsplit(each_file,"/"))
    name = a[length(a)]
    name = unlist(strsplit(name, "\\."))[1]
    data = read.table(each_file, header=T)
        #cor(x=log(data[,2],10),y=log(data[,3],10),method="spearman"
    c = cor(data[,2],data[,3],method="pearson")
    d = cor(data[,2],data[,3],method="spearman")
    ggplot(data, aes(data[,2], data[,3])) +
        geom_point(size=1.5) + # default size is 2
        geom_smooth(method=lm, se=FALSE) +
        xlab(names(data)[2]) + ylab(names(data)[3]) +
    	annotate("text",x=-Inf,y= Inf,hjust=0,vjust=0.99,label=paste(paste( "pearson", round(c,4), sep=":"),paste("spearman", round(d,4), sep=":"),sep=("\n"))) +
	xlim(min(data[,2]),max(data[,3]))
	#annotate("text",x=-Inf,y= Inf,hjust=0,vjust=1,label=paste("spearman", d, sep=":"))
    outputname = paste(name, index, "corelation.jpg", sep=".")
    #outputname = paste("03",as.character(index),"corelation.pdf",sep=".")
    #print(outputname)
    ggsave(outputname)
    index = index + 1
    
}
