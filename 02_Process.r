#Removing blank values into a new dataframe
bikedata_2024_clean <- drop_na(bikedata_2024)

#Separating dates into day, month, year, day of the week and time to aggregate data for each of these values
bikedata_2024_clean$date <- as.Date(bikedata_2024_clean$started_at)
bikedata_2024_clean$month <- format(as.Date(bikedata_2024_clean$date), "%m")
bikedata_2024_clean$day <- format(as.Date(bikedata_2024_clean$date), "%d")
bikedata_2024_clean$year <- format(as.Date(bikedata_2024_clean$date), "%Y")
bikedata_2024_clean$day_of_week <- format(as.Date(bikedata_2024_clean$date), "%A")
bikedata_2024_clean = bikedata_2024_clean %>% mutate(time = format(as.POSIXct(started_at), format = "%H"))

#Caculating user ride length in mins:
bikedata_2024_clean$ride_length <-  round(difftime(bikedata_2024_clean$ended_at,
                                                   bikedata_2024_clean$started_at,
                                                   units="mins"), 2)

#Caculating user ride distance in km:
bikedata_2024_clean$ride_distance <- distGeo(matrix(c(bikedata_2024_clean$start_lng,
                                                      bikedata_2024_clean$start_lat), ncol = 2),
                                             matrix(c(bikedata_2024_clean$end_lng,
                                                      bikedata_2024_clean$end_lat), ncol = 2))
bikedata_2024_clean$ride_distance <- bikedata_2024_clean$ride_distance/1000

#Calculating speed the user traveled at
bikedata_2024_clean$ride_speed = round(c(bikedata_2024_clean$ride_distance)/as.numeric(c(bikedata_2024_clean$ride_length), units="hours"), 2)

#Removing entries when bikes were bikes were taken out of docks and checked for quality or ride_length was negative.
bikedata_2024_clean <- bikedata_2024_clean[!(bikedata_2024_clean$start_station_name == "HQ QR" | bikedata_2024_clean$ride_length<0),]

#Checking and removing ride_id duplicates (ride_id is unique per trip)
paste('Duplicates: ', sum(duplicated(bikedata_2024_clean$ride_id)))
bikedata_2024_clean <- bikedata_2024_clean[!duplicated(bikedata_2024_clean$ride_id),]

#Checking data 
glimpse(bikedata_2024_clean)
summary(bikedata_2024_clean)
