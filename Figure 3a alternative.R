library(dplyr)
library(tidyr)

#load the excel file (file = "import your fle")

#to mention the size of the horizontal lines#
p <- ggplot(df3, aes(cultdate, new_st_cluster1)) + geom_line(aes(color=st_1), linewidth = 0.4)+ geom_point(aes(color=source_clean), size = 0.6)
p
#to mention the size of the y labels
p <- p + theme(axis.text.y = element_text(lineheight = 2, size = 4))
p <- p + scale_color_manual(values = c("Clinical" = "red", "Rectal Swab" = "white","ST736" = "brown", "ST18" = "maroon2", "ST17" = "seagreen", "ST203" = "burlywood4", "ST1471" = "deepskyblue3", "ST375" = "plum1", "ST584" = "salmon2", "ST412" = "salmon4", "ST1478" = "purple1", "ST80" = "purple4"))
#removes the background grid lines and provides a outer black border
p <- p + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               panel.background = element_blank(), axis.line = element_line(colour = "black"))
#added a new column to the excel sheet called boder, border = 20 if rectal swab and border = 10 if clinical 
#Now only if the boder is > 10, it will have a blue outline
p <- p + geom_point(data = subset(df3, border > 10), col = "blue", stroke = 0.01, size = 1)
p


###########################################################################################################################################
# how I cleaned the data: merged the date information from one of the tables
df <- VRE_1243_masterlist_09282022 %>% select(isolate, cultdate)
df1 <- merge(x, df, by = "isolate", all.x = T)
df1$culture_date <- strsplit(as.character(df1$cultdate.y), " ")
df1 <- separate(df1, cultdate.y, into = c("culturedate", "time"), sep = " ")
df1 <- df1 %>% select(-culture_date)
df1 <- df1 %>% select(-cultdate.x)
df1 <- df1 %>% select(-time)

# create a column for the border of rectal swabs
df1$border <- ifelse(df1$source == "Clinical", 10, 20)

write.csv(df2, file = "VRE_04042024.csv")