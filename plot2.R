# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

require(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland (fips == "24510") 
total_bc <- filter(NEI, fips == "24510")
total_by_year <- summarise(group_by(total_bc, year), sum(Emissions))
total_by_year[,2] <- total_by_year[,2]/1000 # make it kilo tons

png("plot2.png", width=480, height=480)
barplot(as.vector(unlist(total_by_year[,2]), mode="double"), 
        names.arg=as.vector(unlist(total_by_year[,1])), 
        main="Total Emissions in Baltimore City, MD through years", 
        xlab="Year", 
        ylab="Total Emissions (Kilo Tons)", col="dark red")
dev.off()
