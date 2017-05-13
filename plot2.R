# Read the data. Load only the rows that matter. (We have to subset the
# data at some point, and loading only those rows makes the script way
# faster.) First read the column names from the first row ...
col.names <- names(read.table("household_power_consumption.txt",
                              header = TRUE, sep = ";", nrows = 1))
# Then load rows for February 1st and 2nd, 2007 (rows 66638 to 69517).
data <- read.table("household_power_consumption.txt", sep = ";",
                   col.names = col.names, nrows = 2880, skip = 66637)
png("plot2.png")
# Parse the timestamps.
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
y <- data$Global_active_power
plot(datetime, y, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
# All done!
dev.off()
