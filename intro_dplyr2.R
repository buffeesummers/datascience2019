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

# working with group-by() & summarize ()
str(gapminder %>% group_by(continent))

# summarize mean gdp per continent
# only looks at the data that you are asking for and extracts that information
# filter will show you everything but summarize pulls out specifics 
gdp_continent <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_gdp = mean(gdpPercap))
View(gdp_continent)

#plot data in bar plot
library(ggplot2)
summary_plot <- gdp_continent %>%
  ggplot(aes(x = mean_gdp, y = mean_lifeExp)) +
  geom_bar(stat = "identity") +
  theme_bw()
summary_plot


# calculate mean population for all of the continents
country_meanpop <- gapminder %>%
  group_by(continent) %>%
  summarize(mean_pop = mean(pop))
country_meanpop

# count() and n()
# two equal signs when you are specifically looking for a value or comparison
# single equal tells it you are assigning a value
gapminder %>%
  filter(year == 2002) %>%
  count(continent, sort = TRUE)

# n automatically figures out the number of observations
gapminder %>%
  group_by(continent) %>%
  summarize(se = sd(lifeExp)/sqrt(n()))

# mutate() is my friend
# when you want to add a new column to your data frame
# use it when you have column x = random numbers y = random numbers and want to multiply and save the value in new column
xy <- data.frame(x = rnorm(100),
                 y = rnorm(100))
head(xy)
xyz <- xy %>%
  mutate(z = x*y)
head(xyz)

# add a column that gives full gdp for each continent (gdp * pop = full gdp)
total_gdp_country <- gapminder %>%
  mutate(total_gdp = pop*gdpPercap)
head(total_gdp_country)

gdp_per_cont <- gapminder %>%
  mutate(total_gdp = pop*gdpPercap) %>%
  group_by(continent) %>%
  summarize(cont_gdp = sum(total_gdp))
gdp_per_cont

gdp_per_cont <- total_gdp_country %>%
  group_by(continent) %>%
  summarise(cont_gdp = sum(total_gdp))
gdp_per_cont



