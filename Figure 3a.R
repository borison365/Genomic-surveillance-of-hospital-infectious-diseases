################################################
#### By: Vatsala Srinivasa (Figure 3a) #####################
### This plot mimics the plot in c.diff paper###
################################################

# additional adjustements to the final plot is made in Pdf editor and ppt

## install and load these packages
library(ggplot2)
install.packages("plotly")
library(plotly)
library(dplyr)
library(lubridate)

## import the dataset
x <- VRE_Cdiff_plot
## this was sheet 2
## this dataset does not contain same patient clusters
###ie. if a cluster of 2 samples is made up of same patient, then it is not considered as cluter

##make a list of the column names
colnames(x)

##make a table of the source
table(x$source_clean)

## this plot would color only the source and not the ST
p <- ggplot(x, aes(cultdate, st_cluster)) + geom_line(cex.axis=0.5)+ geom_point(aes(color=source_clean), size = 0.5)
p <- p + scale_color_manual(values = c("Blood" = "black", "Body fluid/Other" = "red", "Rectal Swab" = "blue", "Tissue/Wound" = "cyan","Urine" = "pink"))
p


p <- ggplot(x, aes(cultdate, st_cluster)) + geom_line(cex.axis=0.5)+ geom_point(aes(color=source_clean), size = 0.5)
p <- p + scale_color_manual(values = c("Blood" = "black", "Body fluid/Other" = "red", "Rectal Swab" = "blue", "Tissue/Wound" = "cyan","Urine" = "pink"))
#this mentions the size of y tick labels
p <- p + theme(axis.text.y = element_text(lineheight = 2, size = 3))
p


####### use this if you have to label all the different source and not just clinical/rectal swab #################
p <- ggplot(VRE_Daria_Plot_data, aes(cultdate, new_st_cluster1)) + geom_line(aes(color=st_1))+ geom_point(aes(color=source_clean_1), size = 0.5)
p <- p + theme(axis.text.y = element_text(lineheight = 2, size = 4))
p <- p + scale_y_discrete(labels = unique(VRE_Daria_Plot_data$st_cluster))
p <- p + scale_color_manual(values = c("Blood" = "black", "Body fluid/Other" = "red", "Rectal Swab" = "blue", "Tissue/Wound" = "cyan","Urine" = "orange", "ST736" = "brown", "ST18" = "maroon2", "ST17" = "seagreen", "ST203" = "burlywood4", "ST1471" = "deepskyblue3", "ST375" = "plum1", "ST584" = "salmon2", "ST412" = "salmon4", "ST1478" = "purple1", "ST80" = "purple4"))
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"))
p


####### used this code to make the final plot ################

#to mention the size of the horizontal lines#
p <- ggplot(VRE_Daria_Plot_data, aes(cultdate, new_st_cluster1)) + geom_line(aes(color=st_1), size = 0.02)+ geom_point(aes(color=source_clean_1), size = 0.5)
#to mention the size of the y labels
p <- p + theme(axis.text.y = element_text(lineheight = 2, size = 4))
p <- p + scale_color_manual(values = c("Clinical" = "red", "Rectal Swab" = "blue", "ST736" = "brown", "ST18" = "maroon2", "ST17" = "seagreen", "ST203" = "burlywood4", "ST1471" = "deepskyblue3", "ST375" = "plum1", "ST584" = "salmon2", "ST412" = "salmon4", "ST1478" = "purple1", "ST80" = "purple4"))
#removes the background grid lines and provides a outer black border
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"))
p

