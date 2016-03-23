# Plot1.R script, Assignment 4
# open PM2.5 data if not open yet
library(dplyr)
library(tidyr)
library(ggplot2)
# Check whether the df exists in memory, otherwise import it
if (!exists("NEIData") | !exists("SCCMap"))
{
  NEIData <- readRDS("summarySCC_PM25.rds")
  SCCMap  <- tbl_df(readRDS("Source_Classification_Code.rds"))
}
# Play with a smaller df
# Filter the rows corresponding to Baltimore City:
# Motorcycles are technically motor vehicles. 
# Get the codes for the motor vehicles
temp_codes  <-  filter(SCCMap, grepl("[M]otor",Short.Name) )
# Keep the data for Baltimore and LA County only
data_veh <-  tbl_df(NEIData) %>% filter(fips %in% c("24510","06037"))
# Find records for motor vehicles:
data_veh <- data_veh %>% filter(SCC %in% temp_codes$SCC)
# Group them by fips and year
summary_veh <-summarize(group_by(data_veh,year,fips),emissions = sum(Emissions))
# Rename the fips to geo-names:
summary_veh[summary_veh$fips == "24510",]$fips = "Baltimore City"
summary_veh[summary_veh$fips == "06037",]$fips = "LA County"
# Get the magnitude of the change over the years:
la_dist <- dist(range(summary_veh[summary_veh$fips == "LA County",]$emissions))
bm_dist <- dist(range(summary_veh[summary_veh$fips == "Baltimore City",]$emissions))

p <- qplot(year,emissions,data  = summary_veh,col= fips, geom = c("point","line")) + 
  ggtitle("Motor Vehicles") + annotate("text",label =paste("Change in LA County:",la_dist), x = 2004,
                                       y = mean(summary_veh[summary_veh$fips =="LA County",]$emissions), size = 4)+
  annotate("text",label =paste("Change in Baltimore City:",bm_dist), x = 2004,
           y = mean(summary_veh[summary_veh$fips == "Baltimore City",]$emissions), size = 4)
# Could have plotted the difference (derivative over the years)
print(p)



dev.print(png, 'plot6.png', width =640)


#NEIData1 <- tbl_df(NEIData)
