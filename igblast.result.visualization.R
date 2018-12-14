data = read.table("mydata.mix.common.right.txt",header = F)
#head(data, num=10L)
names(data) = c("symbol", "type", "id", "gene", "identity", "length", "A","B","C","D","E","F","G","evalue","bitscore")
#head(data)

library(ggplot2)

# ggplot(data, aes(x=interaction(id, type), y=identity))+geom_point()
# ggplot(data, aes(x=symbol, y=identity))+geom_violin()
# Rplots.plot.pdf
# ggplot(data, aes(x=gene, y=identity, colour=symbol, shape=type)) + geom_point()

# length
# mv Rplots.pdf Rplots.length.pdf
#ggplot(data, aes(x=symbol, y=length)) + geom_violin()

# evalue 
# mv Rplots.pdf Rplots.evalue.pdf
ggplot(data, aes(x=symbol, y=log(evalue))) + geom_violin()


