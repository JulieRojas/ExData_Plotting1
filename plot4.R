library(tidyr)
library(lubridate)
# Load data
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
# Sub the 2 days we want to analyse
sub <- with(data, data[(Date == "1/2/2007" | Date == "2/2/2007"), ])

sub$DateTime <- strptime(paste(sub$Date, sub$Time), format="%d/%m/%Y %H:%M:%S")
# process the column we need

sub$Global_active_power <- replace_na(sub$Global_active_power, "?")
sub$Global_active_power <- as.numeric(as.character((sub$Global_active_power)))

sub$Global_reactive_power <- replace_na(sub$Global_reactive_power, "?")
sub$Global_reactive_power <- as.numeric(as.character((sub$Global_reactive_power)))

sub$Voltage <- replace_na(sub$Voltage, "?")
sub$Voltage <- as.numeric(as.character((sub$Voltage)))

sub$Sub_metering_1 <- replace_na(sub$Sub_metering_1, "?")
sub$Sub_metering_1 <- as.numeric(as.character((sub$Sub_metering_1)))

sub$Sub_metering_2 <- replace_na(sub$Sub_metering_2, "?")
sub$Sub_metering_2 <- as.numeric(as.character((sub$Sub_metering_2)))

sub$Sub_metering_3 <- replace_na(sub$Sub_metering_3, "?")
sub$Sub_metering_3 <- as.numeric(as.character((sub$Sub_metering_3)))

# Start plotting
png(filename = "plot4.png")

# set the 4 plots format 
par(mfrow = c(2,2))
# First plot
with(sub, plot(DateTime, Global_active_power, type = "l", xlab = "Date - Time", ylab = "Global active power (kilowatts)"))
# Second plot
with(sub, plot(DateTime, Voltage, type = "l", xlab = "Date - Time", ylab = "Voltage"))
# Third plot
with(sub, plot(DateTime,Sub_metering_1, col = "black", type = "l", xlab = "Date - Time", ylab = "Energy Sub metering"))
with(sub, lines(DateTime,Sub_metering_2, col = "red", type = "l"))
with(sub, lines(DateTime,Sub_metering_3, col = "blue", type = "l"))
legend("topright", legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col=c("black", "red", "blue"), lty=1)
# Fourth plot 
with(sub, plot(DateTime, Global_reactive_power, type = "l", xlab = "Date - Time", ylab = "Global reactive power"))
dev.off()