library("dplyr")
library("magrittr")
library("graphics")
library("ggplot2")
library("rJava")

setwd("~/results/screen/")

d1=read.table("test_withRegDomainsP.txt", sep="\t", col.names=c("gene", "size", "peaks", "probability"), stringsAsFactors=F)
str(d1)

test <- function(x, n, p) {binom.test(x, n, p, alternative="two.sided")}
counts <- mapply(test, d1$peaks, n_trials, d1$probability)
str(counts)

counts %>% write.table(file="counts.txt")
