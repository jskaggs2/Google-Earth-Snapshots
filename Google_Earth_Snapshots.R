## Google Earth Snapshots
## Jon Skaggs & Katie Hill
## initiated 31 January 2019
## Adapted from Unmitigated Impacts 2

# Prerequisites -----------------------------------------------------------


# devtools::install_github("dkahle/ggmap", ref = "tidyup")
# Must register (with billing) to access Google's Geocode API, Static Maps
# API, Maps Javascript API. Generate API key and insert at line 13.

key = "API is sensitive; do not share!"

# Load packages
library(ggmap); register_google(key = key)

# Load sites
coords <- read.csv("coords.csv")


# Get imagery -------------------------------------------------------------


for(i in 1:nrow(coords)){
  
  image <- (get_googlemap(
    center = c(lon = coords$lon[i], lat = coords$lat[i]),
    zoom = 19, 
    color = "color", 
    format = "png8", 
    maptype = "satellite"))
  
  ggmap(image) +
    geom_point(
      aes(x = coords$lon[i], y = coords$lat[i]), color = "yellow") +
    geom_text(
      aes(x = coords$lon[i], y = coords$lat[i], label = as.character(coords$name[i])), hjust = 1, vjust = 1) +
    ggtitle(
      paste0(as.character(coords$name[i]), " (accessed ", Sys.Date(), ")"))
  
  ggsave(paste0("out/", coords$name[i], "_", Sys.Date(), ".pdf"))
  
}
