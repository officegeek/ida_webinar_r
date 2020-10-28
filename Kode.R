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

library(RCurl)
library(ggplot2)
library(readxl)


# Data import
# Excel og CSV // GitHub

# Hent data fra GitHub
# CSV
customers <- getURL("https://raw.githubusercontent.com/officegeek/data/master/customers.csv")
customers <- read.csv2(text = customers, fileEncoding="UTF-8-BOM", stringsAsFactors=FALSE)
orders <- getURL("https://raw.githubusercontent.com/officegeek/data/master/orders.csv")
orders <- read.csv2(text = orders, fileEncoding="UTF-8-BOM", stringsAsFactors=FALSE)

# Excel
order_details <- getURL("https://github.com/officegeek/data/blob/master/order_details.xlsx")
order_details <- read_xlsx("order_details")


# Plot