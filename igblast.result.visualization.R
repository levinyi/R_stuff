#data = read.table("mydata.mix.common.right.txt",header = F)
#head(data, num=10L)
#names(data) = c("symbol", "type", "id", "gene", "identity", "length", "A","B","C","D","E","F","G","evalue","bitscore")

library(ggplot2)

# identity
# mv Rplots.pdf Rplots.identity.pdf
#ggplot(data, aes(x=symbol, y=identity)) + geom_violin()

# length
# mv Rplots.pdf Rplots.length.pdf
#ggplot(data, aes(x=symbol, y=length)) + geom_violin()

# evalue 
# mv Rplots.pdf Rplots.evalue.pdf
#ggplot(data, aes(x=symbol, y=log(evalue))) + geom_violin()

# length and e-value

#ggplot(data, aes(x=evalue, y=length, colour=symbol)) + geom_point(alpha=.4)
#data2 = subset(data, evalue < 1e-10)
#jpeg("myplot.test.jpeg", unit="px")
#ggplot(data2, aes(x=evalue, y=length, colour=symbol)) + geom_point(alpha=.04, size=0.01)
#jpg("myplot.test.jpg", width=40, height=20, unit="cm", dpi=72)

data3 = read.table("mydata.mix.common.right.fish.4gene.txt", header=F)
names(data3) = c("symbol", "type", "id", "gene", "identity", "length", "A","B","C","D","E","F","G","evalue","bitscore")
jpeg("myplot.2.jpeg", unit="px")
ggplot(data3, aes(x=evalue, y=length, colour=symbol)) + geom_point(alpha=.04, size=0.01)
dev.off()

