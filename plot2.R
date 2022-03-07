# plot2.R - Create (plot2.png) of Global Active Power of kilowatts vs. weekdays

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

## 4: Convert column "Global Active Power" to numeric
plot_data$Global_active_power <- as.numeric(plot_data$Global_active_power)

## 5: Plot Global Active Power of kilowatts vs. Weekdays
png( filename="plot2.png"
   , width  = 480
   , height = 480)

with( plot_data 
    , plot( Global_active_power~full_date
          , type='l'
          , xlab = ""
          , ylab="Global Active Power (kilowatts)"
          )
    )

dev.off() # cleanup
