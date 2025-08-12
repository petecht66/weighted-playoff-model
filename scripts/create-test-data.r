# R package, developed by Kyle Grealis
library(nascaR.data)

# visualizing Cup Series data frame, commented out
# cup_series

# creating 2024 Cup Series season data frame
season_2024 <- cup_series[cup_series$Season == 2024, c("Driver", "Track", "Name", "Pts")]
season_2024

# Write the 2024 Cup Series season data frame into a .csv file
write.csv(season_2024, "Raw 2024 Data.csv")

