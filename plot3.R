#Load in necessary libraries
library(dplyr)
library(data.table)

#Reads in data from file then subsets data for specified dates
fh <- fread("~/Exploratory Data Course/household_power_consumption.txt", na.strings="?",stringsAsFactors = FALSE)
pwrcons <- filter(fh, grep("^[1,2]/2/2007", Date))

#Convert global active power column, global reactive power colums, Sub_metering columns, and the Voltage column to numeric
pwrcons$Global_active_power <- as.numeric(as.character(pwrcons$Global_active_power))

pwrcons$Global_reactive_power <- as.numeric(as.character(pwrcons$Global_reactive_power))

pwrcons$Sub_metering_1 <- as.numeric(as.character(pwrcons$Sub_metering_1))
pwrcons$Sub_metering_2 <- as.numeric(as.character(pwrcons$Sub_metering_2))
pwrcons$Sub_metering_3 <- as.numeric(as.character(pwrcons$Sub_metering_3))

pwrcons$Voltage <- as.numeric(as.character(pwrcons$Voltage))

#Creates new column that combines date and time data 
pwrcons$Timestamp <-paste(pwrcons$Date, pwrcons$Time)


Creates plot of date/time v Sub metering 1 data
plot(strptime(pwrcons$Timestamp, "%d/%m/%Y %H:%M:%S"), pwrcons$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Adds line graph for date/time v Sub metering 2 data in red
lines(strptime(pwrcons$Timestamp, "%d/%m/%Y %H:%M:%S"), pwrcons$Sub_metering_2, type = "l", col = "red" )

#Adds line graph for date/time v Sub metering 3 data in blue
lines(strptime(pwrcons$Timestamp, "%d/%m/%Y %H:%M:%S"), pwrcons$Sub_metering_3, type = "l", col = "blue" )

#Adds legend to graph
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
