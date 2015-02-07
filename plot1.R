library(sqldf)

# Load the data file; use sqldf library to use a SQL statement to subset the data to Feb 1-2, 2007
data <- read.csv.sql(file="household_power_consumption.txt", 
                     sep=";", header=TRUE, 
                     sql="select * from file where Date in ('1/2/2007', '2/2/2007')")

# create a PNG file
png(file="plot1.png",width=480,height=480,res=80)

# Draw a histogram
hist(data$Global_active_power, col="red", main="Global Active Power",
    freq=TRUE, xlab="Global Active Power (kilowatts)")

# Close the PNG file
dev.off()