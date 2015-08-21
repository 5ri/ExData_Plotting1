## Question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# Upload a PNG file containing your plot addressing this question.

# Requirements:
# Please add the input rds data in the folder exdata-data-NEI_data in the current directory

# Set Project directory
setwd("/Users/Sri/Documents/Workspace/Research/exploratory_data_analysis/ExData_Plotting1/Project_2/")

# Load data set to be analysed
NEI <- readRDS( "./exdata-data-NEI_data/summarySCC_PM25.rds" )
#SCC <- readRDS( "./exdata-data-NEI_data/Source_Classification_Code.rds")

# Analyse data
total_emission_per_year <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)
total_emission_per_year$x <-  total_emission_per_year$x / 1000000
names(total_emission_per_year) <- c("year","total_emission ( in Millions)")
y_min <- floor(min(total_emission_per_year$`total_emission ( in Millions)`))
y_max <- ceiling(max(total_emission_per_year$`total_emission ( in Millions)`))

# Visualise result
png(filename = "plot1.png") 
plot(total_emission_per_year, type = "n", main = "PM 2.5emission over years", col = "red", ylim=c(y_min, y_max))
lines(total_emission_per_year, type = "b", col = "red")
dev.off()
