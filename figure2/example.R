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

# circos.genomicTrack(feature, numeric.column = 4,
#                     panel.fun = function(region, value, ...) {
#                       circos.genomicRect(region, value, col = NA,
#                                          bg.border = NA, track.height = 0.8, ...)
# })

# circos.genomicTrack(feature, numeric.column = 4, bg.col = "grey",
#                     panel.fun = function(region, value, ...) {
#                       circos.genomicRect(region, value, col = ifelse(value[[1]] == "1", "red", "green"),
#                                          bg.border = NA, track.height = 0.8, ...)
#                     })

