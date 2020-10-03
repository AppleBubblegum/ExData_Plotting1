library(data.table)
library(base)

power <- fread("household_power_consumption.txt", sep = ";",
               header = T, stringsAsFactors = F, dec = ".")

power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

power <- as.data.frame(power)

class(power)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

power$Time <- paste(power$Date, power$Time)
power$Time <- as.POSIXct(strptime(power$Time, '%Y-%m-%d %H:%M:%S'))


colNames <- c(3:8)


power[ , colNames] <- apply(power[ , colNames], 2, 
                            function(x) as.numeric(x))

png("plot3.png", width = 480, height = 480)

xlim_min = as.POSIXct(strftime("2007-02-01 00:00:00"))
xlim_max = as.POSIXct(strftime("2007-02-03 00:00:00"))

plot(power$Time,
     power$Sub_metering_1,
     xlim = c(xlim_min, xlim_max),
     type = "l",
     xlab = "",
     ylab = "Energy sub metering"
)

lines(power$Time, power$Sub_metering_2, col = "red")
lines(power$Time, power$Sub_metering_3, col = "blue")

axis.POSIXct(1, at = seq(xlim_min, xlim_max, by = "day"),  format = "%a")

legend("topright",
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'),
       lty = c(1, 1, 1))
dev.off()
