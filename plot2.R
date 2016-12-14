Sys.setlocale("LC_MESSAGES", 'en_GB.UTF-8')
Sys.setlocale("LC_TIME", 'en_GB.UTF-8')
Sys.setenv(LANG = "en_US.UTF-8")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power_consumption.zip", method = "curl")
unzip("power_consumption.zip")

data <- read.table(
  file = "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
)

dataWithinTimeRange <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
dataWithinTimeRange$DateTime <- strptime(paste(dataWithinTimeRange$Date, dataWithinTimeRange$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

plot(
  dataWithinTimeRange$DateTime, dataWithinTimeRange$Global_active_power,
  main = "",
  ylab = "Global active power (kilowatts)",
  xlab = "",
  type = "lines"
)

dev.off()
