## Question
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
# Upload a PNG file containing your plot addressing this question.

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
total_emission_per_year_n_type <-  aggregate(baltimore_city_data$Emissions, by= list(baltimore_city_data$year, baltimore_city_data$type), FUN= sum)
names(total_emission_per_year_n_type) <- c("year","type","total_emission")

x_min <- floor(min(total_emission_per_year_n_type$year))
x_max <- ceiling(max(total_emission_per_year_n_type$year))
y_min <- floor(min(total_emission_per_year_n_type$total_emission))
y_max <- ceiling(max(total_emission_per_year_n_type$total_emission))


# Visualising result
library(ggplot2)

png(filename = "plot3.png") 

ggplot(total_emission_per_year_n_type, aes(x=year, y=total_emission, fill=type)) +
  geom_bar(stat = "identity", position=position_dodge())  +
  scale_y_continuous(breaks= seq(1,y_max, by = floor(y_max/10) )) + 
  scale_x_continuous(breaks= total_emission_per_year_n_type$year ) + 
  labs( title = "PM 2.5 emission over years in Baltimore City, Maryland") 

dev.off()
