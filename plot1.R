# load of packages
library(dplyr)
library(tidyr)

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

png(filename="plot1.png", units="px", width=480, height=480)
hist(filtered$Global_active_power, main="Global Active Power", col ="red", 
     xlab = "Global Active Power (kilowatts)")
dev.off()