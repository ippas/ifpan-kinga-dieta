require(magrittr)
require(dplyr)


samples_behavior <- read.table("behavioral_data_samples.csv", row.names = 1, header= TRUE, sep = ';', dec = ',')
results_behavior <- read.table("behavioral_data_results.csv", row.names = 1, header = TRUE, sep = ';', dec = ',')

results_behavior <- results_behavior[,1:12]
results_behavior <- t(results_behavior)

samples_behavior$animal <- c(rep(c(1:80), 2))
samples_behavior$group <-paste(samples_behavior$diet,samples_behavior$pnd,samples_behavior$sex,sep="_")

stat <- function(x) {
  tidy(aov(x ~ samples_behavior$sex 
    * samples_behavior$pnd 
    * samples_behavior$diet 
    + Error(samples_behavior$animal)))  %>%
    data.frame %>%
    write.table(quote=FALSE, row.names=FALSE) }

apply(results_behavior, 1, stat)

stat(results_behavior[2,])




stat.post.hoc <- function(x) {
  y <- unlist(x, use.names = FALSE)
  pairwise.t.test(y, diet_28, p.adjust.method = "none") %>%
    unlist -> p.diet
  p.diet <- p.diet[c("p.value3","p.value6","p.value9")]
  p.diet %>% unlist(use.names = FALSE) -> p.diet
  y <- unlist(x, use.names = FALSE)
  pairwise.t.test(y, samples_behavior$group[1:80], p.adjust.method = "none") %>%
  unlist -> p.group
  p.group <- p.group[c("p.value6","p.value20","p.value34", "p.value14", "p.value28", "p.value42" )]
  p.group %>% unlist(use.names = FALSE) -> p.group
  c(p.diet, p.group) %>% p.adjust(., method = "bonferroni")
}

stat.post.hoc.2 <- function(x) {
  y <- unlist(x, use.names = FALSE)
  pairwise.t.test(y, diet_63, p.adjust.method = "none") %>%
    unlist -> p.diet
  p.diet <- p.diet[c("p.value3","p.value6","p.value9")]
  p.diet %>% unlist(use.names = FALSE) -> p.diet
  y <- unlist(x, use.names = FALSE)
  pairwise.t.test(y, samples_behavior$group[81:160], p.adjust.method = "none") %>%
    unlist -> p.group
  p.group <- p.group[c("p.value6","p.value20","p.value34", "p.value14", "p.value28", "p.value42" )]
  p.group %>% unlist(use.names = FALSE) -> p.group
  c(p.diet, p.group) %>% p.adjust(., method = "bonferroni")
}

#post-hoc results p: hcd28f vs sd28f, hfd28f vs sd28f, md28f vs sd28f; hcd28m vs sd28m, hfd28m vs sd28m, md28m vs sd28m


two_way_post_hoc_28 <- apply(results_behavior[,1:80], 1, stat.post.hoc)

two_way_post_hoc_63 <- apply(results_behavior[,81:160], 1, stat.post.hoc.2)

write.table(two_way_post_hoc_28, 'two_way_post_hoc_28.csv')
write.table(two_way_post_hoc_63, 'two_way_post_hoc_63.csv')
