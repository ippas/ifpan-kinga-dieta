### step one: try if hisat2 works in a container:
```
docker run -d --rm -v $PWD:/data zlskidmore/hisat2:2.1.0 hisat2 -x /data/rn6-ind/genome -1 /data/fq-additional-samples/raw_data/KM_1_1.fq.gz -2 /data/fq-additional-samples/raw_data/KM_1_2.fq.gz -S /data/KM_1.sam --summary-file /data/KM_1.txt --dta-cufflinks
```

### step two: create a container on a basis of the hisat2 with samtools added (dockerfile in THIS REPO), test if samtools work:
```
docker run -d --rm -v $PWD:/data gosborcz/hisat2-samtools samtools sort -o /data/KM_1.bam -@ 3 /data/KM_1.sam
```

### step three: check if that container works with pipe to create .bam as output on another sample
```
docker run -d --rm -v $PWD:/data gosborcz/hisat2-samtools hisat2 -x /data/rn6-ind/genome -1 /data/fq-additional-samples/raw_data/KM_8_1.fq.gz -2 /data/fq-additional-samples/raw_data/KM_8_2.fq.gz -S /data/KM_8.sam --summary-file /data/KM_8.txt --dta-cufflinks | samtools sort -o /data/KM_8.bam -@ 3
```
