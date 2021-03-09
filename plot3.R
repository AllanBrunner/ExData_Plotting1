########1#########2#########3#########4#########5#########6#########7###########
#                                                                              #
#  plot3.R (03/8/2021)                                                         #
#                                                                              #
#  This program creates plot #3 for the EDA Assignment #1.                     #
#                                                                              #
#########1#########2#########3#########4#########5#########6#########7##########

   library(ggplot2)
   library(reshape2)     


#  read in household power consuption data
#  create Date-Time variable
#  keep submetering variables and put in long format

   hpc_dat <- read.table("data/hpc_keep.txt", stringsAsFactors=FALSE, header=TRUE)
   
   hpc_dat$Date <- as.Date(hpc_dat$Date2, format="%d/%m/%Y")
   
   hpc_dat$DateTime <- paste0(hpc_dat$Date, "", hpc_dat$Time)
   
   hpc_dat$DateTime<- as.POSIXct(hpc_dat$DateTime, format="%Y-%m-%d %H:%M:%S")
   
   head(hpc_dat)
   summary(hpc_dat)

   names(hpc_dat)
   
   list <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "DateTime") 
   
   hpc_dat <- subset(hpc_dat, select = list)   
      

   hpc_long <- melt(hpc_dat, id.vars = "DateTime")
   
   head(hpc_long, n=100)
   tail(hpc_long, n=100)
   
   
#  creat 3nd plot -- three time-series plots  
#  save plot in png format   
   
   
   ggplot(hpc_long, aes(x = DateTime, y = value,
              col = variable)) +
      geom_line() +
      labs(x="", y="Energy Submettering",
           title="Energy Submetering: Febrary 1-2, 2007")
        
   dev.copy(png, file="plot3.png")
   dev.off()   

   