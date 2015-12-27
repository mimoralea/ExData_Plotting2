# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mobile_sources <- SCC[grep("^Mobile Sources$", SCC$SCC.Level.One), ]$SCC

# Baltimore City, Maryland (fips == "24510") / Los Angeles County, California (fips == "06037")
mobile_comparisson <- filter(NEI, SCC %in% mobile_sources & (fips == "24510" | fips == "06037"))

total_by_year <- summarise(group_by(mobile_comparisson, fips, year), sum(Emissions))
names(total_by_year) <- c("fips", "year", "emissions")
total_by_year <- mutate(total_by_year, location = ifelse(fips == "24510", "Baltimore City, MD", "Los Angeles County, CA"))

png("plot6.png", width=800, height=800)
ggplot(total_by_year, aes(x = factor(year), y = emissions)) + 
  geom_bar(aes(fill=location), stat="identity", position="dodge") + 
  scale_fill_discrete(name="Location") + 
  xlab("Year") + ylab("Total Emissions (Tons)") +
  ggtitle("Total Emissions through years in\nBaltimore City and Los Angeles County")
dev.off()
