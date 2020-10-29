# Webinar IDA
#
# Tue Hellstern
# 28-10-2020

# Intro til RStudio
# Online & Web


# Pakker
# Tidyverse - dplyr - ggplot2

install.packages("RCurl")
install.packages("ggplot2")
install.packages("readxl")
install.packages("dplyr")

library(RCurl)
library(ggplot2)
library(readxl)
library(dplyr)


# Data import
# Excel og CSV // GitHub

# Hent data fra GitHub
# CSV
customers <- getURL("https://raw.githubusercontent.com/officegeek/data/master/customers.csv")
customers <- read.csv2(text = customers, fileEncoding="UTF-8-BOM", stringsAsFactors=FALSE)
orders <- getURL("https://raw.githubusercontent.com/officegeek/data/master/orders.csv")
orders <- read.csv2(text = orders, fileEncoding="UTF-8-BOM", stringsAsFactors=FALSE)
order_details <-  getURL("https://raw.githubusercontent.com/officegeek/data/master/order_details.csv")
order_details <- read.csv2(text = order_details, fileEncoding="UTF-8-BOM", stringsAsFactors=FALSE)

# Excel
# order_details <- getURL("https://github.com/officegeek/data/raw/master/order_details.xlsx")
# order_details <- read_excel(order_details)


# DPLYR - Data
# 

# MUTATE - nyt felt
# Total
order_details <- order_details %>%
  mutate(Total = order_details$UnitPrice * order_details$Quantity) 

# Ugedag
orders <- orders %>% 
  mutate(Weekday = weekdays(as.Date(orders$OrderDate)))



# Join - Erstatning fro lookup funktioner i Excel
Salesdata <- customers %>%
  left_join(orders, by = c("CustomerID" = "CustomerID")) %>% 
  left_join(order_details, by = c("OrderID" = "OrderID")) %>% 
  select(CustomerID, 
         CompanyName, 
         Country, 
         OrderDate, 
         Weekday, 
         Total)


# Group By - Pivot Tabel i Excel
# SalesByCountry
SalesByCountry <- Salesdata %>% 
  group_by(Country) %>% 
  summarise(Total = sum(Total, na.rm=TRUE))


# SalesByCategory
SalesByWeekday <- Salesdata %>% 
  group_by(Weekday) %>% 
  summarise(Total = sum(Total, na.rm=TRUE))

SalesByWeekday <- Salesdata %>% 
  group_by(Weekday) %>% 
  summarise(Total = sum(Total, na.rm=TRUE))

SalesByWeekday <- na.omit(SalesByWeekday)

SalesByWeekdayPct <- SalesByWeekday %>% 
  mutate(Pct = (Total / sum(Total, na.rm=TRUE))*100)


# Sortering efter en Factor
SalesByWeekday$Weekday <- factor(SalesByWeekday$Weekday, levels=c("mandag", "tirsdag", "onsdag", "torsdag", "fredag"))
SalesByWeekday <- SalesByWeekday[order(SalesByWeekday$Weekday),]

# Fjern tomme
SalesByWeekday <- na.omit(SalesByWeekday)

SalesByWeekday


# Plot - ggplot
# https://ggplot2.tidyverse.org/
# 
# SalesByCountry - Barplot
ggplot(SalesByCountry) +
  geom_bar(mapping = aes(x = reorder(Country, Total), y = Total), stat = "identity", fill="lightblue") +
  coord_flip() +
  scale_y_continuous(name="Total sales by country", labels=function(x) format(x, big.mark = ".", decimal.mark = ",", scientific = FALSE)) +
  xlab("Country") +
  ggtitle("Sales by country") +
  theme_bw()


# SalesByWeekday Pct - Pieplot



SalesByWeekday$percent <- SalesByWeekday$Total / (sum(SalesByWeekday$Total, na.rm=TRUE)) * 100
SalesByWeekday$ymax = cumsum(SalesByWeekday$percent)
SalesByWeekday$ymin = c(0, head(SalesByWeekday$ymax, n=-1))

ggplot(SalesByWeekday, aes(fill=Weekday, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
  geom_rect(color='blue') +
  coord_polar(theta="y") +
  xlim(1, 4) +
  geom_text(aes(label=paste( round(percent, digits=0),"%"), x=3.5, y=(ymin+ymax)/2), inherit.aes = TRUE, show.legend = FALSE) +
  ggtitle("Sales i Pct by weekday") +
  theme_void()




