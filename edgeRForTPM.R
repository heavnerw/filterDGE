biocLite("edgeR")
biocLite("gplots")
biocLite("Glimma")

library(limma)
library(ggplot2)
library(RColorBrewer)
library(edgeR)
library(gplots)
library(Glimma)
library(dplyr)

setwd("~/Google Drive/projects/sortedPopulations/screen/rnaseq/kallisto/tpm/")

data <- read.delim("all_tpm_wGeneNames.txt", stringsAsFactors = FALSE)
sampleinfo <- read.delim("sample_info.txt")

head(data)
str(data)

data2 <- data[,-(1)]
head (data2)
countdata <- data2[,-(13)]
head (countdata)

rownames(countdata) <- data[,1]
head(countdata)

colnames(countdata)
table(colnames(countdata)==sampleinfo$SampleName)

thresh <- countdata > 0.5
head (thresh)
table(rowSums(thresh))
keep <- rowSums(thresh) >= 2
counts.keep <- countdata[keep,]
summary(keep)
dim(counts.keep)

y <- DGEList(counts.keep)
y
names(y)
y$samples

plotMDS(y)

logcounts <- cpm(y,log=TRUE)
head(logcounts)
boxplot(logcounts, xlab="", ylab="Log2 TPM", las=2)

var_genes <- apply(logcounts, 1, var)
head(var_genes)
select_var <- names(sort(var_genes, decreasing=TRUE)) [1:500]
head(select_var)
select_var %>% write.table(file="mostVariable500.txt")
##Use sed to remove quotes from a string: > sed "s/^\(\"\)\(.*\)\1\$/\2/g" mostVariable.txt > mostVariableTx.txt ##

highly_variable <- logcounts[select_var,]
dim(highly_variable)
head(highly_variable)
highly_variable_matrix <- data.matrix(highly_variable)
row.names(highly_variable_matrix) <- select_var #This matrix starts with a header, so subtract 1 from each row of the row index in the results below.
row.names(highly_variable_matrix)

mypalette <- brewer.pal(11,"RdYlBu")
morecols <- colorRampPalette(mypalette)
col.cell <- c("blue","orange")[sampleinfo$CellType]
heatmap.2(highly_variable_matrix, col=rev(morecols(50)), trace="none", scale="row", labRow=TRUE)

geneNames <- heatmap.2(highly_variable_matrix, col=rev(morecols(50)), trace="none", scale="row", labRow=row.names(highly_variable_matrix))
geneNames$rowInd

