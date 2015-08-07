#install.packages('sqldf')

library(sqldf)

# Set directory to current folder
setwd("/Users/Sri/Documents/Workspace/Coursera/exploratory_data_analysis/ExData_Plotting1")

# Reading only the two days data
input <- read.csv.sql("./household_power_consumption.txt", 
                      sql = "select * from file where Date IN( '2/2/2007',  '2/1/2007') ", eol = "\n", sep =";")
input$Date <- as.Date(input$Date, format ="%m/%d/%Y")

# Rounding global active power to the floor value
input$Global_active_power_rounded <- floor(input$Global_active_power)

# The chart
barplot(table(input$Global_active_power_rounded), 
        col = "red", 
        xlab = "Global Activity Power (kilowatts)", 
        ylab = "Frequency",
        main = "Global Active Power")

# Save result to current directory

dev.copy(png, file = "plot1.png")
dev.off()
