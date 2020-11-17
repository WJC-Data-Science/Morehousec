require(tidyverse)
require(dyplr)
require(readr)
require(USAboundaries)
require(USAboundariesData)
require(maps)
require(sf)
require(RColorBrewer)
require(scales)

dat <- read_csv(url('https://github.com/WJC-Data-Science/DTS350/raw/master/permits.csv'))

dat <- dat %>% 
  select(2:8) 

county <- us_counties()

county$statefp <- as.numeric(county$statefp)
county$countyfp <- as.numeric(county$countyfp)


state_totals <- dat %>% 
  group_by(state,county, year) %>% 
  summarise(total = mean(value, na.rm = TRUE))
head(state_totals)

#trend of all over time 
all <- dat %>% 
  group_by(year) %>% 
  summarise(total = mean(value, na.rm = T))

ggplot(all, aes(x = year, y = total)) +
  geom_path()

#1986
totals86 <- state_totals %>% 
  filter(year == '1986') %>% 
  select(state, county, year, total)

totals86 <- totals86 %>% 
  rename(statefp = state,
         countyfp = county) 

final86 <- merge(totals86, county, all = TRUE, by = c('statefp','countyfp')) 

ggplot(final86) +
  geom_sf(aes(geometry = geometry, fill = total)) +
  coord_sf(xlim = c(-125, -65), ylim = c(25, 50)) +
  scale_fill_gradient(low = 'blue', high = 'red', limits = c(0, 35000)) +
  ggtitle('new building permits by county in 1986') +
  theme_bw()


#1991
totals91 <- state_totals %>% 
  filter(year == '1991') %>% 
  select(state, county, year, total)

totals91 <- totals91 %>% 
  rename(statefp = state,
         countyfp = county) 

final91 <- merge(totals91, county, all = TRUE, by = c('statefp','countyfp')) 

ggplot(final91) +
  geom_sf(aes(geometry = geometry, fill = total)) +
  coord_sf(xlim = c(-125, -65), ylim = c(25, 50)) +
  scale_fill_gradient(low = 'blue', high = 'red', limits = c(0, 35000)) +
  ggtitle('new building permits by county in 1991') +
  theme_bw()


#2005
totals05 <- state_totals %>% 
  filter(year == '2005') %>% 
  select(state, county, year, total)

totals05 <- totals05 %>% 
  rename(statefp = state,
         countyfp = county) 

final05 <- merge(totals05, county, all = TRUE, by = c('statefp','countyfp')) 

ggplot(final05) +
  geom_sf(aes(geometry = geometry, fill = total)) +
  coord_sf(xlim = c(-125, -65), ylim = c(25, 50)) +
  scale_fill_gradient(low = 'blue', high = 'red', limits = c(0, 35000)) +
  ggtitle('new building permits by county in 2005') +
  theme_bw()


#2009
totals09 <- state_totals %>% 
  filter(year == '2009') %>% 
  select(state, county, year, total)

totals09 <- totals09 %>% 
  rename(statefp = state,
         countyfp = county) 

final09 <- merge(totals09, county, all = TRUE, by = c('statefp','countyfp')) 

ggplot(final09) +
  geom_sf(aes(geometry = geometry, fill = total)) +
  coord_sf(xlim = c(-125, -65), ylim = c(25, 50)) +
  scale_fill_gradient(low = 'blue', high = 'red', limits = c(0, 35000)) +
  ggtitle('new building permits by county in 2009') +
  theme_bw()

