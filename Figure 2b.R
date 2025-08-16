##################################################
####### Vatsala Srinivasa ########################
#### Figure 2b ####
##################################################


# Load the data 
df <- read_excel("Import your data")

# load the libraries
library(dplyr)
library(ggplot2)
library(scales)

table(df$`SNPs grouping`)

### Arrange your data in ascending order
df$group <- 
  factor(df$`SNPs grouping`,
         levels = c("Species SNPs", "ST SNPs", "SKA SNPs"))

df$`SNPs grouping` <- 
  factor(df$`SNPs grouping`,
         levels = c("Species SNPs", "ST SNPs", "SKA SNPs"))

#plot jitter and box plot

p <- ggplot(df, aes(x = `SNPs grouping` , y = SNPs, fill = `SNPs grouping`)) + 
  geom_jitter(aes(color = `SNPs grouping`), size = 4, position=position_jitterdodge(jitter.width=0.5),
              pch = 20) + geom_boxplot(outlier.shape = NA, alpha = 0.2, width = 0.4)
p <-  p + xlab("") + ylab("Pairwise SNPs") 
p <- p + theme(axis.text=element_text(size=10), 
               axis.text.x = element_text(angle = 360), 
               text = element_text(size = 5), 
               axis.title=element_text(size=15), 
               legend.title = element_text(size = 20),
               legend.text = element_text(size = 20), 
               panel.border = element_blank(), 
               axis.line = element_line(colour = "black"))
#to remove the background grids and gray
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"))
p <- p + scale_y_continuous(breaks = seq(0, 50, 5)) + coord_cartesian(ylim = c(0,50))
p

