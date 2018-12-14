library(VennDiagram)
args=commandArgs(T)
args[1]
A = read.table(args[1], header=F)
# A
B = read.table(args[2], header=F)
# B
# type(B)
A = as.vector(A)
B = as.vector(B)
A
# venn.diagram(list(A=args[1],B=args[2]),height=500, width=500, resolution=500, filename="VennPlot.tiff", imagetype="tiff", col="transparent", )
venn.diagram(list(A=A, B=B),height=500, width=500, resolution = 300, imagetype = "png", alpha=c(0.5,0.5), fill=c("red","yellow"), main="Intersection of xxx",filename = "VennDiagram.png")
# venn.diagram(list(A=c(1:10), B=c(5:15)),height=500, width=500, resolution = 300, imagetype = "png", alpha=c(0.5,0.5), fill=c("red","yellow"), main="Intersection of xxx",filename = "VennDiagram.png")
