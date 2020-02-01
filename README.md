# ifpan-kinga-dieta
Influence of maternal diet on ofspring gene expression in rat brain (PFC, hippocampus)

## Method:
All samples were checked for quality with fastQC v0.11.8 and aligned to a rat reference genome (rn6 from Ensembl database) with hisat2 2.1.0. Cufflinks v 2.2.1 package and GTF from the Ensembl gene database were used to quantify (cuffquant) and normalize (cuffnorm) transcripts to fpkms (Fragments Per Kilobase of transcript per Million fragments mapped). All statisical analyses were performed with R software v3.4. Statistical significance was tested using ANOVA on log2(1 + x) values with false discovery rate adjustment. For post-hoc analysis, pairwise t-tests with Bonferroni corrections were performed. "p" and "fdr" values < 0.05 were considered statistically significant, however 2000 genes passed this treshold. Thus, to select top genes custom filtering was applied as follows: p.diet < 0.01, sd.to.mean of all groups < 0.1, minimum 10 samples with log2(fpkm + 1) > 7. This filtering step yielded top 75 DE genes [analysis code here](kinga-dieta.Rmd)

## Cell types investigation 
To investigate the anatomical and functional changes induced by different diets, two additional approaches were used. First, genetic markers of various cortical layers were downloaded from Allen Brain Atlas (ISH data from https://mouse.brain-map.org). 100 top markers of Layer 2/3, Layer 4, Layer 5 and Layer 6a were investigated. The second set of markers came from [this database](http://research-pub.gene.com/NeuronSubtypeTranscriptomes/#study/study/GSE122100/studyReport.html). Here top 500 markers of each cortical neuronal subtypes were investigated (excitatory, somatostatin, parvalbumin and vip neurons). Each set of markers was filtered to p.diet < 0.05 and for post-hoc vs standard diet significance p < 0.05. Markers that fulfilled the condition of p.diet and post-hoc significance were also tested for direction of regulation. [Analysis code available here](cell-types-investigation.R) *note: this code shares variables with the other notebook*

## RESULTS
Full list of statistical tests for all genes and their abundance estimations for each sample can be found [here](http://149.156.177.112/projects/ifpan-kinga-dieta/analysis/all-genes-anova.csv)

## SAMPLE LIST:
[full sample list here](sample-list.tsv)
80 rat brain samples
40/40 M/F
10 samples per group

## STEP 1: FASTQC
Fastqc was run with the [Intelliseq workflow](https://gitlab.com/intelliseq/workflows/raw/master/src/main/wdl/tasks/quality-check-fastqc/v0.1/quality-check-fastqc.wdl) in cromwell/wdl in batches of 10 files. For details see [this .md](run-fastqc-wdl-in-batches.md). Multiqc was used to generate the final report, in [this docker file](https://hub.docker.com/r/ewels/multiqc). Command:
`docker run --rm -v $PWD:/data ewels/multiqc:latest multiqc /data -o /data`
[link to fastqc report](http://149.156.177.112/projects/ifpan-kinga-dieta/multiqc_report.html)

## STEP 2 : Alignment - with HISAT2 to rat genome
Rat genome version: `Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa.gz` from ensembl + indexes made with hisat2 previously. For details see [this .md](run-hisat2.md)

## STEP 3: TRANSCRIPT ABUNDANCE ESTIMATION
With cufflings package, see [this file for details](run-cuffquant-and-cuffnorm.md)

## STEP 4: DATA ANALYSIS
All data analyses were done in R, see [this notebook](kinga-dieta.Rmd)
