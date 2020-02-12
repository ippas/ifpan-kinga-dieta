
selected <- to.plot

rowMeans(selected[,samples]) -> selected$mean.global

selected$direction <- ifelse(selected$mean.global > ((selected$male.HFD.mean + selected$female.HFD.mean)/2), "DOWN", "UP")

selected %>% filter(direction == "UP") %>% select(results.gene_name) %>% 
  write.table(quote = FALSE, row.names = FALSE)


selected %>% filter(direction == "DOWN") %>% select(results.gene_name) %>% 
  write.table(quote = FALSE, row.names = FALSE)

go.up <- read.delim('GO_up.txt')
go.down <- read.delim('GO_down.txt')
kegg.up <-read.delim('KEGG_up.txt')
kegg.down <- read.delim('KEGG_down.txt')


go.up$Genes %>% as.character() %>% strsplit(";") %>% sapply(length) -> go.up$gene_no
go.down$Genes %>% as.character() %>% strsplit(";") %>% sapply(length) -> go.down$gene_no
kegg.up$Genes %>% as.character() %>% strsplit(";") %>% sapply(length) -> kegg.up$gene_no
kegg.down$Genes %>% as.character() %>% strsplit(";") %>% sapply(length) -> kegg.down$gene_no


go.up$Term[which((go.up$gene_no > 2) & (go.up$gene_no < 4))]
go.up$Genes[which((go.up$gene_no > 2) & (go.up$gene_no < 4))][4]


kegg.up$Term[which(kegg.up$gene_no > 2)]
kegg.up$Genes[which(kegg.up$gene_no > 2)][9]

# top GO and KEGG for upregulated genes:

# vesicle transport: APLP2;KIF5A;AGAP2;KIF1A;RAB11B
# vesicle transport in synapse: CANX
# chemical synaptyic transmission: KIF5A;SLC1A3;SYN1;PAFAH1B1
# MAPK cascade: YWHAB;CALM1;SPTAN1;SPTBN1
# wnt signalling: GNAO1;GNB1;CALM1;CPE
# axonogenesis:  KIF5C;KIF5A;SPTAN1;SPTBN1
# cytoskeleton-dependent intracellular transport: DYNLL2
# lipid transport: PSAP
# cellular response to glucagon stimulus: PRKAR1A
# ephrin receptor signaling pathway: ACTB (also: Gastric acid secretion), ACTR2
# nuclear-transcribed mRNA catabolic process : EIF4A2,DDX5
# inositol phosphate catabolic process: NUDT3
# regulation of insulin secretion: SLC25A4, ATP1B2
# post-translational protein modification: SPARCL1
# purine nucleotide metabolic process: GKU1
# cholesterol biosynthetic process: CNBP
# KEGG: dopaminergic synapse endocytosis GNAO1;KIF5C;KIF5A;GNB1;CALM1;AGAP2;RAB11B
# KEGG: glutamatergic synapse: GNAO1;GNB1;SLC1A3

assigned.genes <- "GNAO1;KIF5C;KIF5A;GNB1;CALM1;KIF5C;KIF5A;AGAP2;RAB11B;APLP2;KIF5A;AGAP2;KIF1A;RAB11B;KIF5A;SLC1A3;SYN1;PAFAH1B1;YWHAB;CALM1;SPTAN1;SPTBN1;GNAO1;GNB1;CALM1;KIF5C;KIF5A;SPTAN1;SPTBN1"

assigned.genes %>% strsplit(";") %>% unlist() -> assigned.genes
go.up$Genes %>% as.character() %>% strsplit(";") %>% unlist() %>% unique() -> go.up.genes

go.up.genes[!(go.up.genes %in% assigned.genes)]







go.down$Term[(go.down$gene_no > 8)]
go.down$Genes[(go.down$gene_no > 8)][15]


kegg.down$Term[which(kegg.down$gene_no > 4)]
kegg.down$Genes[which(kegg.down$gene_no > 4)][9]

# top GO and KEGG for downregulated genes:

# respiratory electron transport chain: NDUFA13;NDUFA7;NDUFA6;NDUFB11;NDUFB5;NDUFB4;NDUFA2;SDHC;COX6B1
# rRNA processing / ribosome biogenesis: RPL31;RPL34;RPS3;RPL13;RPS3A;RPS11;RPL18;RPS10;RPL17
# proteasome-mediated ubiquitin-dependent protein catabolic process : PSMB4;PSMC5;PSMC3;PSMB3;PSMB1
# KEGG: thermogenesis: NDUFA13;NDUFA7;ATP5PD;NDUFA6;NDUFB11;NDUFB5;NDUFB4;NDUFA2;SDHC;COX6B1
# KEGG: Non-alcoholic fatty liver disease (NAFLD): NDUFA13;NDUFA7;NDUFA6;NDUFB11;NDUFB5;NDUFB4;NDUFA2;SDHC;COX6B1
# KEGG: proteasome: PSMB4;PSMC5;PSMC3;PSMB3;PSMB1


assigned.genes <- "GNAO1;KIF5C;KIF5A;GNB1;CALM1;KIF5C;KIF5A;AGAP2;RAB11B;APLP2;KIF5A;AGAP2;KIF1A;RAB11B;KIF5A;SLC1A3;SYN1;PAFAH1B1;YWHAB;CALM1;SPTAN1;SPTBN1;GNAO1;GNB1;CALM1;KIF5C;KIF5A;SPTAN1;SPTBN1"

assigned.genes %>% strsplit(";") %>% unlist() -> assigned.genes
go.down$Genes %>% as.character() %>% strsplit(";") %>% unlist() %>% unique() -> go.down.genes

go.down.genes[!(go.down.genes %in% assigned.genes)]




