############################################################################
############## SNP accumulation plot with regression equation (Figure 2C) ##############
######################### VRE rectal swab study ############################
############################################################################

remove(list = ls())

# load the data
df <- read_excel("import your data")


library(ggplot2)
library(dplyr)


# Plotting multiple Regression Lines
install.packages("lme4")
library(lme4)
fits <- lmList(SNPs ~ Diff | group, data=df)
fits

p <- ggplot(df,aes(x=Diff,y=SNPs,color=group))+
  geom_point()
p <- p + scale_color_manual(values=c("#619CFF","#00BA38"))
p
q <- p + geom_smooth(method=lm,se=T,fullrange=TRUE,
                     aes(color=group)) + theme_classic()
q <- q + coord_cartesian(xlim = c(0,300), ylim = c(0,25))
q <- q + scale_y_continuous(breaks = seq(0, 30, 5)) + scale_x_continuous(breaks = seq(0, 300, 50))
q