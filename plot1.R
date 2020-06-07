library(tidyr)
# Load data
data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
# format dates
data$Date <- as.Date(strptime(data$Date, format = "%d/%m/%Y"))
# Sub the 2 days we want to analyse
sub <- with(data, data[(Date == "2007-02-01" | Date == "2008-02-02"), ])
# process the column we need
sub$Global_active_power <- replace_na(sub$Global_active_power, "?")
sub$Global_active_power <- as.numeric(as.character((sub$Global_active_power)))

#Construct the plot and save it to a PNG file
#with a width of 480 pixels and a height of 480 pixels (that's the default for png)
png(filename = "plot1.png")
hist(sub$Global_active_power, col = "red", xlab = "Global active power (kilowatts)", main = "Global active power")
dev.off()