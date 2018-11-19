args=commandArgs(T)
data = read.table(args[1],sep=',')
x = data[,2]
y = data[,3]

# pdf(file="test.pdf")
plot(x,y,type="l",main='Figure 3. Sequencing Saturation.',xlab='Raw reads per cell',ylab='Saturation')  # dian tu
# savePlot() # 
# dev.off()