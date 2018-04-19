biocLite("edgeR")
biocLite("gplots")
biocLite("Glimma")

library(limma)
library(ggplot2)
library(RColorBrewer)
library(edgeR)
library(edgeR)
library(gplots)
library(Glimma)
library("dplyr")

setwd("~/Google Drive/projects/sortedPopulations/screen/rnaseq/kallisto/tpm/known_avg/")

data <- read.table("DL_avgTPM_transcripts_TFs.txt", sep="\t", stringsAsFactors = FALSE)
sampleinfo <- read.delim("sample_info.txt")

head(data)
tail(data)
str(data)

data2 <- data[,-(1)]
head (data2)
countdata <- data2[,-(7)]
head (countdata)

rownames(countdata) <- data[,1]
head(countdata)

colnames(countdata)
table(colnames(countdata)==sampleinfo$SampleName)

matrix <- data.matrix(countdata)
str(matrix)
row.names(matrix) <- data[,8]

mypalette <- brewer.pal(11,"RdYlBu")
morecols <- colorRampPalette(mypalette)
col.cell <- c("blue","orange")[sampleinfo$CellType]
heatmap.2(matrix, col=rev(morecols(50)), trace="none", scale="row", Colv=FALSE, Rowv=FALSE)

