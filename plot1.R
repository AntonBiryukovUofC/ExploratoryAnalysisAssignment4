# Plot1.R script, Assignment 4
# open PM2.5 data if not open yet
library(dplyr)
library(tidyr)
if (!exists("NEIData") | !exists("SCCMap"))
{
  NEIData <- readRDS("summarySCC_PM25.rds")
  SCCMap  <- readRDS("Source_Classification_Code.rds")
}
# Play with a smaller df
#NEIData1 <- tbl_df(NEIData[sample(1:nrow(NEIData),9000),])
NEIData1 <- tbl_df(NEIData)
emis_year <- summarize(group_by(NEIData1,year),sum(Emissions))
colnames(emis_year) <- c("year","em_total")
par(mfrow = c(1,1))
plot(emis_year$year,emis_year$em_total,pch =20,xlim = c(1997,2009),
     ylab= "Total Emission, tons",xlab = "Year")
text(emis_year$year-1,emis_year$em_total,formatC(emis_year$em_total,digits = 3))
dev.print(png, file = 'plot1.png', width =640)
