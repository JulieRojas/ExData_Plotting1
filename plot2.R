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

#Construct the plot and save it to a PNG file
#with a width of 480 pixels and a height of 480 pixels (that's the default for png)
png(filename = "plot2.png")
with(sub, plot(DateTime, Global_active_power, type = "l", xlab = "Date - Time", ylab = "Global active power (kilowatts)"))
dev.off()