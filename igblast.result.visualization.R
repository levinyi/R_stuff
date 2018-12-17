data = read.table("mydata.mix.common.right.txt",header = F)
#head(data, num=10L)
names(data) = c("symbol", "type", "id", "gene", "identity", "length", "A","B","C","D","E","F","G","evalue","bitscore")

library(ggplot2)

# identity
# mv Rplots.pdf Rplots.identity.pdf
ggplot(data, aes(x=symbol, y=identity)) + geom_violin()

# length
# mv Rplots.pdf Rplots.length.pdf
ggplot(data, aes(x=symbol, y=length)) + geom_violin()

# evalue 
# mv Rplots.pdf Rplots.evalue.pdf
ggplot(data, aes(x=symbol, y=log(evalue))) + geom_violin()


