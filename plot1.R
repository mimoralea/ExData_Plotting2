# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

require(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_by_year <- summarise(group_by(NEI, year), sum(Emissions))
total_by_year[,2] <- total_by_year[,2]/1000000 # make it million tons

png("plot1.png", width=480, height=480)
barplot(as.vector(unlist(total_by_year[,2]), mode="double"), 
        names.arg=as.vector(unlist(total_by_year[,1])), 
        main="Total Emissions through years", 
        xlab="Year", 
        ylab="Total Emissions (Million Tons)", col="dark red")
dev.off()
