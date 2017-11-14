library("dplyr")
library("magrittr")
library("graphics")
library("ggplot2")
library("rJava")

setwd("~/")

d2=read.table("test_changeInBinomialP.txt", sep="\t", col.names=c("gene", "e13_binomial_pVal", "qVal", "log2_foldChange", "e16_binomial_pval", "change_in_pval"), stringsAsFactors=F)
str(d2)

plot(d2$log2_foldChange, d2$change_in_pval, main="ATACseq v RNAseq", xlab="Sleuth log2(fold change)", ylab="delta_pValue", pch=19)

text(d2$log2_foldChange, d2$change_in_pval, labels=d2$gene, cex=0.7, pos=4, col="red")

text(d2$log2_foldChange[d2$gene=="Sox5"], d2$change_in_pval[d2$gene=="Sox5"], d2$gene[d2$gene=="Sox5"], cex=1, pos=3, col="red")

d2 %>% filter(log2_foldChange >= 0) %>% use_series(gene) %>% n_distinct(na.rm=TRUE)
