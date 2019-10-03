# ifpan-kinga-dieta
Influence of maternal diet on ofspring gene expression in rat brain (PFC, hippocampus)

## Method:
All samples were checked for quality with fastQC v0.11.8 and aligned to a rat reference genome (rn6 from Ensembl database) with hisat2 2.1.0. Cufflinks v 2.2.1 package and GTF from the Ensembl gene database were used to quantify (cuffquant) and normalize (cuffnorm) transcripts to fpkms (Fragments Per Kilobase of transcript per Million fragments mapped). All statisical analyses were performed with R software v3.4. Statistical significance was tested using ANOVA on log2(1 + x) values with false discovery rate adjustment. For post-hoc analysis, pairwise t-tests with Bonferroni corrections were performed. "p" and "fdr" values < 0.05 were considered statistically significant 

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
All data analyses were done in R, see [this notebook](http://149.156.177.112/projects/ifpan-kinga-dieta/analysis/kinga-dieta.nb.html)

