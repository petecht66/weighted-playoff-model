
# R packages used
library(dplyr)

# import 2024 data as data frame
race_data_2024 <- read.csv("https://raw.githubusercontent.com/petecht66/weighted-playoff-model/refs/heads/main/data/2024%20Race%20Data.csv")
race_data_2024

# Tier 1: Crown jewels and championship finale
Tier1 <- list("DAYTONA 500", "Coca-Cola 600", "Brickyard 400 Presented by PPG", "Cook Out Southern 500", "NASCAR Cup Series Championship")

# Tier 2: Next most important races
Tier2 <- list("XFINITY 500", "Bass Pro Shops Night Race", "Goodyear 400", "FireKeepers Casino 400")

# Tier 3: More important than a regular race

# Tier 4 is the remaining races, list does not need to be made

# create 2024 playoff model function
# weighted_points_2024 <- function(Race, Pts){
#    if()
   # return(weighted_points)
# }