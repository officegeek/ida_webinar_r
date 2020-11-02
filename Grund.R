# Webinar IDA
#
# Tue Hellstern
# 02-11-2020

# Kør kode
# Windows CTRL + Enter
# Mac Command + Enter
# <-   Alt + -
# %>%  Ctrl + Shift + Enter 

# Variable
x <- 10
x
x * 2

z <- 1:5 
y <- c(5, 6, 8, 10)

ls()
rm(x)


# Hjælp
help(ls)
? ls


# Grund funktioner
min(y)
sum(y)
mean(y)

# NA - Mangelden værdier
y <- c(y, NA, 2)
y

sum(y)
sum(y, na.rm = TRUE)

# Logiske operatorer
x = 10

x == 10
x == 2
x != 10
x < 5
x > 5
x >= 10

# Working directory
getwd()
setwd()

# Pakker
library()

install.packages("ggplot2")
library(ggplot2)

update.packages("ggplot2")
remove.packages("ggplot2")
