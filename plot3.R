#install.packages('sqldf')

library(sqldf)

# Set directory to current folder
setwd("/Users/Sri/Documents/Workspace/Coursera/exploratory_data_analysis/ExData_Plotting1")

input <- read.csv.sql("./household_power_consumption.txt", 
                      sql = "select * from file where Date IN( '2/2/2007',  '2/1/2007') ", eol = "\n", sep =";")
input$Date <- as.Date(input$Date, format ="%m/%d/%Y")
input$DateTime <- paste(input$Date, input$Time ,sep = " ")
input$DateTime <- as.POSIXct(strptime(input$DateTime, "%Y-%m-%d %H:%M:%S"))

# determine the height of the chart to avoid wrighting over the result
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

legend("topright",pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Save result to current directory

dev.copy(png, file = "plot3.png")
dev.off()
