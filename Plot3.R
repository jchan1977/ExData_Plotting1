#Course assignment R script for Johns Hopkins' Coursera "Exploratory Data Analysis" course  
#June 2014
#This script downloads a zipped data set and outputs a plot


#READ DATA

#create a data folder if necessary
if(!file.exists("./data")){dir.create("./data")}

#Download and unzip the data to the data folder
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/exdata_data_household_power_consumption.zip")
unzip("./data/exdata_data_household_power_consumption.zip", exdir = "./data")

#Read data and subset by dates 2007-02-01 and 2007-02-02
dataset<-read.table("./data/household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)
slim_dataset<-subset(dataset, dataset$Date=='1/2/2007' | dataset$Date=='2/2/2007')

#Merge Date and Time columns and convert to Date/Time classes
slim_dataset$datetime<-paste(slim_dataset$Date, slim_dataset$Time)
slim_dataset$datetime<-strptime(slim_dataset$datetime, "%d/%m/%Y %H:%M:%S")

#CREATE PLOT

#Plot 3 
png(file = "plot3.png", width = 480, height = 480)
par(mfcol = c(1, 1))
with(slim_dataset, plot(datetime, Sub_metering_1, type="n",  xlab='', ylab='Energy sub metering'))
lines(slim_dataset$datetime, slim_dataset$Sub_metering_1, type="l", col='black')
lines(slim_dataset$datetime, slim_dataset$Sub_metering_2, type="l", col='red')
lines(slim_dataset$datetime, slim_dataset$Sub_metering_3, type="l", col='blue')
legend("topright", lwd=2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()


