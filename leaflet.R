library(leaflet)

SalesByCountry


leaflet(SalesByCountry) %>% 
  addTiles() %>%
  addCircles(lng = ~Lng, lat = ~Lat, weight = 1,
           radius = ~sqrt(Total)*100)


