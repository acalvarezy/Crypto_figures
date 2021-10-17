setwd("/Users/catalina/Dropbox/UVA/CareyLab/cryto_models/figure2")
library(readr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(ggrepel)
library(ggpubr)
library(circlize)
library(ggsci)
library(tidyverse)
library(data.table)
library(RColorBrewer)
install.packages(ComplexHeatmap)
library(ComplexHeatmap)

#Loading the data
data <- read.csv("data.csv", sep=",", header = TRUE, stringsAsFactors=FALSE)
data_chr <- data[c(2,3,4)]
data_genes <- data[c(2,3,4,5)]
feature = data[c(2,3,4,8)]
feature2 = data[c(8)]
color = data.frame(feature2[1:404,])

#Plotting the data
tiff("Plot.tiff", width = 16, height = 12, units = 'in', res = 300)
circos.clear()
circos.par(start.degree = 90, gap.degree = 1, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
circos.par("track.height" = 0.1, cell.padding = c(0, 0, 0, 0))
circos.genomicInitialize(data_chr, axis.labels.cex = 0.7*par("cex"),
                         labels.cex = 1.5*par("cex"))
circos.genomicTrack(feature,  bg.col = "white", panel.fun = function(region, value, ...) {
  circos.genomicRect(region, value, col = ifelse(value[[1]] == "1", "blue1", "blue1"), border = NA, ...)
  
})
circos.genomicTrack(feature,  bg.col = "white", panel.fun = function(region, value, ...) {
  circos.genomicRect(region, value, col = ifelse(value[[1]] == "1", "palevioletred4", "aquamarine1"), border = NA, ...)
  
})

lgd = Legend(labels = c("Annotated genes", "Genes with known product", "Genes with unknown product"), legend_gp = gpar(fill = c("blue1", "aquamarine1","palevioletred4")), title = "Gene status",
             labels_gp = gpar(col = "black", fontsize = 12))
draw(lgd, x = unit(37, "cm"), y = unit(27, "cm"), just = c("right", "top"))

text(0, 0, "Cryptosporidium parvum", cex = 1.5, font = 3)

dev.off()

