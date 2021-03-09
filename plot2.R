########1#########2#########3#########4#########5#########6#########7###########
#                                                                              #
#  plot2.R (03/8/2021)                                                         #
#                                                                              #
#  This program creates plot #2 for the EDA Assignment #1.                     #
#                                                                              #
#########1#########2#########3#########4#########5#########6#########7##########

   library(ggplot2)


#  read in household power consuption data

   hpc_dat <- read.table("data/hpc_keep.txt", stringsAsFactors=FALSE, header=TRUE)
   
   hpc_dat$Date <- as.Date(hpc_dat$Date2, format="%d/%m/%Y")
   
   hpc_dat$DateTime <- paste0(hpc_dat$Date, "", hpc_dat$Time)
   
   hpc_dat$DateTime<- as.POSIXct(hpc_dat$DateTime, format="%Y-%m-%d %H:%M:%S")
   
   head(hpc_dat)
   summary(hpc_dat)

   
#  creat 2nd plot -- a time-series plot of of global active power 
#  save plot in png format   
   
   
   ggplot(hpc_dat, aes(x=DateTime, y=Global_active_power)) + 
      geom_line() +
      labs(x="", y="Global Active Power (in kilowatts)",
           title="Global Active Power: Febrary 1-2, 2007")
        
   dev.copy(png, file="plot2.png")
   dev.off()   
   
   