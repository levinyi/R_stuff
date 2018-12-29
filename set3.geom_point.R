library(ggplot2)
data = read.table("/cygene/work/09.Xi1/04.statistic/histogram.txt",header=F)
#names(data) =c("a","5p1","7p1","7p2")

#ggplot(data, aes(x=5p1, y=7p1, fill=a)) + geom_histogram()

#data = read.table("histogram.txt",header=F)
names(data) =c("a","b","c","d")

two_p = subset(data, a == "5p17p1", select = c(b,c,d))
ggplot(two_p, aes(x=b,y=c)) + geom_point() + xlab("b0005p1") + ylab("b0007p1") + theme_bw() + theme(panel.grid.minor.x = element_line(), panel.grid.minor.y = element_line())

eight_p = subset(data, a="5p17p2", select = c(b,c,d))
ggplot(eight_p, aes(x=b,y=d)) + geom_point() + xlab("b0005p1") + ylab("b0007p2") + theme_bw() + theme(panel.grid.minor.x = element_line(), panel.grid.minor.y = element_line())

hundred = subset(data, a="7p17p2", select = c(b,c,d))
ggplot(hundred, aes(x=c,y=d)) + geom_point() + xlab("b0007p71") + ylab("b0007p2") + theme_bw() + theme(panel.grid.minor.x = element_line(), panel.grid.minor.y = element_line())

seven = subset(data, a="common", select = c(b,c,d))
ggplot(seven, aes(x=b,y=c)) + geom_point() + xlab("b0005p1") + ylab("b0007p1") + theme_bw() + theme(panel.grid.minor.x = element_line(), panel.grid.minor.y = element_line())
ggplot(seven, aes(x=b,y=d)) + geom_point() + xlab("b0005p1") + ylab("b0007p2") + theme_bw() + theme(panel.grid.minor.x = element_line(), panel.grid.minor.y = element_line())

