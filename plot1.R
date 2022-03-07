# plot1.R - Create histogram (plot1.png) of Global Active Power of kilowatts vs. frequencies 

## 1: Read the data
data <- read.table( "household_power_consumption.txt"
                  , sep = ";"
                  , header = T
                  , stringsAsFactors = F)

## 2: Convert date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## 3: Only use data from the dates 2007-02-01 and 2007-02-02
plot_data <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

## 4: Convert column "Global Active Power" to numeric
plot_data$Global_active_power <- as.numeric(plot_data$Global_active_power)

## 5: Plot histogram - Global Active Power of kilowatts vs. frequencies
png( filename="plot1.png"
   , width  = 480
   , height = 480 )
par(las=1)  # set axis labels to horizontal

hist( plot_data$Global_active_power
    , main = "Global Active Power"
    , xlab = "Global Active Power (kilowatts)"
    , ylab = "Frequency"
    , col  = "red")

dev.off() # cleanup
