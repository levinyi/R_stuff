args=commandArgs(T)
data = read.table(args[1],sep=',',header=TRUE)

x=data[,2]
y=data[,3]
