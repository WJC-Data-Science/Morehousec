require(tidyverse)
require(lubridate)

dat <- read_csv(url('https://github.com/WJC-Data-Science/DTS350/raw/master/sales.csv')) 
  
dat$Time <- ymd_hms(dat$Time) 
dat$Time <- ceiling_date(dat$Time, unit = 'hour') 
dat$date <- as.Date(dat$Time)
dat$time <- format(as.POSIXct(dat$Time, format = '%Y:%m:%d %H:%M:%S'), '%H:%M:%S')

simple <- dat %>% 
  filter(Name != 'Missing') %>% 
  select(Name, time)

summary <- dat %>% 
  filter(Name != 'Missing') %>% 
  group_by(Name, time) %>% 
  summarise(thing = sum(Amount, na.rm = T))
summary

summary2 <- dat %>% 
  filter(Name != 'Missing') %>% 
  group_by(Name) %>% 
  summarise(thing = sum(Amount, na.rm = T))
summary2

special_dat <- dat
special_dat$date <- weekdays(dat$date)

summary3 <- special_dat %>% 
  filter(Name == 'HotDiggity') %>% 
  group_by(date, time) %>% 
  summarise(sum = sum(Amount, na.rm = T))
summary3

summary3$date_f <- factor(summary3$date, levels = c('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'))

weekday <- ggplot(summary3, aes(x = time, y = sum)) +
  geom_col() +
  facet_wrap(~date_f) +
  xlab('Time') +
  ylab('Count of sales per hour') +
  ggtitle('Sum of sales per hour for each day') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90)) 
weekday

by_time <- ggplot(simple, aes(x = time)) +
  geom_histogram(stat = 'count') +
  theme(axis.text.x = element_text(angle = 90)) +
  facet_wrap(~Name) +
  xlab('Time of day') +
  ylab('Count of sales per hour') +
  ggtitle('Count of sales by hour') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90)) 
by_time

amount_by_time <- ggplot(summary, aes(x = time, y = thing)) + 
  geom_col() +
  facet_wrap(~Name) +
  xlab('Time of day') +
  ylab('Sum of sale amounts') +
  ggtitle('Sum of sales by hour') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90)) 
amount_by_time

total_sales <- ggplot(summary2, aes(x = reorder(Name, -thing), y = thing)) +
  geom_col() +
  xlab('Company') +
  ylab('Sum of total sales') +
  ggtitle('Total sales by company') +
  theme_bw()
total_sales

weekly_dat <- dat
weekly_dat$date <- ceiling_date(weekly_dat$date, unit = 'week') 
weekly_dat$date <- strftime(weekly_dat$date, format = '%V')

weekly_dat_summary <- weekly_dat %>% 
  filter(Name != 'Missing') %>% 
  group_by(Name, date) %>% 
  summarise(sum = sum(Amount, na.rm = T)) %>% 
  arrange(Name, date)
weekly_dat_summary

weekly_plot <- ggplot(weekly_dat_summary, aes(x = date, y = sum)) + 
  geom_col() +
  facet_wrap(~Name) +
  xlab('Week of year') +
  ylab('Sum of total sales') +
  ggtitle('Total sales by company each week') +
  theme_bw()
weekly_plot


monthly_dat <- dat
monthly_dat$date <- ceiling_date(monthly_dat$date, unit = 'month') 
monthly_dat$date <- strftime(monthly_dat$date, format = '%B')

monthly_dat_summary <- monthly_dat %>% 
  filter(Name != 'Missing') %>% 
  group_by(Name, date) %>% 
  summarise(sum = sum(Amount, na.rm = T)) %>% 
  arrange(Name, date)
monthly_dat_summary

monthly_plot <- ggplot(monthly_dat_summary, aes(x = date, y = sum)) + 
  geom_col() +
  facet_wrap(~Name) +
  xlab('Month') +
  ylab('Sum of total sales') +
  ggtitle('Total sales by company') +
  theme_bw()
monthly_plot
