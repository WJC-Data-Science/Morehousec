install.packages('gapminder')
library(gapminder)
library(tidyverse)

tester <- gapminder %>% 
  filter(country != 'Kuwait') %>%
  group_by(continent) %>%
  mutate(pop100 = pop/100000)
tester

ggplot(data = tester, mapping = aes(x=lifeExp, y=gdpPercap)) +
  geom_point(aes(size=pop100, col=continent )) +
  ylab('GDP per capita') +
  xlab('Life Expectancy') +
  labs(col = 'Continent', size = 'Population 100K') +
  scale_y_continuous(trans ='sqrt') +
  facet_grid(~year) +
  theme_bw()

data2 <- gapminder %>%
  filter(country != 'Kuwait') %>%
  select(continent, year, gdpPercap, pop) %>% 
  group_by(continent, year) %>%
  summarise(gdp = weighted.mean(gdpPercap, pop), 
            sum = sum(pop))
data2


ggplot(data = data2, mapping = aes(x=year, y=gdp)) +
  geom_line(aes(col = continent)) +
  geom_point(aes(col = continent)) +
  geom_path(data = tester, mapping = aes(x = year, y = gdpPercap, color = continent, group = country)) +
  geom_point(data = tester, mapping = aes(x = year, y = gdpPercap, col = continent)) +
  scale_y_continuous(trans ='sqrt') +
  scale_x_continuous(breaks = seq(1950, 2000, by = 10)) +
  ylab('GDP per capita') +
  xlab('Life Expectancy') +
  labs(col = 'Continent', size = 'Population 100K') +
  geom_point(data = data2, aes(size = sum/100000)) +
  geom_line(data = data2) +
  facet_grid(~continent)

ggsave(
  filename = 'graph1.png',
  plot = last_plot(),
  width = 15,
  units = c('in'),
  dpi = 300)
)
