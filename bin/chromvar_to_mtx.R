#!/usr/bin/Rscript
library(Matrix)

args = commandArgs(trailingOnly=TRUE)
load(args[1])

write.csv(motif_mm@rowRanges, 'peaks.csv')
write.csv(motif_mm@colData, 'tfs.csv')
writeMM(motif_mm@assays@data$motifMatches, 'matrix.mtx')
