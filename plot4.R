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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
#Global Active Power over time
plot(plotData$Global_active_power~plotData$SetTime, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")
#Voltage over time
plot(plotData$Voltage~plotData$SetTime, 
     type="l", 
     ylab="Voltage", 
     xlab="datetime")
#Submetering over time
plot(plotData$SetTime, plotData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(plotData$SetTime, plotData$Sub_metering_2, col="red")
lines(plotData$SetTime, plotData$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"),
       lty=1, 
       lwd=1,
       bty = "n")
#Voltage over time
plot(plotData$Global_reactive_power~plotData$SetTime, 
    type="l", 
    ylab="Global_reactive_power", 
    xlab="datetime")       

# Save plot and close the file
dev.copy(png,"figure/plot4.png", width=480, height=480)
dev.off()
