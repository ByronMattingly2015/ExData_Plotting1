# plot3.R - Create (plot3.png) of Global Active Power of Energy submetering vs. time of day

# libraries
library(lubridate)

## 1: Read the data
data <- read.table( "household_power_consumption.txt"
                  , sep = ";"
                  , header = T
                  , stringsAsFactors = F)

## 2: Convert date format
data$Date      <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date <- paste0(data$Date, " " , data$Time)
data$full_date <- as_datetime(data$full_date)

## 3: Only use data from the dates 2007-02-01 and 2007-02-02
plot_data <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

## 4: Convert energy columns of "Global Active Power" to numeric
energy_columns <- grepl("Sub_metering", colnames(plot_data), fixed=F)
plot_data[,energy_columns] <- lapply(selected_dataset[,energy_columns], function(x) {as.numeric(x)})

## 5: Plot Energy submetering vs. time of day
png( filename="plot3.png"
   , width  = 480
   , height = 480)

with( plot_data 
    , plot( Sub_metering_1~full_date
          , type='l'
          , col = "black"
          , xlab = ""
          , ylab="Energy sub metering"
          )
     )

with( plot_data 
    , lines( Sub_metering_2~full_date
           , col = "red"
           , xlab = ""
           , ylab="Energy sub metering"
          )
     )

with( plot_data 
    , lines( Sub_metering_3~full_date
           , col = "blue"
           , xlab = ""
           , ylab="Energy sub metering"
          )
     )

# Add legend to topright
legend( "topright"
        , legend = c(colnames(plot_data[,energy_columns]))
        , col = c("black", "red", "blue")
        , lwd = 1
        , cex = 0.75)

dev.off() # cleanup
