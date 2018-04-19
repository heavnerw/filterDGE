library("dplyr")
library("magrittr")
library("graphics")
library("ggplot2")

source("http://bioconductor.org/biocLite.R")
library(BiocInstaller)
biocLite("devtools")

biocLite("pachterlab/sleuth")
library('sleuth')

setwd("~/Documents/Results/RNAseq/layersUpper_Cdk5r/analysis/kallisto_ENS/results/results_3")

base_dir <- "~/Documents/Results/RNAseq/layersUpper_Cdk5r/analysis/kallisto_ENS/results"
sample_id <- dir(file.path(base_dir,"results_3"))
sample_id

kal_dirs <- sapply(sample_id, function(id) file.path(base_dir, "results_3", id, "kallisto"))
kal_dirs

#Write a .txt file with the sample ID and conidition information for each replicate. Headers = "sample" and "condition".
s2c <- read.table(file.path(base_dir, "sampleInfo_3.txt"), header = TRUE, stringsAsFactors=FALSE)
s2c <- dplyr::select(s2c, sample, condition)
s2c
s2c <- dplyr::mutate(s2c, path = kal_dirs)
print(s2c)

##Reading in gene names

#if using ENSEMBL genes
source("http://bioconductor.org/biocLite.R")
biocLite("biomaRt")
listMarts(host="www.ensembl.org") #may need to specify which version if not using most recent
mart <- biomaRt::useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "mmusculus_gene_ensembl", archive=TRUE, version=mm9, host = 'ensembl.org')
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name"), mart = mart)
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)
#or simply
t2g <- read.table(file.path(base_dir, "ensembl_genes_mm9.txt"), header = TRUE, stringsAsFactors=FALSE)

#if using UCSC genes, read in file "ucscTranscriptsGenes.txt".
t2g <- read.table(file.path(base_dir, "ucscTranscriptsGenes.txt"), header = TRUE, stringsAsFactors=FALSE)

#Wald Test
so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE, target_mapping = t2g)
so <- sleuth_fit(so, ~condition, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_wt(so, which_beta = 'conditionP5')
sleuth_live(so)

results_table <- sleuth_results(so, 'conditionP5')
write.table(results_table, "test_table_UL_3.txt", sep='\t', quote=FALSE) 

#Likelihood ratio test
so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE, target_mapping = t2g)
so <- sleuth_fit(so, ~condition, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')
models(so)
sleuth_live(so)

results_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)
write.table(results_table, "SleuthLRT_mid.txt", sep='\t', quote=FALSE) 

help(package="sleuth")
