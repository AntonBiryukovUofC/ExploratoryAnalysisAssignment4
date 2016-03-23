# Plot1.R script, Assignment 4
# open PM2.5 data if not open yet
library(dplyr)
library(tidyr)
library(ggplot2)
# Check whether the df exists in memory, otherwise import it
if (!exists("NEIData") | !exists("SCCMap"))
{
  NEIData <- readRDS("summarySCC_PM25.rds")
  SCCMap  <- readRDS("Source_Classification_Code.rds")
}
# Play with a smaller df
# Filter the rows corresponding to Baltimore City:
NEIData_BmC <- filter(tbl_df(NEIData),fips == "24510")
emis_year <- group_by(NEIData_BmC,type,year)
summary_typ_year <-summarize(emis_year,emissions = sum(Emissions))
p <- qplot(year,emissions,data  = summary_typ_year,col = type)+
                geom_line(lwd =3)+xlab("Year")+ylab("Emissions")
print(p)


dev.print(png, 'plot3.png', width =640)


#NEIData1 <- tbl_df(NEIData)
