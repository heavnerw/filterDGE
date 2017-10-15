library("dplyr")
library("magrittr")
library("graphics")
library("ggplot2")
library("rJava")

setwd("")

d2=read.table("_binomialTest_foldChange.txt", sep="\t", col.names=c("gene", "binomial_pVal", "qVal", "log2_foldChange"), stringsAsFactors=F)
str(d2)

plot(d2$log2_foldChange, -log(d2$binomial_pVal), main="ATACseq v RNAseq", xlab="Sleuth log2(fold change)", ylab="-log(ATACseq binomial pValue)", pch=19)


text(d2$log2_foldChange, -log(d2$binomial_pVal), labels=d2$gene, cex=0.7, pos=4, col="red")

d2 %>% filter(log2_foldChange >= 0) %>% use_series(gene) %>% n_distinct(na.rm=TRUE)
