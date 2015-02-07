library(sqldf)
library(lubridate)

# Load the data file; use sqldf library to use a SQL statement to subset the data to Feb 1-2, 2007
data <- read.csv.sql(file="household_power_consumption.txt", 
                     sep=";", header=TRUE, 
                     sql="select * from file where Date in ('1/2/2007', '2/2/2007')")

# Create new combined DateTime column
data$DateTime <- paste(data$Date, data$Time, sep=" ")

# Convert the DateTime column to a date type
data$DateTime <- dmy_hms(data$DateTime)

# create a PNG file
png(file="plot4.png",width=480,height=480,res=80)

# Specify that we want two rows and two columns of plots
par(mfrow=c(2,2))

# Draw the top left plot, Global active power
plot(data$DateTime, data$Global_active_power, type="n", xlab="",
     ylab="Global Active Power")
lines(data$DateTime, data$Global_active_power, type="l")

# Draw the top right plot, voltage
plot(data$DateTime, data$Voltage, type="n", xlab="datetime",
     ylab="Voltage")
lines(data$DateTime, data$Voltage, type="l")

# Draw the bottom left plot, Energy sub metering
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1, type="l")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
# bty="n" removes the box around the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), cex=0.8, lty=1, bty="n")

# Draw the bottom right plot, Global_reactive_power
plot(data$DateTime, data$Global_reactive_power, type="n", xlab="datetime",
     ylab="Global_reactive_power")
lines(data$DateTime, data$Global_reactive_power, type="l")

# Close the PNG file
dev.off()