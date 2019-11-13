
# 安装包
# source("https://bioconductor.org/biocLite.R")
# biocLite("DOSE")
# biocLite("topGO")
# biocLite("clusterProfiler")
# biocLite("pathview")

# 加载包
library(DOSE)
library(org.Hs.eg.db)
library(topGO)
library(clusterProfiler)
library(pathview)

# 导入数据
data <- read.table("gene.list",header=TRUE)
data$GeneName <- as.character(data$GeneName)

# 转换基因名
transID = bitr(data$GeneName,
               fromType="SYMBOL",
               toType=c("ENSEMBL", "ENTREZID"),
               OrgDb="org.Hs.eg.db"
)

dir.create("GO")
dir.create("KEGG")

# GO_CC 注释
# CC <- enrichGO(gene = transID$ENTREZID,OrgDb = "org.Hs.eg.db",keyType="ENTREZID",ont="CC",pvalueCutoff=0.05,pAdjustMethod="BH",qvalueCutoff=0.1)
CC <- enrichGO(gene = transID$ENTREZID,OrgDb = "org.Hs.eg.db",keyType="ENTREZID",ont="CC",pvalueCutoff=0.5,pAdjustMethod="BH",qvalueCutoff=0.5)
# 有时候画不出来图，可能是pvalue或qvalue值的大小问题，设置0.5一般都能画出来图。为什么？
CC <- setReadable(CC, OrgDb=org.Hs.eg.db)

pdf(file="./GO/GO_CC.pdf", bg="transparent")
dotplot(CC, showCategory=12, font.size=8, title="GO_CC") # + theme(axis.text.y = element_text(angle = 45))
barplot(CC, showCategory=12, title="GO_CC", font.size=8)
plotGOgraph(CC)
dev.off()

write.table(as.data.frame(CC@result), file="./GO/GO_CC.xls", sep="\t", row.names=F)

# GO_MF注释
# MF <- enrichGO(transID$ENTREZID, "org.Hs.eg.db", keyType="ENTREZID", ont="MF", pvalueCutoff=0.05, pAdjustMethod="BH", qvalueCutoff=0.1)
MF <- enrichGO(transID$ENTREZID, "org.Hs.eg.db", keyType="ENTREZID", ont="MF", pvalueCutoff=0.5, pAdjustMethod="BH", qvalueCutoff=0.5)
MF <- setReadable(MF, OrgDb=org.Hs.eg.db)

pdf(file="./GO/GO_MF.pdf", bg="transparent")
dotplot(MF, showCategory=12, font.size=8, title="GO_MF") # + theme(axis.text.y = element_text(angle = 45))
barplot(MF, showCategory=12, title="GO_MF", font.size=8)
plotGOgraph(MF)
dev.off()

write.table(as.data.frame(MF@result), file="./GO/GO_MF.xls", sep="\t", row.names=F)

# GO_BP注释
# BP <- enrichGO(transID$ENTREZID, "org.Hs.eg.db", keyType="ENTREZID", ont="BP", pvalueCutoff=0.05, pAdjustMethod="BH", qvalueCutoff=0.1)
BP <- enrichGO(transID$ENTREZID, "org.Hs.eg.db", keyType="ENTREZID", ont="BP", pvalueCutoff=0.5, pAdjustMethod="BH", qvalueCutoff=0.5)
# 可以调节pvalueCutoff 和 qvalueCutoff 的值，0.5和0.5
# 解读BP层面富集分析图：横坐标是GeneRatio，意思是说输入进去的基因，它每个term纵坐标占整体基因的百分比，
# 圆圈的大小代表基因的所少，圆圈的颜色代表了p-value，也就是说p-value越小gene count圆圈越大，这事就越可信
BP <- setReadable(BP, OrgDb=org.Hs.eg.db)

pdf(file="./GO/GO_BP.pdf", bg="transparent")
dotplot(BP, showCategory=12, font.size=8, title="GO_BP") # + theme(axis.text.y = element_text(angle = 45))
barplot(BP, showCategory=12, title="GO_BP", font.size=8)
# 树状图，树状图很大，可以保存成pdf
pdf(file="./GO/GO.bp.tree.pdf",width=10, height=15)
plotGOgraph(BP) 
dev.off()

write.table(as.data.frame(BP@result), file="./GO/GO_BP.xls", sep="\t", row.names=F)

# KEGG 注释
kegg <- enrichKEGG(transID$ENTREZID, organism="hsa", pvalueCutoff=0.5, pAdjustMethod="BH", qvalueCutoff=0.5)
# 上面这一步需要联网下载，否则可能会报下面的错：
# Error in download.KEGG.Path(species) : 
#   'species' should be one of organisms listed in 'http://www.genome.jp/kegg/catalog/org_list.html'...
kegg <- setReadable(kegg, OrgDb=org.Hs.eg.db, keytype="ENTREZID")

pdf(file="./KEGG/KEGG.pdf", bg="transparent")
dotplot(kegg, showCategory=12, font.size=8, title="KEGG") # + theme(axis.text.y = element_text(angle = 45))
barplot(kegg, showCategory=12, title="KEGG", font.size=8)
dev.off()

write.table(as.data.frame(kegg@result), file="./KEGG/kegg.xls", sep="\t", row.names=F)

dir.create("./KEGG/MAP")
kegg_df = as.data.frame(kegg)

for(i in kegg_df$ID){
  pathview(gene.data=transID$ENTREZID,
           pathway.id=i,
           species="hsa",
           kegg.native=TRUE,
           kegg.dir="./KEGG/MAP"
  )
}

print("TASK DONE")
