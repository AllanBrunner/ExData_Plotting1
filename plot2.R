########1#########2#########3#########4#########5#########6#########7###########
#                                                                              #
#  plot1.R (03/8/2021)                                                         #
#                                                                              #
#  This program creates plot #1 for the EDA Assignment #1.                     #
#                                                                              #
#########1#########2#########3#########4#########5#########6#########7##########

   library(ggplot2)


#  read in household power consuption data
# keep only observations for 2007-02-01 and 2007-02-02

   hpc_dat <- read.table("data/hpc_keep.txt", stringsAsFactors=FALSE, header=TRUE)
   
   hpc_dat$Date <- as.Date(hpc_dat$Date2, format="%d/%m/%Y")
   
   
   
   head(hpc_dat)
   summary(hpc_dat)

   
#  creat 2n plot -- a historgram of global active power 
#  save plot in png format   
   
   
   plot(hpc_dat$Date, hpc_dat$Global_active_power) 
        
   dev.copy(png, file="plot1.png")
   dev.off()   
   
   