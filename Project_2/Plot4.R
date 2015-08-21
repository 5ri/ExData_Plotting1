## Question
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Upload a PNG file containing your plot addressing this question.

# Requirements:
# Please add the input rds data in the folder exdata-data-NEI_data in the current directory


# Set Project directory
setwd("/Users/Sri/Documents/Workspace/Research/exploratory_data_analysis/ExData_Plotting1/Project_2/")

# Load data set to be analysed
NEI <- readRDS( "./exdata-data-NEI_data/summarySCC_PM25.rds" )
SCC <- readRDS( "./exdata-data-NEI_data/Source_Classification_Code.rds")

# Filter data for Coal cumbustion related sources
source_names <- tolower(SCC$"EI.Sector")
coal_sources_index <- grepl( "coal", source_names )
coal_sources <- SCC[ which(coal_sources_index),]

coal_sources_emission_data <- subset(NEI, NEI$SCC %in% unique(coal_sources$SCC))


# Analyse data
total_emission_per_year <-  aggregate(coal_sources_emission_data$Emissions, by= list(coal_sources_emission_data$year), FUN= sum)
names(total_emission_per_year) <- c("year","total_emission")

x_min <- floor(min(total_emission_per_year$year))
x_max <- ceiling(max(total_emission_per_year$year))
y_min <- floor(min(total_emission_per_year$total_emission))
y_max <- ceiling(max(total_emission_per_year$total_emission))


# Visualising result
library(ggplot2)

png(filename = "plot4.png") 

ggplot(total_emission_per_year, aes(x=year, y=total_emission, width=.5,fill = total_emission)) +
  geom_bar(stat = "identity", position="identity")  + 
  scale_y_continuous(breaks= seq(0,y_max, by = floor(y_max/10))) + 
  scale_x_continuous(breaks= total_emission_per_year$year ) + 
  labs( title = "PM 2.5 emission over years in Coal combusion related sources") 

dev.off()
