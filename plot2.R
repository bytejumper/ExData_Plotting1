plot2 <- function(){
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
    
    plot(data$Date, data$Global_active_power, xlab = "", 
         ylab = "Global Active Power (kilowatts)", type = "l")
    dev.copy(png, file = "Exploratory Data Analysis/plot2.png", width = 480,
             height = 480)
    dev.off()
}
