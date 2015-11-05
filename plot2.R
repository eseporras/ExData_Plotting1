# I read the data that I already sub-set in the previous plot

data <- read.table("household_power_consumption_subset.txt", header = T, sep = ";", na.strings="?")

# Now I draw the plot of global active power vs time (datetime in my subset of data)

Sys.setlocale("LC_TIME", "C") # This line is needed so my system (a Spanish computer) wont' interfere and give the weekdays names in Spanish.

with(data, plot(Global_active_power ~ as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S"), type = "l", ylab = "Global active power (kilowatts)", xlab = ""))

dev.copy(png, file = "plot2.png")
dev.off()
