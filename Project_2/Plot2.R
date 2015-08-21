## Question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Requirements:
# Please add the input rds data in the folder exdata-data-NEI_data in the current directory


# Set Project directory
setwd("/Users/Sri/Documents/Workspace/Research/exploratory_data_analysis/ExData_Plotting1/Project_2/")

# Load data set to be analysed
NEI <- readRDS( "./exdata-data-NEI_data/summarySCC_PM25.rds" )
#SCC <- readRDS( "./exdata-data-NEI_data/Source_Classification_Code.rds")

# Filter data for  Baltimore city
baltimore_city_data <- subset(NEI, NEI$fips == 24510)

# Analyse data
total_emission_per_year <- aggregate(baltimore_city_data$Emissions, by=list(Category=baltimore_city_data$year), FUN=sum)
total_emission_per_year$x <-  total_emission_per_year$x 
names(total_emission_per_year) <- c("year","total_emission")
y_min <- floor(min(total_emission_per_year$`total_emission`))
y_max <- ceiling(max(total_emission_per_year$`total_emission`))

# Visualising result
png(filename = "plot2.png") 
plot(total_emission_per_year, type = "n", main = "PM 2.5 emission over years in Baltimore City, Maryland", col = "red", ylim=c(y_min, y_max))
lines(total_emission_per_year, type = "b", col = "red")
dev.off()
