# PowerPoint

# Pakker
install.packages("officer")
install.packages("flextable")

library(officer)
library(flextable)

# Opret Flextable - SalesByCountryTable - Top 5 country
SalesByCountryTop5 <- head(SalesByCountry, 5)

SalesByCountryTable <- flextable(
  head(SalesByCountryTop5),
  col_keys = c("Country", "Total", "Bar"))

num_keys <- c("Total")
SalesByCountryTable <- colformat_num(x = SalesByCountryTable, j = num_keys, big.mark = ".", decimal.mark = ",", digits = 0)
SalesByCountryTable <- autofit(SalesByCountryTable)


SalesByCountryTable

# Opret PowerPoint objekt
PowerPointSalgsRapport <- read_pptx()

PowerPointSalgsRapport <- PowerPointSalgsRapport %>%
  # Titel slide
  add_slide(layout = "Title Only", master = "Office Theme") %>% 
  ph_with(value = "Sales rapport", location = ph_location_type(type = "title")) %>% 
  ph_with(value = "Tue Hellstern", location = ph_location_type(type = "ftr")) %>% 
  # Slide Table
  add_slide(layout = "Title and Content") %>% 
  ph_with(value = "Top 5 sales by country", location = ph_location_type(type = "title")) %>%
  ph_with(value = SalesByCountryTable, location = ph_location_type(type = "body")) %>% 
  # Slide Plot
  add_slide(layout = "Title and Content") %>% 
  ph_with(value = "Sales by country", location = ph_location_type(type = "title")) %>%
  ph_with(value = SalesByCountryPlot, location = ph_location_type(type = "body")) %>% 
  # Slide Plot
  add_slide(layout = "Title and Content") %>% 
  ph_with(value = "Sales by weekday", location = ph_location_type(type = "title")) %>%
  ph_with(value = SalesByWeekdayPlot, location = ph_location_type(type = "body"))

# Gem PowerPoint
print(PowerPointSalgsRapport, target = paste("SalesRapport", format(Sys.Date(), "%d-%m-%Y"), ".pptx"))

