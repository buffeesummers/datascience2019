#plotting Biketown trip data with base R
install.packages("tidyverse")
library(tidyverse)
library(lubridate)

biketown <- read.csv("data/biketown-2018-trips.csv")
str(biketown)

summary(biketown)

biketown$hour <- 
  hms(biketown$StartTime) %>%
  hour()

table(biketown$hour)


#same as this in base
stime <- hms(biketown$StartTime)
biketown$hour <-  hour(stime)

freq_by_hour <- table(biketown$hour)
barplot(freq_by_hour)

hist(biketown$hour)

#investigate hourly bins
hist(biketown$hour, breaks = seq(0,24, 3))
hist(biketown$hour, breaks = seq(0,24, 6))
hist(biketown$hour, breaks = seq(0,12, 3))

#focus on the AM peak
am_peak <- subset(biketown, hour >= 7 & hour < 10)
hist(am_peak$hour, breaks = seq(7, 10, 1)) #not great!

barplot (table(am_peak$hour))


