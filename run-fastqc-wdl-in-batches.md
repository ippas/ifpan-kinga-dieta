## This code is tu run intelliseq's task of fastqc in batches of 10 files

STEP 1 : This line lists all sample names based on the file_1.fq.gz file_2.fq.gz naming convention and counts them:

`ls *1.fq.gz | xargs -i bash -c 'BASENAME2=$(echo {} | cut -d "." -f 1 | cut -d "_" -f 1,2); echo $BASENAME2' | wc -l`

For this analysis I have 72 files and I separate them into 8 parts. Example to get the second part:
`ls *1.fq.gz | xargs -i bash -c 'BASENAME2=$(echo {} | cut -d "." -f 1 | cut -d "_" -f 1,2); echo $BASENAME2' | head -20 | tail -10 > part2.txt`
