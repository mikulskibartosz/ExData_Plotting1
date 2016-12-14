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

png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

hist(
  dataWithinTimeRange$Global_active_power,
  col = "red",
  xlab = "Global active power (kilowatts)",
  main = "Global active power"
)

dev.off()
