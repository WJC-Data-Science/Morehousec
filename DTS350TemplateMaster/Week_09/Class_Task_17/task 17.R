require(tidyverse)
require(haven)
require(readr)
require(readxl)
require(downloader)
require(plyr)

data_rds  <- read_rds(url("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS"))
data_dta  <- read_dta("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta")
data_cvs  <- read_csv("https://raw.githubusercontent.com/WJC-Data-Science/DTS350/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv")
sav <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav", sav, mode = "wb")
dfsav <- read_sav(sav)
xlsx <- tempfile()
download("https://github.com/WJC-Data-Science/DTS350/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx",xlsx, mode = "wb")
dfxlsx <- read_xlsx(xlsx)

all_equal(data_dta, dfsav, convert = TRUE)
all_equal(data_dta, dfxlsx, convert = TRUE)
all_equal(data_dta, data_rds, convert = TRUE)
all_equal(data_rds, dfsav, convert = TRUE)
all_equal(data_rds, dfxlsx, convert = TRUE)
all_equal(dfxlsx, dfsav, convert = TRUE)

data_dta2 <- data_dta %>% 
  separate(contest_period, into = c("Month/Month", "Year_end"), sep = -4)
head(data_dta2)

data_dta3 <- data_dta %>% 
  separate(contest_period, into = c("Month/Month", "Year_end"), sep = -4) %>% 
  group_by(Year_end, variable) %>% 
  dplyr::summarise(Average = mean(value, na.rm = TRUE))
data_dta3

data_dta4 <- data_dta2 %>% 
  separate('Month/Month', into = c('month_begin', 'month_end'), sep = '-')
head(data_dta4)

data_dta6 <- data_dta4 %>% 
  group_by(month_end) %>% 
  dplyr::summarise(sum_collected = sum(value, na.ra = T)) 

data_dta6$month_end[data_dta6$month_end == "Dec."] <- "December" 
data_dta6$month_end[data_dta6$month_end == "Febuary"] <- "February" 

data_dta6 <- ddply(data_dta6, 'month_end', numcolwise(sum))

month <- factor(c('January','February','March','April','May','June','July','August','September','October', 'November','December'),
                  levels = c('January','February','March','April','May','June','July','August','September','October', 'November','December'))

data_dta6$month_end <- factor(data_dta6$month_end, levels = month)

data_dta6

p1 <- ggplot(data_dta6, aes(x = month_end, y = sum_collected, group = 1)) +
  geom_line() +
  ggtitle('Six month returns by month end') +
  xlab('Month end') +
  ylab('Sum of returns')
p1

p2 <- ggplot(data_dta6, aes(x = month_end, y = sum_collected, group = 1)) +
  geom_line(color = 'blue') +
  scale_x_discrete(drop = F) +
  ggtitle('Six month returns by month end') +
  xlab('Month end') +
  ylab('Sum of returns')
p2
