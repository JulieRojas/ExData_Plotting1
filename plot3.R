library(tidyr)
library(lubridate)
# Load data
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
# Sub the 2 days we want to analyse
sub <- with(data, data[(Date == "1/2/2007" | Date == "2/2/2007"), ])

sub$DateTime <- strptime(paste(sub$Date, sub$Time), format="%d/%m/%Y %H:%M:%S")
# process the column we need
sub$Sub_metering_1 <- replace_na(sub$Sub_metering_1, "?")
sub$Sub_metering_1 <- as.numeric(as.character((sub$Sub_metering_1)))

sub$Sub_metering_2 <- replace_na(sub$Sub_metering_2, "?")
sub$Sub_metering_2 <- as.numeric(as.character((sub$Sub_metering_2)))

sub$Sub_metering_3 <- replace_na(sub$Sub_metering_3, "?")
sub$Sub_metering_3 <- as.numeric(as.character((sub$Sub_metering_3)))
#Construct the plot and save it to a PNG file
#with a width of 480 pixels and a height of 480 pixels (that's the default for png)
png(filename = "plot3.png")
with(sub, plot(DateTime,Sub_metering_1, col = "black", type = "l", xlab = "Date - Time", ylab = "Energy Sub metering"))
with(sub, lines(DateTime,Sub_metering_2, col = "red", type = "l"))
with(sub, lines(DateTime,Sub_metering_3, col = "blue", type = "l"))
legend("topright", legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col=c("black", "red", "blue"), lty=1)
dev.off()