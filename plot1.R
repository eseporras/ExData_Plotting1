############    Section 1: reading and sub-setting the data    ########

# First I read in the data. To speed things up, I read a small sample and fetch the colCLasses from there. That will make importing the full dataset much faster. 

sample <- read.table("household_power_consumption.txt", nrows = 100, header = T, sep = ";", na.strings="?")

classes <- sapply(sample, class)

rm(sample)   # I remove the sample data since I do not need it anymore. 

full_table <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = classes, na.strings = "?")

# Once I've read the full dataset, I paste the "Date" and "Time" fields together into a new field "datetime" and I covert it to full date format using strptime, so I can make use of it for subsetting later. 

full_table$datetime <- paste(full_table$Date, full_table$Time, sep = " ")

full_table$datetime <- strptime(full_table$datetime, format = "%d/%m/%Y %H:%M:%S")

# Now I just subset the data for the dates I need and remove the full dataset to save memory. I'll use "data" for now on. I write it as a file so it can be loaded by further plots as well, so the code for them is a bit faster. 

data <- subset(full_table, full_table$Date == "1/2/2007" | full_table$Date == "2/2/2007")

rm(full_table)

write.table(data, "household_power_consumption_subset.txt", row.names = F, col.names = T, sep = ";", quote = F)

############    Section 2: drawing the plot    ##########

# The first plot is a simple histogram for the Global_active_power column. 

with(data, hist(Global_active_power, col = "red", xlab = "Global active power (kilowatts)", main = "Global active power"))

dev.copy(png, file = "plot1.png")
dev.off()
