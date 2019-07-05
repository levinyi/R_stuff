library(ggplot2)
library(cowplot)
data = read.table("boxplot.data.txt",header = T)

data1 = data[data$type =='SR',] 
data2 = data[data$type =='V-height',]
data3 = data[data$type == 'Total_cover',]

p1 = ggplot(data1,aes(x=data1$Flag,y=data1$value,fill=data1$Flag)) + geom_boxplot() + xlab("SR") + ylab("m2") +
  ggtitle("sample SR")+theme(legend.title=element_blank()) + scale_fill_manual(values=c("white","grey"))
p2 = ggplot(data2,aes(x=data2$Flag,y=data2$value,fill=data2$Flag)) + geom_boxplot() + xlab("V-height") + ylab("cm")+
  ggtitle("sample V-hight")+theme(legend.title=element_blank()) + scale_fill_manual(values=c("white","grey"))
p3 = ggplot(data3,aes(x=data3$Flag,y=data3$value,fill=data3$Flag)) + geom_boxplot() + xlab("total_cover") + ylab("pct") +
  ggtitle("sample Total_cover")+theme(legend.title=element_blank()) + scale_fill_manual(values=c("white","grey"))
ggdraw() +
  draw_plot(p1, 0,    0, 0.33, 1)+
  draw_plot(p2, 0.33, 0, 0.33, 1)+
  draw_plot(p3, 0.66, 0, 0.33, 1)

ggsave("boxplot.png",height=7,width=21)
