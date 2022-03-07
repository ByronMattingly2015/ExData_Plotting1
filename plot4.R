## plot4.R - Create (plot4.png) of
## 1) Global Active Power   vs. time of day
## 2) Voltage               vs. time of day
## 3) Energy submetering    vs. time of day
## 4) Global Reactive Power vs. time of day

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

## 4: Convert energy columns of "Global Active Power", "Global Rective Power", "Voltage"  to numeric
energy_columns <- grepl("Sub_metering", colnames(plot_data), fixed=F)
power_columns  <- grepl("Sub_metering", colnames(plot_data), fixed=F)

plot_data[,energy_columns] <- lapply(plot_data[,energy_columns], function(x) {as.numeric(x)})
plot_data[,power_columns]  <- lapply(plot_data[,power_columns],  function(x) {as.numeric(x)})
plot_data$Voltage <- as.numeric(plot_data$Voltage)

## 5: Create 4 plots in 2 rows and 2 columns
png( filename="plot4.png"
   , width  = 480
   , height = 480)
par(mfrow=c(2,2))

# P1 - Global Active power vs. time of day
with( plot_data 
    , plot( Global_active_power~full_date
          , type='l'
          , xlab = ""
          , ylab="Global Active Power (kilowatts)"
          )
    )


# P2 - Voltage vs. time of day
with( plot_data
    , plot( Voltage~full_date
          , type='l'
          , xlab = "datetime"))


# P3 - Energy submetering vs. time of day
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

# P4 - Global Reactive power vs. time of day
with( plot_data 
    , plot( Global_reactive_power~full_date
          , type='l'
          , xlab = ""
          , ylab="Global Active Power (kilowatts)"
          )
    )

dev.off() # cleanup
