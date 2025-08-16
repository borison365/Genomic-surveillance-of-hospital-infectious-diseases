
#####################################################################
################## VRE rectal swab project ##########################
####### Figure 2A #############
################ written by: Vatsala Srinivasa ######################
#####################################################################



## import the excel sheet ##
library(readxl)
df <- read_excel("import your file")

## upload the packages##
library(ggplot2)

## boxplot and jitter plot

#### inital plot without zooming in 
p <- ggplot(VRE_panel1_long_to_wide, aes(x= x_axis, y= Diff_days)) + 
  geom_boxplot(width = 0.25, lwd = 0.75, alpha = 0.6, outlier.shape = NA)
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"))
p <- p + geom_jitter(size = 1.5, width=0.1, color = "aquamarine4")
p

#### Zoom in box plot and jitter plot and make the jitter with black boder and white fill
library(scales)
fspec = function(x) ifelse(x<200, x, 200+(x-200)/10)
fspec_1 = function(x) ifelse(x<200, x, 200+(x-200)*10)
specTrans = trans_new(name = "specialTras",
                      transform = fspec,
                      inverse = fspec_1,
                      breaks = c(0, 100, 200, 300, 400, 500, 600, 700))
p <- df %>% ggplot(aes(x=x_axis, y=Diff_days)) + 
  geom_boxplot(width = 0.25, lwd = 0.75, alpha = 0.6, outlier.shape = NA)+
  coord_trans(y = specTrans)
p <- p + geom_jitter(data = subset(df, Diff_days > -0.1), col = "black", stroke = 0.9, shape = 21, size = 1.5, width=0.07)
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"))
p <- p + scale_y_continuous(breaks = seq(0, 700, 20))
p
