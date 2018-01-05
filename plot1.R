ecd_p1 <- function() {
        
library(data.table)
        
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        destination <- "C:/Users/Chris/Desktop/Data Science/Data/epc.zip"
        
        if (!file.exists(destination)) {
                print("downloading file...")
                download.file(url, destfile=destination, mode="wb")
                unzip(destination, exdir="./Data")
        }

        if ((ecp %in% ls())==FALSE) {
                print("reading table and setting classes and date-times...")
                ecp <- read.table("Data/household_power_consumption.txt", sep = ";", header=TRUE)
                print("changing date format")
                ecp$Date <- as.Date(ecp$Date, format = "%d/%m/%Y")
                ecp$Global_active_power <- as.numeric(ecp$Global_active_power)
                ecp$Global_reactive_power <- as.numeric(ecp$Global_reactive_power)
                ecp$Voltage <- as.numeric(ecp$Voltage)
                ecp$Global_intensity <- as.numeric(ecp$Global_intensity)
                ecp$Sub_metering_1 <- as.numeric(ecp$Sub_metering_1)
                ecp$Sub_metering_2 <- as.numeric(ecp$Sub_metering_2)
                ecp$Sub_metering_3 <- as.numeric(ecp$Sub_metering_3)
                print("subsetting to dates")
                ecp <<- ecp[ecp$Date == "2007/02/01" | ecp$Date == "2007/02/02",]
                ecp$DateTime <- paste(ecp$Date, ecp$Time)
                ecp$DateTime <- as.POSIXct(ecp$DateTime)
        }
        #Histogram of Global Active Power
        png("plot1.png")
        hist(ecp$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
        dev.off()
        
        
        
}