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

#Loading the data
data <- read.csv("data_final.csv", sep=";", header = TRUE, stringsAsFactors=FALSE)
labels <- read.csv("gene_label.csv", sep=";", header = TRUE, stringsAsFactors=FALSE)
feature <- read.csv("groups_rect.csv", sep=";", header = TRUE, stringsAsFactors=FALSE)

#Plotting the data
tiff("Plot3.tiff", width = 16, height = 12, units = 'in', res = 300)
circos.clear()
circos.par(start.degree = 90, gap.degree = 1, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
circos.genomicInitialize(data)
circos.genomicTrack(feature, numeric.column = 4, 
                    panel.fun = function(region, value, ...) {
                      circos.genomicRect(region, value, bg.col = feature$color, 
                                         bg.border = NA, track.height = 0.8, ...)
                    })

dev.off()