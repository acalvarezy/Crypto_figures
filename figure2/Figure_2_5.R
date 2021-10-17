setwd("/Users/ae-tafur/Dropbox/UNIANDES/THESIS_DATA")
library(readr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(ggrepel)
library(ggpubr)
library(circlize)
library(ggsci)
library(tidyverse)

dicc <- read.csv("RNAseq/diccionario.txt", sep="\t", header = TRUE, stringsAsFactors=FALSE)
  
data <- read.csv("RNAseq/Exp_3_vs_Exp_11/tables/ExpthreevsExpeleven.complete.txt", 
                 sep="\t", header = TRUE, stringsAsFactors=FALSE)

data[is.na(data)] = 0

data$DEG_type <- ifelse(abs(data$log2FoldChange) >= 2 & data$padj <= 0.05, "Down", "NA")
data$locus_tag <- data$Id

contador = 1
from = 1
for(i in data$DEG_type)
{
  encontrado = FALSE
  while(from <= length(dicc$refseq.tag) & !encontrado)
  {
    if(data$Id[contador] == dicc$refseq.tag[from])
    {
      if (dicc$Gene.name[from] != "")
      {
        data$Id[contador] = dicc$Gene.name[from]
      }
        encontrado = TRUE
    }
    from = from + 1
  }
  
  if(data$log2FoldChange[contador] >= 2 & data$padj[contador] <= 0.05)
  {
    data$DEG_type[contador] = "Up"
  }
  contador = contador + 1 
}

write.csv(data, '3vs11.txt')

pdf(file="Thesis/PhD/Plots/Figure 6a.pdf", width=7.08661, height=4.72441)

p1 <- ggplot(data, aes(x = data$log2FoldChange, y = -log10(data$padj), 
                       colour = data$DEG_type, label = data$Id, 
                       shape = data$DEG_type, fill = data$DEG_type)) + 
  theme_classic2() + geom_point(alpha = 0.7, size = 2) +
  geom_text_repel(aes(label= ifelse( (abs(data$log2FoldChange) > 4) & (data$padj <= 0.05),
                                    ifelse(startsWith(data$Id, "ECOLC"), 
                                           substring(data$Id, 9, 15), data$Id), '')), size = 2.3,
                  fontface = 'bold', color = 'gray28') +
  scale_x_continuous(limits = c(-12,10), breaks=seq(-12,10,2)) + 
  scale_y_continuous(limits = c(-15,350)) +
  scale_shape_manual(values = c("Down"=21, "Up"=24, "NA"=22)) +
  scale_color_manual(values = c("Down"="#4f86f7", "Up"="#f28500", "NA" = "#808080")) +
  scale_fill_manual(values = c("Down"="#4f86f7", "Up"="#f28500", "NA" = "#808080")) +
  labs(x = bquote(~Log[2]~ "FoldChange( Exp 3 / Exp 11 )"), y = bquote(~-Log[10]~adjusted~italic(P))) +
  geom_vline(xintercept=c(-2, 2), linetype="longdash", colour="black", size=0.4) +
  geom_hline(yintercept=-log10(data$padj<0.05), linetype="longdash", colour="black", size=0.4) +
  theme(text = element_text(size=10, family = "Palatino", colour = "black"),
        legend.position='none', axis.text = element_text(size=10, family = "Palatino", colour = "black")) +
  annotate("text", x = -7, y = -15, size = 3, label = "Down-regulated", color = "#4f86f7") +
  annotate("text", x = 7, y = -15, size = 3, label = "Up-regulated", color = "#f28500")

p1

dev.off()

dataCOG <- read.table("RNAseq/Exp_3_vs_Exp_11/COG.txt", sep="\t", header = TRUE, row.names = 1)

data_long <- dataCOG %>%
  rownames_to_column %>%
  gather(key = 'key', value = 'value', -rowname)


circos.clear()
circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
par(mar = rep(0, 4))

# Base plot
chordDiagram(
  x = dataCOG, 
  grid.col = pal_jco()(8),
  transparency = 0.75,
  directional = 1,
  direction.type = c("arrows", "diffHeight"), 
  diffHeight  = -0.04,
  annotationTrack = "grid", 
  annotationTrackHeight = c(0.05, 0.1),
  link.arr.type = "big.arrow", 
  link.sort = TRUE, 
  link.largest.ontop = TRUE)


graph2pdf(file="Thesis/PhD/Plots/Figure_6b.pdf", width=7.08661, height=4.72441, cairo=TRUE,
          font = 'Helvetica', fallback_resolution=300)

