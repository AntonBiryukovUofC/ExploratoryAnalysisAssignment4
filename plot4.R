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
temp_codes  <-  filter(SCCMap, grepl("[Cc]omb.*[Cc]oal",Short.Name) )
data_coal <- tbl_df(NEIData)
data_coal <- data_coal %>% filter(SCC %in% temp_codes$SCC)


summary_coal <-summarize(group_by(data_coal,year),emissions = sum(Emissions))
p <- qplot(year,emissions,data  = summary_coal, geom = c("point","line")) + ggtitle("Coal Comb.")
print(p)



dev.print(png, 'plot4.png', width =640)


#NEIData1 <- tbl_df(NEIData)
