# this script depends on other scripts from this project


require(edgeR)
require(preprocessCore)
require(magrittr)
require(gplots)
require(RColorBrewer)
require(dplyr)
library(XML)
require(stringr)
library(tidyverse)

sd.to.mean <- colnames(results.aov[,111:118])
genes <- c('Ankrd11', 'Nrxn2', 'Setd1b', 'Macf1', 'Shank1', 'Nf1', 'Eif4e', 'Taok2')

# 1) zawÄ™Å¼amy listÄ™ genÃ³w do genÃ³w SFARI (anova zostaje taka sama Å¼eby moÅ¼na byÅ‚o porÃ³wnywaÄ‡ z "randomowym tÅ‚em" <- to jest waÅ¼ne
results.aov %>% 
  filter(((toupper(results.aov$results.gene_name) %in% sfari_animals$gene.symbol) |
            (toupper(results.aov$results.gene_name) %in% sfari_human$gene.symbol)) & results.aov$results.gene_name %in% genes &
           results.aov$p.diet < 0.1 & results.aov$p.interaction < 0.1) %>%
  filter_at(vars(sd.to.mean), all_vars(.<0.3)) -> selected.genes.short

results.aov %>% 
  filter(((toupper(results.aov$results.gene_name) %in% sfari_animals$gene.symbol) |
            (toupper(results.aov$results.gene_name) %in% sfari_human$gene.symbol)) &
           results.aov$p.diet < 0.1 & results.aov$p.interaction < 0.1) %>%
filter_at(vars(sd.to.mean), all_vars(.<0.3)) -> selected.genes



to.plot$dir.hfd <- ifelse(((to.plot$male.SD.mean+to.plot$female.SD.mean-to.plot$male.HFD.mean-to.plot$female.HFD.mean) > 0), "DOWN", "UP")
to.plot %>% filter(dir.hfd == "UP") -> to.plot
to.plot %>% filter(dir.hfd == "DOWN") -> to.plot


samples.to.plot <- as.character(samples.info$samples.sorted.barcode[order(samples.info$diets)])

selected.genes -> to.plot

mypalette <- brewer.pal(11,"RdBu")
morecols <- colorRampPalette(mypalette)

group.names <- unique(as.character(samples.info$group[order(samples.info$diets)]))

col.labels <- c(rep("", 5), group.names[1], rep(" ", 9), 
                group.names[2], rep(" ", 9),
                group.names[3], rep(" ", 9),
                group.names[4], rep(" ", 9),
                group.names[5], rep(" ", 9),
                group.names[6], rep(" ", 9),
                group.names[7], rep(" ", 9),
                group.names[8], rep(" ", 4)
)


cut.threshold <- function(x, threshold = 3) {
  x[x > threshold] <- threshold
  x[x < -threshold] <- -threshold
  x
}

to.plot[,samples.to.plot] %>%
  apply(1, scale) %>%
  t %>%
  apply(1, cut.threshold, threshold = 3.5) %>%
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
    cexRow = 0.7,
    offsetCol = -0.05
  )
