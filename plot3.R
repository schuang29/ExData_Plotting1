setwd("D:/GitHub/ExData_Plotting1")

# Sourcing the Data
# Define the source and download the file, if not already downloaded
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("Project1.zip")){download.file(fileUrl, destfile = "Project1.zip", mode = "wb")}

# Unzip the file
unzip("Project1.zip")

#Read the table
data <- read.table("household_power_consumption.txt", 
                   header=T, 
                   sep=";", 
                   na.strings="?")
## Create a datetime variable and add to the table
plotData <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(plotData$Date, plotData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
plotData <- cbind(SetTime, plotData)

#Generating the  plot - plots of the metering 
plot(plotData$SetTime, plotData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(plotData$SetTime, plotData$Sub_metering_2, col="red")
lines(plotData$SetTime, plotData$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty="solid")


# Save plot and close the file
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
