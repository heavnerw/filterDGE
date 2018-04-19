library("dplyr")
library("magrittr")
library("graphics")
library("ggplot2")

setwd("")

d1=read.table("test.txt", sep="\t", col.names=c("gene", "size", "peaks", "probability"), stringsAsFactors=F)
str(d1)

test <- function(x, n, p) {binom.test(x, n, p, alternative="greater")}
counts <- mapply(test, #x, #n>x, #p)
str(counts)
counts
counts %>% write.table(file="counts.txt")
