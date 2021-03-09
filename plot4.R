########1#########2#########3#########4#########5#########6#########7###########
#                                                                              #
#  plot4.R (03/8/2021)                                                         #
#                                                                              #
#  This program creates plot #4 for the EDA Assignment #1.                     #
#                                                                              #
#########1#########2#########3#########4#########5#########6#########7##########

   library(ggplot2)


#  read in household power consuption data
#  create Date-Time variable

   hpc_dat <- read.table("data/hpc_keep.txt", stringsAsFactors=FALSE, header=TRUE)
   
   hpc_dat$Date <- as.Date(hpc_dat$Date2, format="%d/%m/%Y")
   
   hpc_dat$DateTime <- paste0(hpc_dat$Date, "", hpc_dat$Time)
   
   hpc_dat$DateTime<- as.POSIXct(hpc_dat$DateTime, format="%Y-%m-%d %H:%M:%S")
   
   head(hpc_dat)
   summary(hpc_dat)

   
#  creat 4th plot -- four-panel plot  

#  plot #1
   
   p1 <- ggplot(hpc_dat, aes(x=DateTime, y=Global_active_power)) + 
         geom_line() +
         labs(x="", y="Global Active Power (in kilowatts)",
           title="Global Active Power: Febrary 1-2, 2007")
   
   
#  plot #2
   
   p2 <- ggplot(hpc_dat, aes(x=DateTime, y=Voltage)) + 
         geom_line() +
         labs(x="", y="Voltage",
           title="Voltage: Febrary 1-2, 2007")
   
   
#  plot #3
   
   p3 <- ggplot(hpc_long, aes(x = DateTime, y = value,
              col = variable)) +
         geom_line() +
         labs(x="", y="Energy Submettering",
           title="Energy Submetering: Febrary 1-2, 2007")

#  plot #4
   
   p4 <- ggplot(hpc_dat, aes(x=DateTime, y=Global_reactive_power)) + 
         geom_line() +
         labs(x="", y="Global Reactive Power (in kilowatts)",
           title="Global Rective Power: Febrary 1-2, 2007")
   
   
#  create 4-panel graph using multi-plot function 
#  plot #3
   
   multiplot(p1, p3, p2, p4, cols=2)

   dev.copy(png, file="plot4.png")
   dev.off()   
   
-------------------------------------------------------------------

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
      
      
   multiplot <- function(...,
               plotlist = NULL,
               file,
               cols = 1,
               layout = NULL) {
         library(grid)
         
         # Make a list from the ... arguments and plotlist
         plots <- c(list(...), plotlist)
         
         numPlots = length(plots)
         
         # If layout is NULL, then use 'cols' to determine layout
         if (is.null(layout)) {
            # Make the panel
            # ncol: Number of columns of plots
            # nrow: Number of rows needed, calculated from # of cols
            layout <- matrix(seq(1, cols * ceiling(numPlots / cols)),
                             ncol = cols,
                             nrow = ceiling(numPlots / cols))
         }
         
         if (numPlots == 1) {
            print(plots[[1]])
            
         } else {
            # Set up the page
            grid.newpage()
            pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
            
            # Make each plot, in the correct location
            for (i in 1:numPlots) {
               # Get the i,j matrix positions of the regions that contain this subplot
               matchidx <-
                  as.data.frame(which(layout == i, arr.ind = TRUE))
               
               print(plots[[i]],
                     vp = viewport(
                        layout.pos.row = matchidx$row,
                        layout.pos.col = matchidx$col
                     ))
            }
         }
      }
   