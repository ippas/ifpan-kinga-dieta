docker run -d --rm -v $PWD:/data zlskidmore/hisat2:2.1.0 hisat2 -x /data/rn6-ind/genome -1 /data/fq-additional-samples/raw_data/KM_1_1.fq.gz -2 /data/fq-additional-samples/raw_data/KM_1_2.fq.gz -S /data/KM_1.sam --summary-file /data/KM_1.txt --dta-cufflinks


docker run -d --rm -v $PWD:/data gosborcz/hisat2-samtools samtools sort -o /data/KM_1.bam -@ 3 /data/KM_1.sam