# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

require(dplyr)
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_combustion_sources <- SCC[grep("^Charcoal Manufacturing$", SCC$SCC.Level.Three),]$SCC
coal_combustion <- filter(NEI, SCC %in% coal_combustion_sources)

total_by_year <- summarise(group_by(coal_combustion, year, SCC), sum(Emissions))
names(total_by_year) <- c("year", "SCC", "emissions")

png("plot4.png", width=800, height=800)
ggplot(total_by_year, aes(x = factor(year), y = emissions)) + 
  geom_bar(stat="identity", aes(fill=SCC)) + 
  xlab("Year") + ylab("Total Emissions (Tons)") +
  ggtitle("Total Emissions through years\nfrom Charcoal Manufacturing sources")
dev.off()
