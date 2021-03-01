# Reading in the shapefile. 

ba_bgs <- st_read("/Users/max/Dropbox/Stanford Stuff/Classes/PUBLPOL/Y23 Spring 2020/Thesis/Data/sf_bay_clipped/2e262912-207a-4424-9e17-08041688d59c202044-1-130emnv.fypm.shp")

population_data_bgs <- read_csv("/Users/max/Dropbox/Stanford Stuff/Classes/PUBLPOL/Y23 Spring 2020/Thesis/Data/population_data_bgs.csv")

# Don't think I need any of this now because it was for the population data. Just comment out and see if the assets are recreated. 

ba_bgs <- ba_bgs[,c(6,10)] #Don't really need the id's but may as well keep them so I have a unique identifier for each row. 
ba_bgs <- ba_bgs %>% mutate(geoid_long = paste("1500000US", blkgrpid, sep = ""))

ba_bgs <- ba_bgs[,c(2,3)]
# This is where it filters to just block groups in SF, I'll just keep this and rename things accordingly. 
ba_bgs <- ba_bgs %>% filter(geoid_long %in% population_data_bgs$id)

# Creation of sf_311_kitty as sf
# Making the sf object from the data.table
sf_311_kitty <- st_as_sf(sf_311_kitty, coords = c("Longitude", "Latitude"), crs = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

# Doing the spatial join to get block group data to each call
sf_311_kitty <- st_join(sf_311_kitty, ba_bgs["geoid_long"])



# Summary data frame is what contains information on calls per block and that's what eventually gets mapped. 
sf_311_kitty_summary <- sf_311_kitty %>% group_by(geoid_long) %>% summarize("calls_bg" = n())

# Join it back to the bgs then plot. Have to join it to the sf object,  
sf_311_kitty_summary <- ba_bgs %>% left_join(as.data.frame(sf_311_kitty_summary)[,1:2], by = "geoid_long")

# This did the trick. 
sf_311_kitty_summary <-  sf_311_kitty_summary %>% drop_na(calls_bg)

# Creating the color palette
binpal <- colorBin("Oranges", sf_311_kitty_summary$calls_bg, 9, pretty = FALSE)

# The actual mapping part. 
# tmap_mode("plot")
# map_kitty <- tm_shape(sf_311_kitty_summary1) + tm_polygons("calls_bg", style = "quantile")

return(sf_311_kitty_summary)

# map_kitty



