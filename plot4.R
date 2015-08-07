#install.packages('sqldf')

library(sqldf)

# Set directory to current folder
setwd("/Users/Sri/Documents/Workspace/Coursera/exploratory_data_analysis/ExData_Plotting1")

input <- read.csv.sql("./household_power_consumption.txt", 
                      sql = "select * from file where Date IN( '2/2/2007',  '2/1/2007') ", eol = "\n", sep =";")
input$Date <- as.Date(input$Date, format ="%m/%d/%Y")
input$DateTime <- paste(input$Date, input$Time ,sep = " ")
input$DateTime <- as.POSIXct(strptime(input$DateTime, "%Y-%m-%d %H:%M:%S"))

# Split the screen into 4
par(mfrow = c(2,2))

# Chart 1
plot(input$DateTime,
     input$Global_active_power, 
     type = "l",
     xlab ="",
     ylab = "Global Activity Power (kilowatts)")
# Chart 2
plot(input$DateTime,
     input$Voltage, 
     type = "l",
     xlab ="datetime",
     ylab = "Voltage")
# Chart 3
height_of_chart <- max(c(max(input$Sub_metering_1), max(input$Sub_metering_2), max(input$Sub_metering_3)))+10

plot(input$DateTime,
     input$Sub_metering_2,
     xlim=c(min(input$DateTime), max(input$DateTime)),
     ylim=c(0, height_of_chart),
     type = "n",
     xlab ="", 
     ylab = "Energy sub metering")
lines(input$DateTime,input$Sub_metering_1,  col = "black",type = "l", xlab ="", ylab = "Energy sub metering")
lines(input$DateTime,input$Sub_metering_2,  col = "red", type = "l",  xlab ="", ylab = "Energy sub metering")
lines(input$DateTime,input$Sub_metering_3,  col = "blue", type = "l", xlab ="", ylab = "Energy sub metering")

#legend("topright",pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Chart 4
plot(input$DateTime,
     input$Global_reactive_power, 
     type = "l",
     xlab ="datetime",
     ylab = "Global_reactive_power")

# Save result to current directory

dev.copy(png, file = "plot4.png")
dev.off()
