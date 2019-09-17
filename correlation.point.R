library(ggplot2)
args = commandArgs(T)
index = 0
for (each_file in args) {
    a = unlist(strsplit(each_file,"/"))
    name = a[length(a)]
    name = unlist(strsplit(name, "\\."))[1]
    data = read.table(each_file, header=T)
        #cor(x=log(data[,2],10),y=log(data[,3],10),method="spearman"
    c = cor(data[,2],data[,3],method="pearson") # person coefficient of association
    d = cor(data[,2],data[,3],method="spearman") # spearman coefficient of association
    if(max(data[,2])>max(data[,3])){
	    max_scale = max(data[,2])
    }else{
	    max_scale = max(data[,3])
    }
    if(min(data[,2])>min(data[,3])){
	    min_scale = min(data[,3])
    }else{
	    min_scale = min(data[,2])
    }
    ggplot(data, aes(data[,2], data[,3])) +
        geom_point(size=1.5) + # default size is 2
	# geom_abline()+ # line: y=x
        xlab(names(data)[2]) + ylab(names(data)[3]) +
    	annotate("text",x=-Inf,y= Inf,hjust=0,vjust=0.99,label=paste(paste( "pearson", round(c,4), sep=":"),paste("spearman", round(d,4), sep=":"),sep=("\n"))) +
	# xlim(min(data[,2]),max(data[,2])) +
	# scale_x_continuous(limits=c(0,max_scale))+
	scale_x_continuous(limits=c(min_scale, max_scale))+
	# scale_y_continuous(limits=c(0,max_scale))+
	scale_y_continuous(limits=c(min_scale, max_scale))+
	theme(panel.background = element_blank(),
	      panel.border = element_rect(fill=NA),
	      axis.line = element_line())
    outputname = paste(name, index, "corelation.jpg", sep=".")
    print(outputname)
    ggsave(outputname)
    index = index + 1
    
}
