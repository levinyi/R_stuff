library(VennDiagram)
args=commandArgs(T)

args_length = length(args)
if ( args_length == 2 ){
	A = scan(args[1], what=character(0))
	B = scan(args[2], what=character(0))
	print("2 files")
	file_name1 = unlist(strsplit(args[1],"\\."))[1]
	file_name2 = unlist(strsplit(args[2],"\\."))[1]
	
	venn.diagram(list(A=A, A=B), 
	     resolution = 300, imagetype = "png", 
	     cat.fontface=4, fontfamily=3,
	     category.names = c(file_name1,file_name2),
	     fill = c("blue","red"),
	     cat.col = c("blue","red"),
	     main="", main.cex = 2,main.fontface=2, main.fontfamily=3,
	     filename = "VennDiagram.pairwise.png")
	print("Output graph : VennDiagram.pairwise.png")

}else if ( args_length == 3 ){
	A = scan(args[1],what="c")
	B = scan(args[2],what="c")
	C = scan(args[3],what="c")
	print("3 files")
	file_name1 = unlist(strsplit(args[1],"\\."))[1]
	file_name2 = unlist(strsplit(args[2],"\\."))[1]
	file_name3 = unlist(strsplit(args[3],"\\."))[1]
	
	venn.diagram(list(A=A,B=B,C=C), 
	     resolution = 300, imagetype = "png", 
	     cat.fontface=4, fontfamily=3,
	     category.names = c(file_name1,file_name2,file_name3),
	     fill = c("blue", "red", "green"),
	     cat.col = c("blue", "red", "green"),
	     lty = "blank",
	     main="", main.cex = 2,main.fontface=2, main.fontfamily=3,
	     filename = "VennDiagram.triple.png")
	print("Output graph : VennDiagram.triple.png")

}else if ( args_length == 4 ){
	A = scan(args[1],what="c")
	B = scan(args[2],what="c")
	C = scan(args[3],what="c")
	D = scan(args[4],what="c")
	print("4 files")
	file_name1 = unlist(strsplit(args[1],"\\."))[1]
	file_name2 = unlist(strsplit(args[2],"\\."))[1]
	file_name3 = unlist(strsplit(args[3],"\\."))[1]
	file_name4 = unlist(strsplit(args[4],"\\."))[1]

	venn.diagram(list(A=A, B=B,C=C,D=D), 
	     resolution = 300, imagetype = "png", 
	     cat.fontface=4, fontfamily=3,
	     category.names = c(file_name1,file_name2,file_name3,file_name4),
	     lty = "dashed",
	     fill = c("orange", "red", "green", "blue"),
	     cat.col = c("orange", "red", "green", "blue"),
	     main="", main.cex = 2,main.fontface=2, main.fontfamily=3,
	     filename = "VennDiagram.quad.png")
	print("Output graph : VennDiagram.quad.png")

}else if ( args_length == 5 ){
	A = scan(args[1], what="c")
	B = scan(args[2], what="c")
	C = scan(args[3], what="c")
	D = scan(args[4], what="c")
	E = scan(args[5], what="c")
	print("5 files")
	file_name1 = unlist(strsplit(args[1], "\\."))[1]
	file_name2 = unlist(strsplit(args[2], "\\."))[1]
	file_name3 = unlist(strsplit(args[3], "\\."))[1]
	file_name4 = unlist(strsplit(args[4], "\\."))[1]
	file_name5 = unlist(strsplit(args[5], "\\."))[1]
	
	venn.diagram(list(A=A, B=B, C=C, D=D, E=E),
	     resolution = 300, imagetype = "png",
	     cat.fontface=4, fontfamily=3,
	     category.names = c(file_name1,file_name2,file_name3,file_name4,file_name5),
	     fill = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
	     cat.col = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
	     main="", main.cex = 2,main.fontface=2, main.fontfamily=3,
	     filename = "VennDiagram.quintuple.png")
	print("Output graph : VennDiagram.quintuple.png")

}else {
	exit("your input file number not correct.\nError: Incorrect number of elements.\n")
}

