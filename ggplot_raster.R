if (!suppressWarnings(require("ggplot2"))){
 install.packages("ggplot2")
 require("ggplot2")
}

data = read.table(gzfile("b0005p1.pairing.freq.gz"),header=T)

# log10
ggplot(data, aes(x=a, y=b, fill=log(freq, 10))) + geom_raster() + scale_fill_gradient(low="blue", high = "red") + ggtitle("b0005p1.pairing.freq.gz")
#ggsave("myplot.log10.pdf", width=8, height=8, units="cm")
# raw data
ggplot(data, aes(x=a, y=b, fill=freq))          + geom_raster() + scale_fill_gradient(low='blue', high = 'red') + ggtitle("b0005p1.pairing.freq.gz")
#ggsave("myplot.raw.pdf", width=8, height=8,units="cm")

#b0007p1.pairing.freq.gz
#b0007p2.pairing.freq.gz
data2 = read.table(gzfile("b0007p2.pairing.freq.gz"), header=T)
ggplot(data2, aes(x=a, y=b, fill=log(freq, 10))) + geom_raster() + scale_fill_gradient(low="blue", high="red") + ggtitle("b0007p2.pairing.freq.gz")
ggplot(data2, aes(x=a, y=b, fill=freq)) + geom_raster() + scale_fill_gradient(low="blue", high="red") + ggtitle("b0007p2.pairing.freq.gz")

data3 = read.table(gzfile("b0007p1.pairing.freq.gz"), header=T)
ggplot(data3, aes(x=a, y=b, fill=log(freq, 10))) + geom_raster() + scale_fill_gradient(low="blue", high="red") + ggtitle("b0007p1.pairing.freq.gz")
ggplot(data3, aes(x=a, y=b, fill=freq)) + geom_raster() + scale_fill_gradient(low="blue", high="red") + ggtitle("b0007p1.pairing.freq.gz")

