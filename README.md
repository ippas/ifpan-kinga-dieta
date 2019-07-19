# ifpan-kinga-dieta
Influence of maternal diet on ofspring gene expression in rat brain (PFC, hippocampus)

## SAMPLE LIST:
80 rat brain samples
40/40 M/F
10 samples per group

## STEP 1: FASTQC
Fastqc was run with the [Intelliseq workflow](https://gitlab.com/intelliseq/workflows/raw/dev/src/main/wdl/tasks/generate-fastqc-report/v0.1/generate-fastqc-report.wdl) in cromwell/wdl in batches of 10 files. For details see [this .md](run-fastqc-wdl-in-batches.md). Multiqc was used to generate the final report, in [this docker file](https://hub.docker.com/r/ewels/multiqc). Command:
`docker run --rm -v $PWD:/data ewels/multiqc:latest multiqc /data -o /data` 
