## This code is tu run intelliseq's task of fastqc in batches of n files

STEP 1 : This line lists all sample names based on the file_1.fq.gz file_2.fq.gz naming convention and counts them:

`ls *1.fq.gz | xargs -i bash -c 'BASENAME2=$(echo {} | cut -d "." -f 1 | cut -d "_" -f 1,2); echo $BASENAME2' | wc -l`

For this analysis, in one of the folders, I have 72 files and I separate them into 8 parts. Example to get the second part:
`ls *1.fq.gz | xargs -i bash -c 'BASENAME2=$(echo {} | cut -d "." -f 1 | cut -d "_" -f 1,2); echo $BASENAME2' | head -20 | tail -10 > part2.txt`

To generate json input files (generated earlier with WOMtool) from names in partn:
`less partn.txt | xargs -i bash -c 'echo "{\"generate_fastqc_report_workflow.generate_fastqc_report.fastq_1\":\"{}_1.fq.gz\",\"generate_fastqc_report_workflow.generate_fastqc_report.fastq_2\":\"{}_2.fq.gz\"}">{}-input.json'`

To run the workflow on an example file:
`java -jar /opt/tools/cromwell-44.jar run https://gitlab.com/intelliseq/workflows/raw/dev/src/main/wdl/tasks/generate-fastqc-report/v0.1/generate-fastqc-report.wdl -i KM_12-input.json > log-KM_12.txt`

To run the workflow on all files in the partn.txt:
`less partn.txt | xargs -i bash -c 'java -jar /opt/tools/cromwell-44.jar run https://gitlab.com/intelliseq/workflows/raw/dev/src/main/wdl/tasks/generate-fastqc-report/v0.1/generate-fastqc-report.wdl -i {}-input.json > log-{}.txt' &`
*the '&' sign at the end of line tells bash to run whatever command in the background
