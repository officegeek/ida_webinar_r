# PowerPoint

# Pakker
install.packages("officer")
library(officer)


# Opret PowerPoint objekt
PowerPointSalgsRapport <- read_pptx()

PowerPointSalgsRapport <- PowerPointSalgsRapport %>%
  # Titel slide
  add_slide(layout = "Title Only", master = "Office Theme") %>% 
  ph_with(value = "Sales rapport", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "Tue Hellstern", location = ph_location_type(type = "ftr")) %>% 
  # Slide Plot
  add_slide(layout = "Title and Content") %>% 
  ph_with(value = "Sales by country", location = ph_location_type(type = "title")) %>%
  ph_with(value = SalesByCountryTop5Plot, location = ph_location_type(type = "body")) %>% 
  # Slide Plot
  add_slide(layout = "Title and Content") %>% 
  ph_with(value = "Sales by weekday", location = ph_location_type(type = "title")) %>%
  ph_with(value = SalesByWeekdayPlot, location = ph_location_type(type = "body"))

# Gem PowerPoint
print(PowerPointSalgsRapport, target = paste("SalesRapport", format(Sys.Date(), "%d-%m-%Y"), ".pptx"))

