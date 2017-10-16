library("dplyr")
library("magrittr")
library("graphics")
library("ggplot2")
library("rJava")

setwd("")

d1=read.table("test6_withRegDomainsUP.txt", sep="\t", col.names=c("gene", "size", "peaks", "probability"), stringsAsFactors=F)
str(d1)

test <- function(x, n, p) {binom.test(x, n, p, alternative="greater")}
counts <- mapply(test, d1$peaks, 6068, d1$probability)
str(counts)

counts %>% write.table(file="counts.txt")
