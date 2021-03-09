########1#########2#########3#########4#########5#########6#########7###########
#                                                                              #
#  plot1.R (03/8/2021)                                                         #
#                                                                              #
#  This program creates plot #1 for the EDA Assignment #1.                     #
#                                                                              #
#########1#########2#########3#########4#########5#########6#########7##########


#  read in household power consuption data
# keep only observations for 2007-02-01 and 2007-02-02

   hpc_dat <- read.table("data/household_power_consumption.txt", sep=";", 
                      stringsAsFactors=FALSE, header=TRUE)
   
   head(hpc_dat)
   names(hpc_dat)
   
#  convert selected varialbes to numeric format   
   
   hpc_dat$Global_active_power   <- as.numeric(hpc_dat$Global_active_power)
   hpc_dat$Global_reactive_power <- as.numeric(hpc_dat$Global_reactive_power)
   hpc_dat$Voltage               <- as.numeric(hpc_dat$Voltage)
   hpc_dat$Global_intensity      <- as.numeric(hpc_dat$Global_intensity)
   hpc_dat$Sub_metering_1        <- as.numeric(hpc_dat$Sub_metering_1)
   hpc_dat$Sub_metering_2        <- as.numeric(hpc_dat$Sub_metering_2)
   hpc_dat$Sub_metering_3        <- as.numeric(hpc_dat$Sub_metering_3)
   
   summary(hpc_dat)
   
   
#  convert dates and time to character and date classes   
   
   hpc_dat$Date2 <- as.character(hpc_dat$Date)
   hpc_dat$Time2 <- as.character(hpc_dat$Time)
   
   hpc_dat$Date <- as.Date(hpc_dat$Date2, format="%d/%m/%Y")
   

#  extract observations for 2007-02-01 and 2007-02-02   
#  save subseted data for use in future work   
   
   keep1 <- grepl("2007-02-01", hpc_dat$Date, fixed = TRUE)
   keep2 <- grepl("2007-02-02", hpc_dat$Date, fixed = TRUE)
   
   summary(keep1)
   summary(keep2)
   
   keep <-  as.logical(keep1 + keep2)
   
   summary(keep)
   
   hpc_keep <- subset(hpc_dat, subset=keep)
   
   summary(hpc_keep)  
   
   write.table(hpc_keep, file = "data/hpc_keep.txt")
   
   
#  creat 1st plot -- a historgram of global active power 
#  save plot in png format   
   
   hist(hpc_keep$Global_active_power, col = "red", main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)")
   
   dev.copy(png, file="plot1.png")
   dev.off()   
   
   