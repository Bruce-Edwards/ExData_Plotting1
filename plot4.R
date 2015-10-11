# load of packages
library(dplyr)
library(tidyr)

# change language to english
Sys.setlocale(category="LC_TIME", locale="C")

# loading of the file in memory
file <- read.table("household_power_consumption.txt", header=TRUE, sep= ";",
                   na.strings = "?")

# recasting of each column as its proper data type
# as the file consumes a lot of memory, the variable is removed 
# as soon as the step it's used at is finished
file$Date <- as.Date(file$Date, format="%d/%m/%Y")

filtered <- filter(file, file$Date >= as.Date("2007-02-01", format="%Y-%m-%d") 
                   & file$Date <= as.Date("2007-02-02", format="%Y-%m-%d"))

rm("file")

filtered$timetemp <- paste(filtered$Date,filtered$Time)
filtered$Time <- strptime(filtered$timetemp,format="%Y-%m-%d %H:%M:%S")

png(filename="plot4.png", units="px", width=480, height=480)
par(mfrow = c(2,2))
with(filtered, {
        plot(filtered$Time,filtered$Global_active_power, type="l", 
             xlab="", ylab="Global Active Power (kilowatts)")
        plot(filtered$Time,filtered$Voltage, type="l", 
                   xlab="datetime", ylab="Voltage")
        plot(filtered$Time,filtered$Sub_metering_1 , type="l", 
             xlab="", ylab="Energy Sub Metering")
        lines(filtered$Time,filtered$Sub_metering_2, col="red")
        lines(filtered$Time,filtered$Sub_metering_3, col="blue")
        legend("topright", col=c("black","red","blue"), 
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               lty=1)
        plot(filtered$Time,filtered$Global_reactive_power, type="l", 
             xlab="datetime")
})
dev.off()