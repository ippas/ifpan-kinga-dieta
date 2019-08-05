### step one: try if hisat2 works in a container:
`
docker run -d --rm -v $PWD:/data zlskidmore/hisat2:2.1.0 hisat2 -x /data/rn6-ind/genome -1 /data/fq-additional-samples/raw_data/KM_1_1.fq.gz -2 /data/fq-additional-samples/raw_data/KM_1_2.fq.gz -S /data/KM_1.sam --summary-file /data/KM_1.txt --dta-cufflinks
`

### step two: create a container on a basis of the hisat2 with samtools added, test if samtools work:
`
docker run -d --rm -v $PWD:/data gosborcz/hisat2-samtools samtools sort -o /data/KM_1.bam -@ 3 /data/KM_1.sam
`

### step three: check if that container works with pipe to create .bam as output on another sample
`
docker run -d --rm -v $PWD:/data gosborcz/hisat2-samtools /bin/bash -c "hisat2 -x /data/rn6-ind/genome -1 /data/fq-additional-samples/raw_data/KM_21_1.fq.gz -2 /data/fq-additional-samples/raw_data/KM_21_2.fq.gz --summary-file /data/KM_21.txt --dta-cufflinks | samtools sort -@ 3 -o /data/KM_21.bam -"
`
samtools does not want to take the output from pipe unless you put it in the `/bin/bash -c "command1 | comman2"` syntax, but the the --rm option does not work, but thats fine for now as I want to run it with wdl anyway

### step four: I have added hisat2 indices into the docker container and try running it with another sample [dockerfile here](https://github.com/gosborcz/workflows/blob/master/hisat2-samtools-dockerfile):
`
docker run -d --rm -v $PWD:/data gosborcz/hisat2-samtools /bin/bash -c "hisat2 -x /home/genome -1 /data/fq-additional-samples/raw_data/KM_36_1.fq.gz -2 /data/fq-additional-samples/raw_data/KM_36_2.fq.gz --summary-file /data/KM_36.txt --dta-cufflinks | samtools sort -@ 3 -o /data/KM_36.bam -"
`
### step five: write a .wdl task [code here](https://github.com/gosborcz/workflows/blob/master/align-with-hisat2-to-rat-genome), check it with (womtool), generate a .json and try running.
input:
`{
  "align_to_rat_genome.align_with_hisat2.fastq1": "KM_40_1.fq.gz",
  "align_to_rat_genome.align_with_hisat2.sample_name": "KM_40",
  "align_to_rat_genome.align_with_hisat2.fastq2": "KM_40_2.fq.gz"
}`
to run:
`java -jar /opt/tools/cromwell-44.jar run align-with-hisat2.wdl -i KM_40.json`

### step six - run cuffquant to see if the alignment works on two samples?


### step seven - continue alignment with batches of 10

