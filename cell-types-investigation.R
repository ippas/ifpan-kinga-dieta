require(edgeR)
require(preprocessCore)
require(magrittr)
require(gplots)
require(RColorBrewer)
require(dplyr)
library(XML)



layer.6a <- xmlTreeParse("layer_6a.xml", useInternal = TRUE)
yop <- xmlRoot(layer.6a)
genes.layer.6a <- vector(mode='list', length=100)
fold.layer.6a <- vector(length=100)
for (i in c(1:100)) {
  genes.layer.6a[i] <- xmlValue(yop[[1]][[i]][["gene-symbol"]])
  fold.layer.6a[i] <- xmlValue(yop[[1]][[i]][["fold-change"]])
}
genes.layer.6a <- unlist(genes.layer.6a)
fold.layer.6a <- unlist(fold.layer.6a)
layer.6a <- data.frame(cbind(genes.layer.6a, as.numeric(fold.layer.6a)))


results.aov %>% filter(results.gene_name %in% genes.layer.6a) -> to.plot.6a



layer.4 <- xmlTreeParse("layer_4.xml", useInternal = TRUE)
yop <- xmlRoot(layer.4)
genes.layer.4 <- vector(mode='list', length=100)
fold.layer.4 <- vector(length=100)
for (i in c(1:100)) {
  genes.layer.4[i] <- xmlValue(yop[[1]][[i]][["gene-symbol"]])
  fold.layer.4[i] <- xmlValue(yop[[1]][[i]][["fold-change"]])
}
genes.layer.4 <- unlist(genes.layer.4)
fold.layer.4 <- unlist(fold.layer.4)
layer.4 <- data.frame(cbind(genes.layer.4, as.numeric(fold.layer.4)))

results.aov %>% filter(results.gene_name %in% genes.layer.4) -> to.plot.4



layer.5 <- xmlTreeParse("layer_5.xml", useInternal = TRUE)
yop <- xmlRoot(layer.5)
genes.layer.5 <- vector(mode='list', length=100)
fold.layer.5 <- vector(length=100)
for (i in c(1:100)) {
  genes.layer.5[i] <- xmlValue(yop[[1]][[i]][["gene-symbol"]])
  fold.layer.5[i] <- xmlValue(yop[[1]][[i]][["fold-change"]])
}
genes.layer.5 <- unlist(genes.layer.5)
fold.layer.5 <- unlist(fold.layer.5)
layer.5 <- data.frame(cbind(genes.layer.5, as.numeric(fold.layer.5)))

results.aov %>% filter(results.gene_name %in% genes.layer.5) -> to.plot.5


layer.2.3 <- xmlTreeParse("layer2_3.xml", useInternal = TRUE)
yop <- xmlRoot(layer.2.3)
genes.layer.2.3 <- vector(mode='list', length=100)
fold.layer.2.3 <- vector(length=100)
for (i in c(1:100)) {
  genes.layer.2.3[i] <- xmlValue(yop[[1]][[i]][["gene-symbol"]])
  fold.layer.2.3[i] <- xmlValue(yop[[1]][[i]][["fold-change"]])
}
genes.layer.2.3 <- unlist(genes.layer.2.3)
fold.layer.2.3 <- unlist(fold.layer.2.3)
layer.2.3 <- data.frame(cbind(genes.layer.2.3, as.numeric(fold.layer.2.3)))

results.aov %>% filter(results.gene_name %in% genes.layer.2.3) -> to.plot.layer.2.3


to.plot.4$layer <- c(rep("Layer_4", nrow(to.plot.4)))
to.plot.5$layer <- c(rep("Layer_5", nrow(to.plot.5)))
to.plot.6a$layer <- c(rep("Layer_6a", nrow(to.plot.6a)))
to.plot.layer.2.3$layer <- c(rep("Layer_2_3", nrow(to.plot.layer.2.3)))


to.plot.4$marker_fold_change <- layer.4$V2[match(to.plot.4$results.gene_name, layer.4$genes.layer.4)]
to.plot.5$marker_fold_change <- layer.5$V2[match(to.plot.5$results.gene_name, layer.5$genes.layer.5)]
to.plot.6a$marker_fold_change <- layer.6a$V2[match(to.plot.6a$results.gene_name, layer.6a$genes.layer.6a)]
to.plot.layer.2.3$marker_fold_change <- layer.2.3$V2[match(to.plot.layer.2.3$results.gene_name, layer.2.3$genes.layer.2.3)]


nrow(filter(to.plot.4, p.diet < 0.05))
nrow(filter(to.plot.5, p.diet < 0.05))
nrow(filter(to.plot.6a, p.diet < 0.05))
nrow(filter(to.plot.layer.2.3, p.diet < 0.05))


nrow(filter(to.plot.layer.2.3, (p.diet < 0.05) & (p.hcd < 0.05) & ((male.SD.mean+female.SD.mean)-(male.HFD.mean+female.HFD.mean) > 0)))
#this has been done for all the postohocs and the change directions UP and DOWN


to.plot <- rbind(to.plot.4, to.plot.5, to.plot.6a, to.plot.layer.2.3)

to.plot <- filter(to.plot, p.diet < 0.05, (p.md < 0.05 | p.hfd < 0.05 | p.md < 0.05))

write.table(to.plot, file = "cortical-markers.csv",row.names=FALSE, na="",col.names=TRUE, sep=",")





# new lists of markers of cortical neurons
excitatory <- read.table("excitatory.csv", header = FALSE, sep=",")
parvalbumin <- read.table("parvalbumin.csv", header = TRUE, sep=",")
somatostatin <- read.table("somatostatin.csv", header = TRUE, sep=",")
vip <- read.table("vip.csv", header = TRUE, sep=",")

nrow(excitatory)
nrow(parvalbumin)
nrow(somatostatin)
nrow(vip)

colnames(excitatory) <- colnames(parvalbumin)

#cut the markers to top 500
excitatory %>% top_n(500, log2.fold.change.) -> excitatory
parvalbumin %>% top_n(500, log2.fold.change.) -> parvalbumin
somatostatin %>% top_n(500, log2.fold.change.) -> somatostatin
vip %>% top_n(500, log2.fold.change.) -> vip

results.aov %>% filter(results.gene_name %in% excitatory$Feature.Symbol) %>% filter(p.diet < 0.05) -> to.plot.exc
results.aov %>% filter(results.gene_name %in% parvalbumin$Feature.Symbol) %>% filter(p.diet < 0.05) -> to.plot.pv
results.aov %>% filter(results.gene_name %in% somatostatin$Feature.Symbol) %>% filter(p.diet < 0.05) -> to.plot.som
results.aov %>% filter(results.gene_name %in% vip$Feature.Symbol) %>% filter(p.diet < 0.05) -> to.plot.vip

to.plot.exc$type <- c(rep("excitatory", nrow(to.plot.exc)))
to.plot.pv$type <- c(rep("parvalbumin", nrow(to.plot.pv)))
to.plot.som$type <- c(rep("somatostatin", nrow(to.plot.som)))
to.plot.vip$type <- c(rep("vip", nrow(to.plot.vip)))


to.plot.vip %>% filter((p.hfd < 0.05) & ((male.SD.mean+female.SD.mean)-(male.HFD.mean+female.HFD.mean) < 0)) %>% nrow()
#this has been done for all the postohocs and the change directions UP and DOWN


to.plot <- rbind(to.plot.exc, to.plot.pv, to.plot.som, to.plot.vip)
to.plot <- filter(to.plot, p.diet < 0.05, (p.md < 0.05 | p.hfd < 0.05 | p.md < 0.05))


colors <- c("aquamarine", "cadetblue", "cornsilk4", "darkcyan")

to.plot[,samples.to.plot] %>%
  apply(1, scale) %>%
  t %>%
  apply(1, cut.threshold, threshold = 3) %>%
  t %>%
  `colnames<-`(colnames(to.plot[,samples.to.plot])) %>%
  heatmap.2(
    distfun = function(x) as.dist(1-cor(t(x))),
    col=rev(morecols(50)),trace="none",
    main="",
    Colv = FALSE,
    scale="row",
    colsep = c(10,20,30,40,50,60,70),
    sepwidth = c(0.3,0.3),
    labRow=to.plot$results.gene_name,
    labCol=col.labels,         
    srtCol = 45,
    cexRow = 0.8,
    cexCol = 1,
    offsetCol = 0.1,
    RowSideColors = colors[as.factor(to.plot$type)]
  )













