data = read.table("mydata.mix.common.right.txt",header = F)
#head(data, num=10L)
names(data) = c("symbol", "type", "id", "gene", "identity", "length", "A","B","C","D","E","F","G","evalue","bitscore")

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
data2 = subset(data, evalue >1e-10)
ggplot(data2, aes(x=evalue, y=length, colour=symbol)) + geom_point(alpha=.4)
ggsave("myplot.png", width=8, height=8, unit="cm", dpi=300)
