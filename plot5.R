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
# Keep the data for Baltimore only
data_veh <-  tbl_df(NEIData) %>% filter(fips == "24510")
# Find records for motor vehicles in Baltimore
data_veh <- data_veh %>% filter(SCC %in% temp_codes$SCC)
summary_veh <-summarize(group_by(data_veh,year),emissions = sum(Emissions))

p <- qplot(year,emissions,data  = summary_veh, geom = c("point","line")) + ggtitle("Motor Vehicles")
print(p)



dev.print(png, 'plot5.png', width =640)


#NEIData1 <- tbl_df(NEIData)
