# I read the data that I already sub-set in the previous plot

data <- read.table("household_power_consumption_subset.txt", header = T, sep = ";", na.strings="?")

Sys.setlocale("LC_TIME", "C")    # This line is needed so my system (a Spanish computer) wont' interfere and give the weekdays names in Spanish.

# I open the png device so I can adjust the dimensions of the graph. If I don't do this, the export from the screen device does not print the legend properly. 

png(file="plot3.png",width=500,height=450)

# Now I draw the plot for the different Sub-meters. Each sub-meter readings correspond to a separate data series. I start with the first data series (black line).

plot(data$Sub_metering_1 ~ as.POSIXct(data$datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "Energy sub metering", xlab = "", col = c("black"))

par(new=T)    # This allows drawing a plot on top of the first one. In this plot I won't be drawing the axis titles or lables, so they look smooth enough. 

# Now I draw two extra plots with the two data series (red and blue lines) I want to add. 

plot(data$Sub_metering_2 ~ as.POSIXct(data$datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "", xlab = "", xaxt = "n", yaxt = "n", col = c("red"), ylim = range(data$Sub_metering_1))

par(new=T)
plot(data$Sub_metering_3 ~ as.POSIXct(data$datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "", xlab = "", xaxt = "n", yaxt = "n", col = c("blue"), ylim = range(data$Sub_metering_1))

# Finally, I add a legend. 

legend("topright",colnames(data[7:9]), lty = 1, col = c("black", "red", "blue"))

# And I close the file device. 

dev.off()