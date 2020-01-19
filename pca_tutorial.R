# install.packages("FactoMineR")
# install.packages("factoextra")
library("FactoMineR")
library(factoextra)
data(decathlon2)
head(decathlon2)
decathlon2.active <- decathlon2[1:23, 1:10]
head(decathlon2.active[,1:6],4)
res.pca <- PCA(decathlon2.active, graph = FALSE)
print(res.pca)
eig.val <- get_eigenvalue(res.pca)
eig.val
fviz_eig(res.pca,addlabels = TRUE, ylim = c(0,50))
var <- get_pca_var(res.pca)
var

# Coordinates
head(var$coord)
# Cos2: quality on the factore map
head(var$cos2)
# Contributions to the principal components
head(var$contrib)

head(var$coord, 4)
fviz_pca_var(res.pca, col.var = "black")
head(var$cos2,4)
library(corrplot)
# install.packages("corrplot")
corrplot(var$cos2, is.corr=FALSE)
# Total cos2 of variables on Dim.1 and Dim.2
fviz_cos2(res.pca, choice = "var", axes = 1:2)

# Color by cos2 values: quality on the factor map
fviz_pca_var(res.pca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping
)
# Change the transparency by cos2 values
fviz_pca_var(res.pca, alpha.var = "cos2")
