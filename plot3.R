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
png(file="plot3.png",width=480,height=480,res=80)

# Draw a plot
plot(data$DateTime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1, type="l")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")

# Add the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), cex=0.8, lty=1)

# Close the PNG file
dev.off()