#install.packages('sqldf')

library(sqldf)

# Set directory to current folder
setwd("/Users/Sri/Documents/Workspace/Coursera/exploratory_data_analysis/ExData_Plotting1")

input <- read.csv.sql("../household_power_consumption.txt", 
                      sql = "select * from file where Date IN( '2/2/2007',  '2/1/2007') ", eol = "\n", sep =";")
input$Date <- as.Date(input$Date, format ="%m/%d/%Y")
input$DateTime <- paste(input$Date, input$Time ,sep = " ")
input$DateTime <- as.POSIXct(strptime(input$DateTime, "%Y-%m-%d %H:%M:%S"))


plot(input$DateTime,
     input$Global_active_power, 
     type = "l",
     xlab ="",
     ylab = "Global Activity Power (kilowatts)"
     )

# Save result to current directory

dev.copy(png, file = "plot2.png")
dev.off()
