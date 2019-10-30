library(ggplot2)
require(cowplot)

# args = commandArgs(T)
data = read.table("all_sample_1M_bin_reads_pct.xls",header = F)
#data = read.table(args[1], header=F)
data$V5 = factor(data$V5,labels = c("IS","Health"))

p1 = ggplot(data[data$V2=="chr1",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr1") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p2 = ggplot(data[data$V2=="chr2",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr2") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p3 = ggplot(data[data$V2=="chr3",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr3") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p4 = ggplot(data[data$V2=="chr4",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr4") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p5 = ggplot(data[data$V2=="chr5",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr5") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p6 = ggplot(data[data$V2=="chr6",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr6") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p7 = ggplot(data[data$V2=="chr7",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr7") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p8 = ggplot(data[data$V2=="chr8",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr8") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p9 = ggplot(data[data$V2=="chr9",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr9") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p10 = ggplot(data[data$V2=="chr10",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr10") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p11 = ggplot(data[data$V2=="chr11",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr11") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p12 = ggplot(data[data$V2=="chr12",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr12") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p13 = ggplot(data[data$V2=="chr13",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr13") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p14 = ggplot(data[data$V2=="chr14",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr14") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p15 = ggplot(data[data$V2=="chr15",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr15") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p16 = ggplot(data[data$V2=="chr16",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr16") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p17 = ggplot(data[data$V2=="chr17",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr17") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p18 = ggplot(data[data$V2=="chr18",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr18") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p19 = ggplot(data[data$V2=="chr19",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr19") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p20 = ggplot(data[data$V2=="chr20",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr20") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p21 = ggplot(data[data$V2=="chr21",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr21") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p22 = ggplot(data[data$V2=="chr22",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chr22") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p23 = ggplot(data[data$V2=="chrX",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chrX") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p24 = ggplot(data[data$V2=="chrY",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chrY") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())
p25 = ggplot(data[data$V2=="chrM",], aes(x=V3,y=V4,label=round(V4, digits = 2),group=V5,color=V5))+stat_summary(fun.y="mean",geom = "point") +
  xlab("bins") + ylab("mean percentage") +ggtitle("chrM") +theme(plot.title = element_text(hjust = 0.5))+
  scale_y_continuous(labels=scales::percent, expand=c(0,0))+expand_limits(x=0)+scale_x_continuous(expand = c(0, 0))+theme(legend.title = element_blank())


ggdraw() +
  draw_plot(p1 , 0,    0.8, 0.2, 0.2) +
  draw_plot(p2 , 0.2,  0.8, 0.2, 0.2) +
  draw_plot(p3 , 0.4,  0.8, 0.2, 0.2) +
  draw_plot(p4 , 0.6,  0.8, 0.2, 0.2) +
  draw_plot(p5 , 0.8,  0.8, 0.2, 0.2) +
  draw_plot(p6 , 0,    0.6, 0.2, 0.2) +
  draw_plot(p7 , 0.2,  0.6, 0.2, 0.2) +
  draw_plot(p8 , 0.4,  0.6, 0.2, 0.2) +
  draw_plot(p9 , 0.6,  0.6, 0.2, 0.2) +
  draw_plot(p10, 0.8,  0.6, 0.2, 0.2) +
  draw_plot(p11, 0,    0.4, 0.2, 0.2) +
  draw_plot(p12, 0.2,  0.4, 0.2, 0.2) +
  draw_plot(p13, 0.4,  0.4, 0.2, 0.2) +
  draw_plot(p14, 0.6,  0.4, 0.2, 0.2) +
  draw_plot(p15, 0.8,  0.4, 0.2, 0.2) +
  draw_plot(p16, 0,    0.2, 0.2, 0.2) +
  draw_plot(p17, 0.2,  0.2, 0.2, 0.2) +
  draw_plot(p18, 0.4,  0.2, 0.2, 0.2) +
  draw_plot(p19, 0.6,  0.2, 0.2, 0.2) +
  draw_plot(p20, 0.8,  0.2, 0.2, 0.2) +
  draw_plot(p21, 0,    0,   0.2, 0.2) +
  draw_plot(p22, 0.2,  0,   0.2, 0.2) +
  draw_plot(p23, 0.4,  0,   0.2, 0.2) +
  draw_plot(p24, 0.6,  0,   0.2, 0.2) +
  draw_plot(p25, 0.8,  0,   0.2, 0.2)
  
ggsave("1M_means.jpg")
  

