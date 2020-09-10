library(tidyverse)

challenge <-  read_csv(readr_example("challenge.csv"),
                       col_types = cols(
                         x = col_double(),
                         y = col_date()
                       ))

download.file("https://educationdata.urban.org/csv/ipeds/colleges_ipeds_completers.csv",
              "colleges_ipeds_completers.csv")

ipeds <- read_csv("colleges_ipeds_completers.csv")

ipeds_2011 <- ipeds %>%
  filter(year == 2011)

write_csv(ipeds_2011, "colleges_ipeds_completers_2011.csv")

ipeds_1415 <- ipeds %>% 
  filter(year == 2014:2015, fips == 6)

ipeds_1415
tail(ipeds_1415)

write_csv(ipeds_1415, "ipdes_completers_ca.csv")

install.packages("readxl")
library(readxl)

download.file("https://www.hud.gov/sites/dfiles/Housing/documents/FHA_SFSnapshot_Apr2019.xlsx",
              "sfsnap.xlsx")

excel_sheets("sfsnap.xlsx")

library(tidyverse)

p <- ggplot(data = iris, mapping = aes(x=Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species),
            size = 5) +
  geom_point() +
  scale_color_brewer(palette = "Set1") 
p

install.packages("directlabels")
library(directlabels)

p + geom_dl(method = "smart.grid", mapping = aes(label = Species)) + theme(legend.position = "none") 

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(cty)) == 1)
best_in_class
#groups by class and shows the best mpg in each class 
  
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_label(aes(label = model), data = best_in_class, nudge_y = 2, alpha = 0.5)

install.packages('ggrepel')
library(ggrepel)

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_label_repel(aes(label = model), data = best_in_class, nudge_x = 1.5, nudge_y = 1) 

#gg repel moved the labels away from each other 
#nudge moved the lables in the coresponding directions 
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_text_repel(aes(label = model), data = best_in_class, nudge_x = 1.5, nudge_y = 1) 

ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_label_repel(aes(label = model, col = class), data = best_in_class, nudge_x = 1.5, nudge_y = 1) 
ggplot(mpg, aes(displ, cty)) +
  geom_point(aes(colour = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_label_repel(aes(label = model), data = best_in_class, nudge_x = 2.5, nudge_y = 1) 

p <- ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                       y = Sepal.Length, 
                                       color = Species,
                                       shape = Species),
            size = 5) +
  geom_point() +
  scale_color_brewer(palette = "Set1")

p + theme(
  legend.position = "top",
  panel.grid.major.x = element_blank(), 
  panel.grid.minor.x = element_blank(),
  panel.grid.minor.y = element_blank(),
  axis.ticks.length = unit(6, "pt"))

p +
  labs(title = "Comparing 3 Species of Iris") +
  theme(plot.title = element_text(hjust = 1, size = rel(2),),
        axis.text.x = element_text(angle = 35))
