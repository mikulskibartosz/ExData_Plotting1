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

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

par(mfrow=c(2,2))

# First plot
plot(
  dataWithinTimeRange$DateTime, dataWithinTimeRange$Global_active_power,
  main = "",
  ylab = "Global active power (kilowatts)",
  xlab = "",
  type = "lines"
)

# Second plot
plot(
  dataWithinTimeRange$DateTime, dataWithinTimeRange$Voltage,
  main = "",
  ylab = "Voltage",
  xlab = "datetime",
  type = "lines"
)

# Third plot
plot(
  dataWithinTimeRange$DateTime, dataWithinTimeRange$Sub_metering_1,
  main = "",
  ylab = "Energy sub metering",
  xlab = "",
  type = "n"
)
lines(dataWithinTimeRange$DateTime, dataWithinTimeRange$Sub_metering_1, col = "black")
lines(dataWithinTimeRange$DateTime, dataWithinTimeRange$Sub_metering_2, col = "red")
lines(dataWithinTimeRange$DateTime, dataWithinTimeRange$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Forth plot
plot(
  dataWithinTimeRange$DateTime, dataWithinTimeRange$Global_reactive_power,
  main = "",
  ylab = "Global_reactive_power",
  xlab = "datetime",
  type = "lines"
)

dev.off()
