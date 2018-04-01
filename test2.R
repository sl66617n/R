# Better install the dev versions ----------
# devtools::install_github("dkahle/ggmap")
# devtools::install_github("hrbrmstr/ggalt")

# load packages
library(ggplot2)
library(ggmap)
library(ggalt)

# Get Chennai's Coordinates --------------------------------
chennai <-  geocode("Chennai")  # get longitude and latitude

# Get the Map ----------------------------------------------
# Google Satellite Map
chennai_ggl_sat_map <- qmap("chennai", zoom=12, source = "google", maptype="satellite")  

# Google Road Map
chennai_ggl_road_map <- qmap("chennai", zoom=12, source = "google", maptype="roadmap")  

# Google Hybrid Map
chennai_ggl_hybrid_map <- qmap("chennai", zoom=12, source = "google", maptype="hybrid")  

# Open Street Map
chennai_osm_map <- qmap("chennai", zoom=12, source = "osm")   

# Get Coordinates for Chennai's Places ---------------------
chennai_places <- c("Kolathur",
                    "Washermanpet",
                    "Royapettah",
                    "Adyar",
                    "Guindy")

places_loc <- geocode(chennai_places)  # get longitudes and latitudes


# Plot Open Street Map -------------------------------------
chennai_osm_map + geom_point(aes(x=lon, y=lat),
                             data = places_loc, 
                             alpha = 0.7, 
                             size = 7, 
                             color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 2, color = "blue")

# Plot Google Road Map -------------------------------------
chennai_ggl_road_map + geom_point(aes(x=lon, y=lat),
                                  data = places_loc, 
                                  alpha = 0.7, 
                                  size = 7, 
                                  color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 2, color = "blue")

# Google Hybrid Map ----------------------------------------
chennai_ggl_hybrid_map + geom_point(aes(x=lon, y=lat),
                                    data = places_loc, 
                                    alpha = 0.7, 
                                    size = 7, 
                                    color = "tomato") + 
  geom_encircle(aes(x=lon, y=lat),
                data = places_loc, size = 2, color = "blue")






c ( 2,4,6,8) * c(3,4,5)

qb = data.frame(qb_name=c("Aaron Rodgers", "Russell Wilson", "Tom Brady", "Andy"),
                superBowlRing=c(TRUE, TRUE, TRUE, FALSE),
                numberRings = c(1,1,4,0),
                conference = c("nfc","nfc","afc", "afc"),
                stringsAsFactors = FALSE)
View(qb)
qb[c(1,2),1]


qb[c(1,4),4]
qb[c(1,4), c(1,3)]

data= read.csv()
str(data)
install.package('dplyr')
library(dplyr)
data%>%
  group.by(year, sex) %>%
  arrange(desc(percent))%>%
  mutate(rank = rank(percent))%>%
  filter(name=="Kyle", sex =='boy', rank <=100)





