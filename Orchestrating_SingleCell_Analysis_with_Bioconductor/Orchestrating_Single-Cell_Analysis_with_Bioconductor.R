##################################################################################################################################
# chapter 4 Data Infrastructure
# BiocManager::install("SingleCellExperiment")
# BiocManager::install(c('scater','scran','uwot'))
# BiocManager::available()
# BiocManager::version()
library(SingleCellExperiment)
counts = matrix(rpois(100, lambda=10), ncol = 10, nrow = 10)
counts
rownames(counts) <- paste("gene",1:10, sep = "")
counts
colnames(counts) <- paste("cell",1:10, sep = "")
counts

counts_matrix <- data.frame(cell_1 = rpois(10,10),
                            cell_2 = rpois(10,10),
                            cell_3 = rpois(10,30))
counts_matrix
class(counts_matrix)
rownames(counts_matrix) <- paste0("gene_",1:10)
counts_matrix <- as.matrix(counts_matrix)
class(counts_matrix)
counts_matrix
sce <- SingleCellExperiment(assays = list(counts = counts_matrix))
sce
counts(sce)
# assay(sce, "counts") ## same as above in this special case
sce <- scran::computeSumFactors(sce)
sce
sce <- scater::normalize(sce)
sce
logcounts(sce)
assay(sce,"logcounts") ## same as above.
counts_100 <- assay(sce, "counts") + 100

assay(sce,"counts_100") <- counts_100
assays(sce)
sce

# 4.2.3 Column (Meta)Data: colData Slot 
cell_metadata <- data.frame(batch = c(1, 1, 2))
rownames(cell_metadata) <- paste0("cell_", 1:3)
cell_metadata

## From scratch:
sce <- SingleCellExperiment(assays = list(counts = counts_matrix),
                            colData = cell_metadata)

## Appending to existing object (requires DataFrame() coercion)
## colData(sce) <- DataFrame(cell_metadata)

sce
colData(sce)
sce <- scater::calculateQCMetrics(sce)
colData(sce)[,1:5]
rowRanges(sce)
rowData(sce)[,1:3]

# 4.2.3.1 Using colData for Subsetting
sce$batch
colData(sce)$batch # same as above

sce[, sce$batch ==  1]

# 4.2.4 Feature Metadata: rowData/rowRanges
rowRanges(sce)
rowData(sce)[,1:3]
# 4.2.4.1 Subsetting by Rows
sce[c("gene_1","gene_4"),]
sce[c(1,4),] # same as above in this case

# 4.2.5 Size Factors Slot: sizeFactors
sce <- scran::computeSumFactors(sce)
sce <- scater::normalize(sce)
sizeFactors(sce)

# 4.3 A Brief Recap: From se to sce
# None
# 4.4 The reducedDims Slot
sce <- scater::runPCA(sce)
reducedDim(sce,"PCA")

sce <- scater::runTSNE(sce, perplexity = 0.1)
reducedDim(sce,"TSNE")

reducedDims(sce)

u <- uwot::umap(t(logcounts(sce)),n_neighbors = 2)
reducedDim(sce,"UMAP_uwot") <- u
reducedDim(sce, "UMAP_uwot")

reducedDims(sce)

# 4.5 The metadata Slot
my_genes <- c("gene_1","gene_5")
metadata(sce) <-list(favorite_genes = my_genes)
metadata(sce)
sce
# Similarly, we can append more information via the $ operator:
your_genes <- c("gene_4","gene_8")
metadata(sce)$your_genes <- your_genes
metadata(sce)

# end !!!
#########################################################################################################################################
# chapter 5
# BiocManager::install("scRNAseq")
library(scRNAseq)

sce <- MacoskoRetinaData()
sce
# Quality control.
library(scater)
is.mito <- grepl("^MT-", rownames(sce))
qcstats <- perCellQCMetrics(sce, subsets=list(Mito=is.mito))
filtered <- quickPerCellQC(qcstats, percent_subsets="subsets_Mito_percent")
sce <- sce[, !filtered$discard]
sce
# Normalization.
sce <- logNormCounts(sce)

# Feature selection.
library(scran)
dec <- modelGeneVar(sce)
hvg <- getTopHVGs(dec, prop=0.1)

# Dimensionality reduction.
set.seed(1234)
sce <- runPCA(sce, ncomponents=25, subset_row=hvg)
sce <- runUMAP(sce, dimred = 'PCA', external_neighbors=TRUE)
sce <- runTSNE(sce)

# Clustering.
g <- buildSNNGraph(sce, use.dimred = 'PCA')
sce$clusters <- factor(igraph::cluster_louvain(g)$membership)

# Visualization.
plotUMAP(sce, colour_by="clusters")
plotTSNE(sce, colour_by = "clusters")
?plotTSNE
sce
counts(sce)
logcounts(sce)


####################################################################################################################
# chapter 6
#--- setup ---#


...
#--- loading ---#
library(scRNAseq)
sce.416b <- LunSpikeInData(which="416b") 
sce.416b$block <- factor(sce.416b$block)

sce.416b

##
# Identifying the mitochondrial transcripts:
library(AnnotationHub)
ens.mm.v97 <- AnnotationHub()[["AH73905"]]
location <- mapIds(ens.mm.v97, keys=rownames(sce.416b),
                   keytype="GENEID", column="SEQNAME")
is.mito <- which(location=="MT")

# Computing the QC metrics.
library(scater)
df <- perCellQCMetrics(sce.416b, subsets=list(Mito=is.mito))
df

# 6.5 Cell calling for droplet data
# 6.5.1 Background
library(BiocFileCache)
bfc <- BiocFileCache("raw_data", ask = FALSE)
raw.path <- bfcrpath(bfc, file.path("http://cf.10xgenomics.com/samples",
                                    "cell-exp/2.1.0/pbmc4k/pbmc4k_raw_gene_bc_matrices.tar.gz"))
untar(raw.path, exdir=file.path(tempdir(), "pbmc4k"))

BiocManager::install("DropletUtils")
library(DropletUtils)
library(Matrix)
fname <- file.path(tempdir(), "pbmc4k/raw_gene_bc_matrices/GRCh38")
sce.pbmc <- read10xCounts(fname, col.names=TRUE)
sce.pbmc


bcrank <- barcodeRanks(counts(sce.pbmc))

# Only showing unique points for plotting speed.
uniq <- !duplicated(bcrank$rank)
plot(bcrank$rank[uniq], bcrank$total[uniq], log="xy",
     xlab="Rank", ylab="Total UMI count", cex.lab=1.2)

abline(h=metadata(bcrank)$inflection, col="darkgreen", lty=2)
abline(h=metadata(bcrank)$knee, col="dodgerblue", lty=2)

legend("bottomleft", legend=c("Inflection", "Knee"), 
       col=c("darkgreen", "dodgerblue"), lty=2, cex=1.2)

#### 6.5.2 Testing for empty droplets
# emptyDrops performs Monte Carlo simulations to compute p-values,
# so we need to set the seed to obtain reproducible results.
set.seed(100)
e.out <- emptyDrops(counts(sce.pbmc))

# See ?emptyDrops for an explanation of why there are NA values.
summary(e.out$FDR <= 0.001)

table(Sig=e.out$FDR <= 0.001, Limited=e.out$Limited)
set.seed(100)
limit <- 100
all.out <- emptyDrops(counts(sce.pbmc),lower = limit, test.ambient=TRUE)
hist(all.out$PValue[all.out$Total <=limit & all.out$Total > 0],
     xlab="P-value",main="", col = "grey80")

sce.pbmc <- sce.pbmc[,which(e.out$FDR <= 0.001)]





##################################################################################################################
# Chapter 8 Feature Selection
library(BiocFileCache)
bfc <- BiocFileCache("raw_data", ask = FALSE)
raw.path <- bfcrpath(bfc, file.path("http://cf.10xgenomics.com/samples",
                                    "cell-exp/2.1.0/pbmc4k/pbmc4k_raw_gene_bc_matrices.tar.gz"))
untar(raw.path, exdir=file.path(tempdir(),"pbmc4k"))

library(DropletUtils)
fname <- file.path(tempdir(),"pbmc4k/raw_gene_bc_matrices/GRCH38")
sce.pbmc <- read10xCounts(fname, col.names = T)
sce.pbmc

#--- gene-annotation ---#
library(scater)
rownames(sce.pbmc) <- uniquifyFeatureNames(
  rowData(sce.pbmc)$ID, rowData(sce.pbmc)$Symbol)

# BiocManager::install("EnsDb.Hsapiens.v86")
library(EnsDb.Hsapiens.v86)
location <- mapIds(EnsDb.Hsapiens.v86, keys=rowData(sce.pbmc)$ID, 
                   column="SEQNAME", keytype="GENEID")

#--- cell-detection ---#
set.seed(100)
e.out <- emptyDrops(counts(sce.pbmc))
sce.pbmc <- sce.pbmc[,which(e.out$FDR <= 0.001)]

#--- quality-control ---#
stats <- perCellQCMetrics(sce.pbmc, subsets=list(Mito=which(location=="MT")))
high.mito <- isOutlier(stats$subsets_Mito_percent, type="higher")
sce.pbmc <- sce.pbmc[,!high.mito]

#--- normalization ---#
library(scran)
set.seed(1000)
clusters <- quickCluster(sce.pbmc)
sce.pbmc <- computeSumFactors(sce.pbmc, cluster=clusters)
sce.pbmc <- logNormCounts(sce.pbmc)