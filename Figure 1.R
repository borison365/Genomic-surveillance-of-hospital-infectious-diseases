#####################################################################
################## VRE rectal swab project ##########################
####### Codes to make stacked bar graph and a line plot #############
################ written by: Vatsala Srinivasa ######################
#####################################################################

#### Install (run once if you don't have these) ####
# install.packages(c("ggplot2","dplyr","ggridges","lubridate","readxl"))

#Load libraries
library(ggplot2)
library(dplyr)
library(ggridges)
library(lubridate)
library(readxl)  # <— added so read_excel works for everyone

##### OPTIONAL: let a casual user pick the file via a dialog #####
# excel_path <- file.choose()
# Copy_of_VRE_Alex_New <- read_excel(excel_path)

#load the excel sheet
#import the month column as a date while importing the excel sheet
df <- read_excel("import your file of choice")
colnames(df)

##### OPTIONAL: if month did NOT import as Date, quickly fix it #####
# If month looks like "2024-01-01" strings or Excel serials, uncomment ONE of these:
# df$month <- as.Date(df$month)                  # if it already looks like "YYYY-MM-DD"
# df$month <- lubridate::ymd(df$month)           # if it looks like "2024-01-01" text
# df$month <- as.Date(df$month, origin = "1899-12-30")  # if it's an Excel serial number

# Codes for the line graph
y <- ggplot(df, aes(x=month, y=`VRE Rate/1000 Patient Days`)) + geom_line(size = 1, color="black", group = 1)
y
#export this as pdf

##### EXPORT: make it easy for anyone to save the line graph #####
ggplot2::ggsave(filename = "vre_rate_line.pdf", plot = y, width = 8.5, height = 5, units = "in")

# Codes for stacked bar graph
p <- ggplot(df, aes(x=month, y=stack, fill=factor(group, levels = c("Rectal", "Clinical")))) +
  geom_bar(stat="identity", alpha = 0.6) + scale_fill_manual(values=c('blue','red'))
p <- p + coord_cartesian(ylim = c(0,175))
p <- p + scale_y_continuous(breaks = seq(0, 175, 20))
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"), legend.position = "none")
p
# Export this a pdf

##### EXPORT: make it easy for anyone to save the bar chart #####
ggplot2::ggsave(filename = "vre_stacked_bars.pdf", plot = p, width = 8.5, height = 5, units = "in")
