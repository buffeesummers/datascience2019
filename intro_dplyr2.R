# Intro to dplyr
library(dplyr)

#load gapminder data as sample dataset
gapminder <- read.csv("data/gapminder_data.csv",
                      stringsAsFactors = F)

mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])

# This is a pipe: %>%
# Functions we will learn today from dplyr:
# 1. select (0)
# 2. filter()
# 3. group_by()
# 4. summarize()
# 5. mutate()

# what attributes in gapminder:
colnames(gapminder)

# select three attributes from gapminder:
subset1 <- gapminder %>%
  select(country, continent, lifeExp)
head(subset1)

# select all attributes except 2
subset2 <- gapminder %>%
  select(-lifeExp, -pop)
head(subset2)
str(subset2)

# select some attributes but rename a few for clarity
subset3 <- gapminder %>%
  select(country, population = pop, lifeExp, gdp = gdpPercap)
str(subset3)

# using filter()
africa <- gapminder %>%
  filter(continent == "Africa") %>%
  select(country, population = pop, lifeExp)
str(africa)
