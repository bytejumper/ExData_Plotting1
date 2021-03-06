plot3 <- function(){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "Exploratory Data Analysis/data/exdata_data_household_power_consumption.zip", 
                  method = "curl")
    dateDownloaded <- date()
    unzip("Exploratory Data Analysis/data/exdata_data_household_power_consumption.zip")
    
    library(data.table)
    data <- fread("Exploratory Data Analysis/data/household_power_consumption.txt")
    data <- rbind(data[data$Date == "1/2/2007",], data[data$Date == "2/2/2007",])
    write.csv(data, "Exploratory Data Analysis/data/household_power_consumption.csv")
    data <- read.csv("Exploratory Data Analysis/data//household_power_consumption.csv")
    data <- data[3:11]
    data$Date <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

    png(file = "Exploratory Data Analysis/plot4.png", width = 480,
             height = 480)
    par(mfrow = c(2,2))
    with(data , {
        plot(Date, Global_active_power, xlab = "", ylab = "Global Active Power",
             type = "l")
        plot(Date, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
        plot(Date, Sub_metering_1, xlab = "",
             ylab = "Energy sub metering", type = "l", col = "black",)
        lines(Date, Sub_metering_2, type = "l", col = "red")
        lines(Date, Sub_metering_3, type = "l", col = "blue")
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               lty = 1, col = c("black","red","blue"))
        plot(Date, Global_reactive_power, xlab = "datetime", type = "l")
    })
    dev.off()
}
