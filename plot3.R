# Read the data. Load only the rows that matter. (We have to subset the
# data at some point, and loading only those rows makes the script way
# faster.) First read the column names from the first row ...
col.names <- names(read.table("household_power_consumption.txt",
                              header = TRUE, sep = ";", nrows = 1))
# Then load rows for February 1st and 2nd, 2007 (rows 66638 to 69517).
data <- read.table("household_power_consumption.txt", sep = ";",
                   col.names = col.names, nrows = 2880, skip = 66637)
png("plot3.png")
# Parse the timestamps.
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
# Okay, y is the three submetering columns.
y <- data[paste0("Sub_metering_", 1:3)]
col <- c("black", "red", "blue")
# matplot() can't handle POSIXlt, so prepare an empty plot first,
# getting the axes right ...
plot(rep(datetime, ncol(y)), unlist(y), type = "n", xlab = "",
     ylab = "Energy sub metering")
# Then add all the lines in one go -- it *does* handle POSIXct.
matlines(as.POSIXct(datetime), y, lty = 1, col = col)
legend("topright", names(y), col = col, lty = 1)
# All done!
dev.off()
