library(ggplot2)
library(hash)
args = commandArgs(T)

h = hash()
con = file(args[1], "r")
line = readLines(con,n=1)
while(length(line) != 0){
    name = unlist(strsplit(line,"\t"))
    gene = name[1]
    pos = name[2]

    .set(h,keys=gene, values=pos)
    line = readLines(con,n=1)
}
close(con)

for ( each_file in args[2:length(args)]) {
    path_list = unlist(strsplit(each_file,"/"))
    file_name = path_list[length(path_list)]
    gene_name = unlist(strsplit(file_name,"\\."))[1]
    title_name = paste(gene_name, unlist(strsplit(file_name,"\\."))[2], sep=".")

    if (has.key(gene_name, h)){
    	pos = as.numeric(h[[gene_name]])
    }else{
	pos = -50
    }

    data = read.table(each_file,header=F)
    ggplot(data, aes(x=data$V4, y=..count..)) +
    	geom_histogram(stat="bin", binwidth = 1,color="black", fill="white")+
            xlab("position") +
            scale_x_continuous(breaks=seq(-200,0,10), limits=c(-200,0)) +
            ggtitle(title_name) + theme(plot.title = element_text(hjust = 0.5)) +
        geom_vline(aes(xintercept=pos),colour="#BB0000", linetype="dashed")
    
    outputname = paste(title_name , "supported_reads.histogram.jpg",sep=".")
    ggsave(outputname)

}
