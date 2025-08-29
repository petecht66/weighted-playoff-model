# R packages used
library(dplyr)

# import 2023 data as data frame
race_data_2023 <- read.csv("https://raw.githubusercontent.com/petecht66/weighted-playoff-model/refs/heads/main/data/2023%20Race%20Data.csv")
race_data_2023

# Tier 1: Crown jewels and championship finale
Tier1 <- list("DAYTONA 500", "Coca-Cola 600", "Cook Out Southern 500", "NASCAR Cup Series Championship") # No Brickyard 400 this year

# Tier 2: Next most important races
Tier2 <- list("Xfinity 500", "Bass Pro Shops Night Race", "Goodyear 400", "FireKeepers Casino 400")

# Tier 3: More important than a regular race
Tier3 <- list("Grant Park 220", "YellaWood 500", "Ally 400", "AutoTrader EchoPark Automotive 400")

# Tier 4 is the remaining races, list does not need to be made, as multiplier will be 1x

# create 2023 playoff model function
create_2023_weighted_points <- function(dataFrame){
   weightedPts <- numeric(nrow(dataFrame))

  for(performance in seq_len(nrow(dataFrame))){ # loop through every row in data frame
    Race <- dataFrame$Name[performance]
    Pts <- dataFrame$Pts[performance]

    # Assign multipliers depending on the race
    if (Race %in% Tier1) {
      multiplier <- 1.3
    } else if (Race %in% Tier2) {
      multiplier <- 1.2
    } else if (Race %in% Tier3) {
      multiplier <- 1.1
    } else {
      multiplier <- 1.0
    }
    # Apply multiplier
    weightedPts[performance] <- Pts * multiplier
  }
  dataFrame$weightedPts <- weightedPts
  return(dataFrame)
}

weighted_race_data_2023 <- create_2023_weighted_points(race_data_2023)
weighted_race_data_2023

create_updated_2023_standings <- function(dataFrame) {
  # Get unique drivers
  drivers <- unique(dataFrame$Driver)
  
  # Empty vector to store totals
  weighted_totals <- numeric(length(drivers))
  original_totals <- numeric(length(drivers))
  
  # Loop over each driver and sum their weightedPts
  for (i in seq_along(drivers)) {
    d <- drivers[i]
    weighted_totals[i] <- sum(dataFrame$weightedPts[dataFrame$Driver == d], na.rm = TRUE)
    original_totals[i] <- sum(dataFrame$Pts[dataFrame$Driver == d], na.rm = TRUE)
  }
  
  # Build a standings data frame
  standings <- data.frame(
    Driver = drivers,
    totalWeightedPts = weighted_totals,
    totalUnweightedPts = original_totals
  )
  
  # Order by descending points
  standings <- standings[order(-standings$totalWeightedPts), ]
  rownames(standings) <- NULL
  
  return(standings)
}

weighted_standings_2023 <- create_updated_2023_standings(weighted_race_data_2023)
weighted_standings_2023

# write.csv(weighted_race_data_2023, "2023 Race Data With Weighted Points.csv")