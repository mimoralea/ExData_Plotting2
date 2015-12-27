# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mobile_sources <- SCC[grep("^Mobile Sources$", SCC$SCC.Level.One), ]$SCC

# Baltimore City, Maryland (fips == "24510") 
mobile_baltimore <- filter(NEI, SCC %in% mobile_sources & fips == "24510")

total_by_year <- summarise(group_by(mobile_baltimore, year), sum(Emissions))
names(total_by_year) <- c("year", "emissions")
total_by_year[,2] <- total_by_year[,2]/1000 # make it kilo tons

png("plot5.png", width=800, height=800)
ggplot(total_by_year, aes(x = factor(year), y = emissions)) + 
  geom_bar(stat="identity", fill="dark red") + 
  xlab("Year") + ylab("Total Emissions (Kilo Tons)") +
  ggtitle("Total Emissions through years in Baltimore\nfrom Mobile sources")
dev.off()
