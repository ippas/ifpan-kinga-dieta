# ifpan-kinga-dieta
Influence of maternal diet on ofspring gene expression in rat brain (PFC, hippocampus)

## SAMPLE LIST:
80 rat brain samples
40/40 M/F
10 samples per group

## STEP 1: FASTQC
Fastqc was run with the [Intelliseq workflow](https://gitlab.com/intelliseq/workflows/raw/dev/src/main/wdl/tasks/generate-fastqc-report/v0.1/generate-fastqc-report.wdl) in cromwell/wdl

to run the fastqc:
``` 
java -jar /opt/tools/cromwell-44.jar run https://gitlab.com/intelliseq/workflows/raw/dev/src/main/wdl/tasks/generate-fastqc-report/v0.1/generate-fastqc-report.wdl -i fastqc-inputs.json > cromwell-workflow-logs/KM_11.txt &
```

