# Plot1.R script, Assignment 4
# open PM2.5 data if not open yet
library(dplyr)
library(tidyr)
# Check whether the df exists in memory, otherwise import it
if (!exists("NEIData") | !exists("SCCMap"))
{
  NEIData <- readRDS("summarySCC_PM25.rds")
  SCCMap  <- readRDS("Source_Classification_Code.rds")
}
# Play with a smaller df
#NEIData1 <- tbl_df(NEIData[sample(1:nrow(NEIData),15000),])
# Filter the rows corresponding to Baltimore City:
NEIData_BmC <- filter(NEIData,fips == "24510")
# Group by year, and do the sum of the emissions from all sources:
emis_year <- summarize(group_by(NEIData_BmC,year),sum(Emissions))
# Repeat the procedure from plot1.R
colnames(emis_year) <- c("year","TotalEmBMc")
par(mfrow = c(1,1))
plot(emis_year$year,emis_year$TotalEmBMc,pch =20,xlim = c(1997,2009),
     ylab= "Total Emission, tons",xlab = "Year")
text(emis_year$year-1,emis_year$TotalEmBMc,formatC(emis_year$TotalEmBMc,digits = 3))
dev.print(png, 'plot2.png', width =640)


#NEIData1 <- tbl_df(NEIData)
