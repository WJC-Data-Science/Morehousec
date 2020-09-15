dat <- read_csv('CensusAtSchool.csv')

df_inch <- dat %>% 
  mutate(Heightin = Height*.394,
         Footin = Foot_Length*.394) %>% 
  mutate(Height = NULL,
         Foot_Length = NULL)

df_environment <- dat %>% 
  filter(Importance_conserving_water>=750|Importance_Internet_access>=750|Importance_owning_computer>=750|Importance_saving_enery>=750|Importance_reducing_pollution>=750) %>% 
  arrange(Ageyears) 

df_environment

df_numbers <- dat %>% 
  filter(!is.na(Region),!is.na(Gender),!is.na(Importance_reducing_pollution),!is.na(Importance_recycling_rubbish),!is.na(Importance_conserving_water),!is.na(Importance_saving_enery),!is.na(Importance_owning_computer),!is.na(Importance_Internet_access)) %>% 
  group_by(Country) %>% 
  summarise(num_males = sum(Gender == "M", na.rm = TRUE),
            num_females = sum(Gender == "F",na.rm = TRUE),
            m_inter = mean(Importance_Internet_access,na.rm = TRUE),
            m_poll = mean(Importance_reducing_pollution,na.rm = TRUE),
            m_rubb = mean(Importance_recycling_rubbish, na.rm = TRUE),
            m_water = mean(Importance_conserving_water, na.rm = TRUE),
            m_energy = mean(Importance_saving_enery, na.rm = TRUE),
            m_comp = mean(Importance_owning_computer, na.rm = TRUE))
  
df_numbers
#NZ lost because they have NAs 

df_gender <- dat %>% 
  group_by(Country, Gender) %>% 
  summarise(m_poll = mean(Importance_reducing_pollution, na.rm = TRUE),
            sd_pll = sd(Importance_reducing_pollution, na.rm = TRUE),
            m_rubb = mean(Importance_recycling_rubbish, na.rm = TRUE),
            sd_rubb = sd(Importance_recycling_rubbish, na.rm = TRUE),
            m_water = mean(Importance_conserving_water, na.rm = TRUE),
            sd_water = sd(Importance_conserving_water, na.rm = TRUE),
            m_energy = mean(Importance_saving_enery, na.rm = TRUE),
            sd_energy = sd(Importance_saving_enery, na.rm = TRUE),
            m_comp = mean(Importance_owning_computer, na.rm = TRUE),
            sd_comp = sd(Importance_owning_computer, na.rm = TRUE),
            m_inter = mean(Importance_Internet_access, na.rm = TRUE),
            sd_inter = sd(Importance_Internet_access, na.rm = TRUE))
df_gender

multi <- dat %>% 
  group_by(Ageyears) %>% 
  filter(Languages_spoken >= 2) %>% 
  summarise(mem = mean(Score_in_memory_game),
            mem_sd = sd(Score_in_memory_game))
multi

single <- dat %>% 
  group_by(Ageyears) %>% 
  filter(Languages_spoken <2) %>% 
  summarise(mem = mean(Score_in_memory_game),
            mem_sd = sd(Score_in_memory_game))
single  

comp <- ggplot(data = single, mapping = aes(x = Ageyears, y = mem)) +
  geom_point() +
  geom_errorbar(mapping = aes(ymax = mem + mem_sd, ymin = mem - mem_sd)) +
  geom_point(data = multi, col = 'red') +
  geom_errorbar(data = multi, mapping = aes(ymax = mem + mem_sd, ymin = mem - mem_sd), col = 'red')
comp
