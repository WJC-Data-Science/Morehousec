require(tidyverse)
require(tidyquant)
require(timetk)
require(dplyr)
require(ggplot2)


tickers_them <- c('F','SHW','LOW')

zoom <- tq_get('ZM', get = 'stock.prices', from = '2019-10-1', to = '2020-11-7')
apple <- tq_get('AAPL', get = 'stock.prices', from = '2019-10-1', to = '2020-11-7')
nike <- tq_get('NKE', get = 'stock.prices', from = '2019-10-1', to = '2020-11-7')

ford <- tq_get('F', get = 'stock.prices', from = '2019-10-1', to = '2020-11-7')
sherwin <- tq_get('SHW', get = 'stock.prices', from = '2019-10-1', to = '2020-11-7')
lowes <- tq_get('LOW', get = 'stock.prices', from = '2019-10-1', to = '2020-11-7')

my_stocks <- bind_rows(zoom, apple, nike)
their_stocks <- bind_rows(ford, sherwin, lowes)
my_stocks$data <- 'mine'
their_stocks$data <- 'theirs'

my_stocks$symbol <- as.factor(my_stocks$symbol)
my_stocks$symbol <- factor(my_stocks$symbol, c('ZM','AAPL','NKE'))

their_stocks$symbol <- as.factor(their_stocks$symbol) 
their_stocks$symbol <- factor(their_stocks$symbol, c('F','SHW','LOW'))

a_graph <- ggplot(mapping = aes(alpha = .5)) +
  geom_area(data = my_stocks, mapping = aes(x = date, y = close, fill = symbol)) +
  geom_area(data = their_stocks, mapping = aes(x = date, y = close, fill = symbol)) +
  facet_wrap(~data)
a_graph

my_stocks <- my_stocks %>% 
  group_by(symbol) %>% 
  mutate(perc_change = (close/lead(close) - 1) * 100,
         total_perc_change = (close/close[1] - 1) * 100)

their_stocks <- their_stocks %>% 
  group_by(symbol) %>% 
  mutate(perc_change = (close/lead(close) - 1) * 100,
         total_perc_change = (close/close[1] - 1) * 100)

perc_graph <- ggplot() +
  geom_line(data = my_stocks, mapping = aes(x = date, y = perc_change, color = symbol)) +
  geom_line(data = their_stocks, mapping = aes(x = date, y = perc_change, color = symbol)) +
  facet_grid(data~symbol)
perc_graph

test <- ggplotGrob(perc_graph)

#broke as fuck
test$grobs[names(test$grobs) %in% c("panel4","panel5","panel6",'panel7','panel8','panel9'
                              ,"strip_t4","strip_t5","strip_t6"
                              ,"axis_l4","axis_l5","axis_l6"
                              ,"axis_b4")] <- NULL

test$layout <- test$layout[!(test$layout$name %in% c("panel-4-1","panel-5-1","panel-6-1",
                                                     "panel-1-2","panel-2-2","panel-3-2"
                                            ,"axis_l-4","axis_l-5","axis_l-6"
                                            ,"axis_b-4")),]

grid.draw(test)


p <- ggplot() +
  geom_line(data = my_stocks, mapping = aes(x = date, y = total_perc_change, color = symbol)) +
  geom_line(data = their_stocks, mapping = aes(x = date, y = total_perc_change, color = symbol)) +
  facet_wrap(~data)
p

my_win_day <- my_stocks %>% 
  group_by(data, date) %>% 
  mutate(sum_change_day = sum(perc_change, na.rm = T))

my_win_total <- my_stocks %>% 
  group_by(data, date) %>% 
  mutate(sum_change_total = sum(total_perc_change, na.rm = T))

their_win_day <- their_stocks %>% 
  group_by(data, date) %>% 
  mutate(sum_change_day = sum(perc_change, na.rm = T))

their_win_total <- their_stocks %>% 
  group_by(data, date) %>% 
  mutate(sum_change_total = sum(total_perc_change, na.rm = T))

win_day <- ggplot() +
  geom_line(data = my_win_day, mapping = aes(x = date, y = sum_change_day, color = 'red')) +
  geom_line(data = their_win_day, mapping = aes(x = date, y = sum_change_day, color = 'blue'))
win_day

win_total <- ggplot() +
  geom_line(data = my_win_total, mapping = aes(x = date, y = sum_change_total, color = 'red')) +
  geom_line(data = their_win_total, mapping = aes(x = date, y = sum_change_total, color = 'blue'))
win_total
