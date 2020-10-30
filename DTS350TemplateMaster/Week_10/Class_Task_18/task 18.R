require(lubridate)
require(riem)
require(viridis)
require(MASS)
require(tidyverse)

dat <- read_csv(url('https://github.com/WJC-Data-Science/DTS350/raw/master/carwash.csv'))

dat$time <- with_tz(dat$time, tz = 'MST')
dat$time <- ceiling_date(dat$time, unit = 'hour') 

dat1 <- dat %>% 
  separate(time, into = c('date','time'), sep = 11) %>% 
  group_by(time) 

temps <- riem_measures(station = "RXE",  date_start  = '2016-05-13',  date_end  = '2016-07-15')
temps$valid <- ymd_hms(temps$valid)
temps$valid <- ceiling_date(temps$valid, unit = 'hour') 


temps1 <- temps %>% 
  dplyr::select(valid, tmpf) %>% 
  filter(!is.na(tmpf)) %>% 
  separate(valid, into = c('date','time'), sep = 11) %>% 
  right_join(dat1) %>% 
  group_by(date, time) 

am_list <- c('8:00:00','9:00:00','10:00:00','11:00:00','12:00:00')
pm_list <- c('13:00:00','14:00:00','15:00:00','16:00:00','17:00:00')
  
am_density <- ggplot(subset(temps1, time %in% am_list)) +
  geom_density(aes(x = tmpf, y = ..count.., fill = time), alpha = .3) +
  xlab('temp')
am_density

pm_density <- ggplot(subset(temps1, time %in% pm_list)) +
  geom_density(aes(x = tmpf, y = ..count.., fill = time), alpha = .3) +
  xlab('temp')
pm_density

am_scatter <- ggplot(subset(temps1, time %in% am_list), aes(x = tmpf, y = amount)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~time) +
  xlab('temp')
am_scatter

pm_scatter <- ggplot(subset(temps1, time %in% pm_list), aes(x = tmpf, y = amount)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~time) +
  xlab('temp') + 
  ylim(-100, 150)
pm_scatter



