library(SingleCellExperiment)
library(Seurat)
library(DoubletFinder)
real_10x_data = Read10X(data.dir = "10xGenomics\\example_G48E2L1\\filtered_feature_bc_matrix")
G48E2L1 = CreateSeuratObject(real_10x_data)
# sce <- SingleCellExperiment(assays = list(counts = real_10x_data))
G48E2L1 <- NormalizeData(G48E2L1)
G48E2L1 <- ScaleData(G48E2L1)
G48E2L1 <- FindVariableFeatures(G48E2L1, selection.method = "vst", nfeatures = 2000)
G48E2L1 <- RunPCA(G48E2L1)
G48E2L1 <- RunUMAP(G48E2L1, dims= 1:10)

sweep.res.list_kidney <- paramSweep_v3(G48E2L1, PCs = 1:10, sct = FALSE)
sweep.stats_kidney <- summarizeSweep(sweep.res.list_kidney, GT = FALSE)
bcmvn_kidney <- find.pK(sweep.stats_kidney)


# cell calling for droplet data
library(DropletUtils)
bcrank <- barcodeRanks(counts(sce))
counts(sce)
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
e.out <- emptyDrops(counts(sce))

# See ?emptyDrops for an explanation of why there are NA values.
summary(e.out$FDR <= 0.001)

