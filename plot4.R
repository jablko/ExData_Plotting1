# Read the data. Load only the rows that matter. (We have to subset the
# data at some point, and loading only those rows makes the script way
# faster.) First read the column names from the first row ...
col.names <- names(read.table("household_power_consumption.txt",
                              header = TRUE, sep = ";", nrows = 1))
# Then load rows for February 1st and 2nd, 2007 (rows 66638 to 69517).
data <- read.table("household_power_consumption.txt", sep = ";",
                   col.names = col.names, nrows = 2880, skip = 66637)
png("plot4.png")
par(mfcol = c(2, 2))
# Parse the timestamps.
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
y <- data$Global_active_power
plot(datetime, y, type = "l", xlab = "",
     ylab = "Global Active Power")
# Okay, y is the three submetering columns.
y <- data[paste0("Sub_metering_", 1:3)]
col <- c("black", "red", "blue")
# matplot() can't handle POSIXlt, so prepare an empty plot first,
# getting the axes right ...
plot(rep(datetime, ncol(y)), unlist(y), type = "n", xlab = "",
     ylab = "Energy sub metering")
# Then add all the lines in one go -- it *does* handle POSIXct.
matlines(as.POSIXct(datetime), y, lty = 1, col = col)
legend("topright", names(y), col = col, lty = 1, bty = "n")
# Last two plots ... Use with() to label the axes straight from the
# column names.
with(data, {
  plot(datetime, Voltage, type = "l")
  plot(datetime, Global_reactive_power, type = "l")
})
# All done!
dev.off()
