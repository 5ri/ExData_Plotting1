## Question
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Upload a PNG file containing your plot addressing this question.

# Requirements:
# Please add the input rds data in the folder exdata-data-NEI_data in the current directory


# Set Project directory
setwd("/Users/Sri/Documents/Workspace/Research/exploratory_data_analysis/ExData_Plotting1/Project_2/")

# Load data set to be analysed
NEI <- readRDS( "./exdata-data-NEI_data/summarySCC_PM25.rds" )
SCC <- readRDS( "./exdata-data-NEI_data/Source_Classification_Code.rds")

# Filter data for  Baltimore city
baltimore_city_data <- subset(NEI, NEI$fips == 24510)

# Emisson sources in Baltimore city
sources_data <- SCC[ which( SCC[,"SCC"] %in% unique(baltimore_city_data$SCC) ),]

# Filter data for Vehicle cumbustion related sources ( in Baltimore)
source_names <- tolower(sources_data$"EI.Sector")
vehicle_sources_index <- grepl( "vehicles", source_names )
vehicle_sources <- sources_data[ which(vehicle_sources_index),]

baltimore_vehicle_sources_emission_data <- subset(NEI, NEI$SCC %in% unique(vehicle_sources$SCC))


# Analyse data
total_emission_per_year <-  aggregate(baltimore_vehicle_sources_emission_data$Emissions, by= list(baltimore_vehicle_sources_emission_data$year), FUN= sum)
names(total_emission_per_year) <- c("year","total_emission")

x_min <- floor(min(total_emission_per_year$year))
x_max <- ceiling(max(total_emission_per_year$year))
y_min <- floor(min(total_emission_per_year$total_emission))
y_max <- ceiling(max(total_emission_per_year$total_emission))


# Visualising result
library(ggplot2)

png(filename = "plot5.png") 

ggplot(total_emission_per_year, aes(x=year, y=total_emission, width=.5, fill=total_emission)) +
  geom_bar(stat = "identity", position=position_dodge())  +
  scale_y_continuous(breaks= seq(1,y_max, by = floor(y_max/10) )) + 
  scale_x_continuous(breaks= total_emission_per_year$year ) + 
  labs( title = "PM 2.5 emission over years from vehicle sources in Baltimore City, Maryland") 

dev.off()
