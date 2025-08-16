########################################################
############## VRE 1243 rectal swab study (Figure 3C) ##############
############### Violin plot ############################
############# Waterfall Plot ###########################
############## Written by: Vatsala #####################
########################################################

############################### Libraries ###############################
install.packages("devtools")
install.packages("ggplot2")
install.packages("dplyr")
#This is a package for paired waterfall plot
devtools::source_url("https://raw.githubusercontent.com/yjunechoe/geom_paired_raincloud/master/geom_paired_raincloud.R")
install.packages("ggdist")
install.packages("palettes")
install.packages("forcats")

library(devtools)
library(ggplot2)
library(dplyr)
library(ggdist)
library(palettes)
library(forcats)

###############################Violin plot ###############################

# Load the data (cheet waterfall plot)
VRE_clustering <- VRE_clustering_07172023
colnames(VRE_clustering)

p <- ggplot(VRE_clustering, aes(x=group, y= clustering)) +
  geom_violin(trim=FALSE, fill='#A4A4A4', color="black")+
  geom_boxplot(width=0.05, outlier.shape = NA) + theme_linedraw() + theme_bw()
p



############################### Waterfall plot #######################################

#organize the data by recognizing the pairs, give unique numbers to the pairs, so the software can recognize it
#This gives 2-half violin plots by group, box plots and dot plot with connected pairs

r <- VRE_clustering %>% 
  # arrange by individual paired number
  arrange(number) %>% 
  ggplot(aes(x=group, y= clustering, fill = group)) +
  geom_paired_raincloud() + geom_point(aes(group = number), position = position_nudge(c(-.05, .05)), 
                                       alpha = 0.5, shape = 16, show.legend = FALSE) + 
  geom_line(aes(group = number), position = position_nudge(c(.05, -.05))) + 
  geom_boxplot(position = position_nudge(c(.06, -.06)), alpha = .5, width = .04, outlier.shape = " ")
r

#if the data is not continuous, make histogram's instead; Codes below


######################### histogram################

#for clinical isolates
clinical <- VRE_clustering
colnames(clinical)
clinical <- clinical %>% filter(clinical$group == "Clinical only")
a <- ggplot(clinical, aes(x=clustering))+
  geom_histogram(color="black", fill="#F8766D") + 
  theme(panel.border = element_blank(), axis.line = element_line())

#for rectal isolates
rectal <- VRE_clustering
table(rectal$group)
rectal <- VRE_clustering %>% filter(rectal$group == "Rectal addition")
b <- ggplot(rectal, aes(x=clustering))+
  geom_histogram(color="black", fill="#00BFC4") + 
  theme(panel.border = element_blank(), axis.line = element_line())


#### save the histograms and the violin plot seperatly, edit on pdf (remove the half violin and attach the rotated histograms)

################# END ####################