require(tidyquant)
require(tidyverse)
require(dygraphs)
require(timetk)
require(dplyr)
require(lubridate)

end <- today()
start <- end - years(5)

kroger <- tq_get('KR', get = 'stock.prices', start = start, end = end)

kroger_xts <- kroger %>% 
  select(symbol, date, close) %>% 
  tk_xts(date_var = date) 

kroger_xts_invest <- kroger %>% 
  filter(date >= as.Date('2018-4-5')) %>% 
  select(date, close) %>% 
  tk_xts(date_var = date)

dygraph(kroger_xts, main = 'Kroger stock performance over last 5 years') 

dygraph(kroger_xts_invest, main = 'initial 10k investment') %>% 
  dyRebase(value = 10000) %>% 
  dyAnnotation('2019-3-1', text = 'a', tooltip = 'disappointing fiscal report releasesd') %>% 
  dyAnnotation('2019-8-5', text = 'b', tooltip = 'very optomistic fiscal projections released')


