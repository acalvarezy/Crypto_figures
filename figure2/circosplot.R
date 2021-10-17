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
data <- read.csv("data.csv", sep=";", header = TRUE, stringsAsFactors=FALSE)
data_final <- data[order(data$chromosome),]
data_final <- data_final[c(7,3,4,2,5,6,8,1)]
write.csv(data_final, "data_final.csv", row.names = TRUE)

chromosome_data = data_final[c(1,2,3)]
write.csv(chromosome_data, "chromosome_data.csv", row.names = TRUE)

gene_label = chromosome_data = data_final[c(1,2,3,4)]
write.csv(gene_label, "gene_label.csv", row.names = TRUE)

groups_rect = chromosome_data = data_final[c(1,2,3,7)]
write.csv(groups_rect, "groups_rect.csv", row.names = TRUE)
known = data_final[data_final['color'] == 1]



#Plotting
circos.initializeWithIdeogram(plotType = NULL)
circos.genomicTrackPlotRegion(data_final, panel.fun = function(region, value, ...) {
  if(CELL_META$sector.index == "chr1") {
    print(head(region, n = 2))
    print(head(value, n = 2))
  }
})

circos.genomicRect(region, value, ytop = 1, ybottom = 0)

circos.genomicTrack(data, numeric.column = 8, 
                    panel.fun = function(region, value, ...) {
                      # numeric.column is automatically passed to `circos.genomicRect()`
                      circos.genomicRect(region, value, ...)
                    })


circos.initializeWithIdeogram(plotType = NULL)
circos.genomicIdeogram()





#data_final$X <- NULL
try = data_final[1:10,]
try <- try[c(1,3,4,2,5,7)]


data <- read.csv("GenesByTaxon_GeneLocation.csv", sep=",", header = TRUE, stringsAsFactors=FALSE)
data_final <- data[order(data$start_context),]





cytoband = read.cytoband()
cytoband_df = cytoband$df
chromosome = cytoband$chromosome

#CircOs plot
circos.clear()
circos.par(start.degree = 90, gap.degree = 1, track.margin = c(-0.002, 0.002), points.overflow.warning = FALSE)
circos.genomicInitialize(data_final, tickLabelsStartFromZero=FALSE)
circos.track(data_final$gene, ylim = c(0, 1),
             bg.col = featurel$color, 
             bg.border = NA, track.height = 0.05)


circos.track(ylim = c(0, 1), 
             bg.col = data_final$color, 
             bg.border = NA, track.height = 0.05)


circos.initialize(df$sectors, x = df$x)

circos.initializeWithIdeogram(chromosome.index = data_final$chr)
text(0, 0, "C. parvum", cex = 1)

circos.initializeWithIdeogram(plotType = NULL)
text(0, 0, "C. parvum", cex = 1)


circos.par("start.degree" = 90)
circos.initializeWithIdeogram()
circos.clear()
text(0, 0, "'start.degree' = 90", cex = 1)




circos.initialize(data_final$gene, xlim = c(0.001, 0.002))

circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.002, 0.002), points.overflow.warning = FALSE)
circos.initialize(try$gene, x =try$end)
circos.track(ylim = c(0, 1))
circos.trackPoints(sectors, x, y)
circos.trackLines(sectors, x, y)





