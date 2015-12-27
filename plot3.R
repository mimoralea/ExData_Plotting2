# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to 
# make a plot answer this question.

require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland (fips == "24510") 
total_bc <- filter(NEI, fips == "24510")

total_by_year <- summarise(group_by(total_bc, type, year), sum(Emissions))
names(total_by_year) <- c("type", "year", "emissions")
total_by_year[,3] <- total_by_year[,3]/1000 # make it kilo tons

png("plot3.png", width=800, height=800)
ggplot(total_by_year, aes(x = factor(year), y = emissions, color = type, group = type)) + 
  geom_line() + geom_point() + 
  xlab("Year") + ylab("Total Emissions (Kilo Tons)") + 
  ggtitle("Total Emissions in Baltimore City, MD\n through years by Emission Type") +
  labs(color='Emission Type')
dev.off()
