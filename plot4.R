ecd_p4 <- function() {
        
        # check to see if the df is in the global environment.  if not, check to see if zip file is present and 
        # if not, download and unzip.  finally, set up the df.  
        if (!exists("ecp")) {
                if (!file.exists("./Data/epc.zip")) {
                        print("downloading file...")
                        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                        destination <- "C:/Users/Chris/Desktop/Data Science/Data/epc.zip"
                        download.file(url, destfile=destination, mode="wb")
                        unzip(destination, exdir="./Data")
                }
                print("reading table and cleaning dataframe...")
                ecp <- read.table("Data/household_power_consumption.txt", sep = ";", header=TRUE, 
                                  colClasses="character")
                ecp$Date <- as.Date(ecp$Date, format = "%d/%m/%Y")
                ecp <- ecp[ecp$Date == "2007/02/01" | ecp$Date == "2007/02/02",]
                ecp$Global_active_power <- as.numeric(ecp$Global_active_power)
                ecp$Global_reactive_power <- as.numeric(ecp$Global_reactive_power)
                ecp$Voltage <- as.numeric(ecp$Voltage)
                ecp$Global_intensity <- as.numeric(ecp$Global_intensity)
                ecp$Sub_metering_1 <- as.numeric(ecp$Sub_metering_1)
                ecp$Sub_metering_2 <- as.numeric(ecp$Sub_metering_2)
                ecp$Sub_metering_3 <- as.numeric(ecp$Sub_metering_3)
                ecp$DateTime <- as.POSIXct(paste(ecp$Date, ecp$Time))
                ecp <<- ecp
        }
        
        # Four Plots
        png("plot4.png")
        par(mfrow=c(2,2))
        with(ecp, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)",xlab=""))
        
        with(ecp, plot(DateTime, Voltage, type="l", xlab=""))
        
        with(ecp, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering",xlab=""))
        with(ecp, lines(DateTime, Sub_metering_2, col="red"))
        with(ecp, lines(DateTime, Sub_metering_3, col="blue"))
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
               col=c("black", "red", "blue"), lty=c(1,1))
        
        with(ecp, plot(DateTime, Global_reactive_power, type="l", ylab="Global Reactive Power", xlab=""))
        dev.off()
}