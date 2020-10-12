library(ggplot2)
library(RColorBrewer)
args = commandArgs(T)

theme_x_axis = theme(
  axis.text.x = element_text(size = 15),
  axis.text.y = element_text(size = 15),
)
common_themes = theme(plot.title = element_text(size = 17, hjust = 0.5),
                      panel.grid.major = element_line(colour = NA), # 去掉网格线
                      panel.background = element_blank(), # 去掉背景
                      panel.grid.major.x = element_line(),  # 横向网格线linetype=2,xuxian
                      panel.grid.major.y = element_line(), # 纵向网格线
                      panel.border = element_rect(fill=NA), # 边框
                      axis.line = element_line(), # 坐标轴线
                      axis.title = element_text(size = 17),
                      legend.title = element_blank(),
                      legend.position = c(0.95,0.95), # bottom, right, 'left'
                      legend.background = element_rect(colour = NA, fill = NA),
)


index = 0
for (each_file in args) {
    a = unlist(strsplit(each_file,"/"))
    name = a[length(a)]
    name = unlist(strsplit(name, "\\."))[1]
    data = read.table(each_file, header = T)
        #cor(x=log(data[,2],10),y=log(data[,3],10),method="spearman"
    data[,2] = data[,2] + 0.0000000001 # log(1,2) = 0
    data[,3] = data[,3] + 0.0000000001 # log(1,2) = 0
    c = cor(data[,2], data[,3], method = "pearson") # person coefficient of association
    d = cor(data[,2], data[,3], method = "spearman") # spearman coefficient of association
  
    #if(max(log(data[,2], 10)) > max(log(data[,3], 10))){
    #        max_scale = max(log(data[,2], 10))
    #}else{
    #        max_scale = max(log(data[,3], 10))
    #}
    p = ggplot(data, aes(data[,2], data[, 3])) +
    # ggplot(data, aes(log(data[,2], 10), log(data[,3], 10))) +
        geom_point(size=0.5, color=brewer.pal(7,"Set1")[2] ) + # default size is 2
        xlab(names(data)[2]) + ylab(names(data)[3]) +
        # annotate("text",x=-Inf,y= Inf,hjust=0,vjust=0.99,label=paste(paste( "pearson", round(c,4), sep=":"),paste("spearman", round(d,4), sep=":"),sep=("\n"))) +
        # scale_x_continuous(limits=c(0, max_scale))+
        # scale_y_continuous(limits=c(0, max_scale))+
        scale_x_log10() +
        scale_y_log10() +
        common_themes + theme_x_axis
    outputname = paste(name, index, "corelation.log.png", sep=".")
    print(outputname)
    ggsave(outputname, width=10, height=10)
    index = index + 1
    
}
