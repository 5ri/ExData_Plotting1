## Question
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?
# Upload a PNG file containing your plot addressing this question.

# Requirements:
# Please add the input rds data in the folder exdata-data-NEI_data in the current directory


# Set Project directory
setwd("/Users/Sri/Documents/Workspace/Research/exploratory_data_analysis/ExData_Plotting1/Project_2/")

# Load data set to be analysed
NEI <- readRDS( "./exdata-data-NEI_data/summarySCC_PM25.rds" )
SCC <- readRDS( "./exdata-data-NEI_data/Source_Classification_Code.rds")

## City data:

# Baltimore city
baltimore_city_data <- subset(NEI, NEI$fips == 24510)
dim(baltimore_city_data)

#Los Angeles city
las_anglese_data <- subset(NEI, NEI$fips == 06037)
dim(las_anglese_data)
