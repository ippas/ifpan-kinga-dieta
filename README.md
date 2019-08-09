# ifpan-kinga-dieta
Influence of maternal diet on ofspring gene expression in rat brain (PFC, hippocampus)

## SAMPLE LIST:
[full sample list here](sample-list.tsv)
80 rat brain samples
40/40 M/F
10 samples per group

## STEP 1: FASTQC
Fastqc was run with the [Intelliseq workflow](https://gitlab.com/intelliseq/workflows/raw/dev/src/main/wdl/tasks/generate-fastqc-report/v0.1/generate-fastqc-report.wdl) in cromwell/wdl in batches of 10 files. For details see [this .md](run-fastqc-wdl-in-batches.md). Multiqc was used to generate the final report, in [this docker file](https://hub.docker.com/r/ewels/multiqc). Command:
`docker run --rm -v $PWD:/data ewels/multiqc:latest multiqc /data -o /data`
[link to fastqc report](http://149.156.177.112/projects/ifpan-kinga-dieta/multiqc_report.html)

## STEP 2 : Alignment - with HISAT2 to rat genome
Rat genome version: `Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa.gz` from ensembl + indexes made with hisat2 previously. For details see [this .md](run-hisat2.md)

## STEP #: TRANSCRIPT ABUNDANCE ESTIMATION
With cufflings package, see [this file for details](run-cuffquant-and-cuffnorm.md)
