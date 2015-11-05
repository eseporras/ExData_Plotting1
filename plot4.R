# I read the data that I already sub-set in the previous plot

data <- read.table("household_power_consumption_subset.txt", header = T, sep = ";", na.strings="?")

Sys.setlocale("LC_TIME", "C")    # This line is needed so my system (a Spanish computer) won't interfere and give the weekdays names in Spanish.

# I open the file device to be able to adjust the dimensions, since the export from screen device does not print the legend properly. 

png(file="plot4.png",width=500,height=500)

# I set par to draw 4 plots in 2 rows, 2 columns. 

par(mfrow=c(2,2))

# Now I draw the first plot, which is the same as in plot2.

with(data, plot(Global_active_power ~ as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "Global active power (kilowatts)", xlab = ""))

# The second plot is a representation of voltage vs time.

with(data, plot(Voltage ~ as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", xlab = "datetime"))

# Then the third plot, which is the same as plot3

plot(data$Sub_metering_1 ~ as.POSIXct(data$datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "Energy sub metering", xlab = "", col = c("black"))

par(new=T)  
plot(data$Sub_metering_2 ~ as.POSIXct(data$datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "", xlab = "", xaxt = "n", yaxt = "n", col = c("red"), ylim = range(data$Sub_metering_1))

par(new=T)
plot(data$Sub_metering_3 ~ as.POSIXct(data$datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "", xlab = "", xaxt = "n", yaxt = "n", col = c("blue"), ylim = range(data$Sub_metering_1))

legend("topright",colnames(data[7:9]), lty = 1, bty = "n", col = c("black", "red", "blue"))

# And the final one, a representation of Global_reactive_time vs time. 

with(data, plot(Global_reactive_power ~ as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", xlab = "datetime"))

dev.off()
