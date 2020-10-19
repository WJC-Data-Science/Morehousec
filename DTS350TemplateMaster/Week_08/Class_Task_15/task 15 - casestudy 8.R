require(Lahman)
require(blscrapeR)
require(tidyverse)

colnames(Schools)
colnames(People)
colnames(Salaries)
colnames(CollegePlaying)

inf_dollars <- inflation_adjust(2017)

together <- People %>% 
  select(playerID, nameFirst, nameLast) %>% 
  left_join(., select(Salaries, playerID, salary, yearID)) %>% 
  filter(yearID > 1947) %>% 
  left_join(., select(CollegePlaying, playerID, schoolID)) %>% 
  left_join(., select(Schools, schoolID, name_full, state)) %>% 
  unite(c('nameFirst','nameLast'), sep = ' ', col = 'full_name') %>% 
  select(yearID, full_name, salary, name_full, state) %>% 
  unique() 
head(together,30)

years <- c()
for (i in seq_len(NROW(inf_dollars))) {
  years[i] <- inf_dollars$year[i]
}
years

for (i in seq_len(NROW(together))) {
  if (together$yearID[i] == (match(together$yearID[i], years) + 1946)) {
    together$salary[i] <- together$salary[i] * (1 + inf_dollars$adj_value[match(together$yearID[i], years)])
  }
}
head(together,30)

mo_not_mizzou <- together %>% 
  filter(state == 'MO') %>% 
  filter(name_full != 'University of Missouri')
head(mo_not_mizzou)

mizzou <- together %>% 
  filter(name_full == 'University of Missouri Columbia')
head(mizzou)

non_mizzou <- ggplot(data = mo_not_mizzou, mapping = aes(x = yearID, y = salary)) +
  geom_path(aes(color = full_name)) +
  guides(color = F) +
  ggtitle('Non-Mizzou players')
non_mizzou

mizzou_graph <- ggplot(data = mizzou, mapping = aes(x = yearID, y = salary)) +
  geom_path(aes(color = full_name)) +
  guides(color = F) +
  ggtitle('Mizzou players')
mizzou_graph

