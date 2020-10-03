library(data.table)
library(base)

power <- fread("household_power_consumption.txt", sep = ";",
               header = T, stringsAsFactors = F, dec = ".")

power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

power <- as.data.frame(power)

class(power)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

power$Time <- as.ITime(power$Time, "%H:%M:%S")

colNames <- c(3:8)


power[ , colNames] <- apply(power[ , colNames], 2, 
                    function(x) as.numeric(x))

png("plot1.png", width = 480, height = 480)

hist(power$Global_active_power, main = "Global Active Power", breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.off()     