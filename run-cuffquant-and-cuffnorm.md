cufflinks package v.2.2.1 [pulled from docker](https://hub.docker.com/r/octavianus90/cufflinks_final)

1. Create folders to store cuffquant output:
`ls ./bam | xargs -i basename {} .bam | xargs -i mkdir ./cuffquant/{}`

2. Run cuffquant with docker in parts:
```
less part6.txt | xargs \
-i bash -c 'docker run -d --rm \
-v $PWD:/data octavianus90/cufflinks_final:latest \
cuffquant -o /data/cuffquant/{} \
/data/rn6/Rattus_norvegicus.Rnor_6.0.90.gtf /data/bam/{}.bam'
```


