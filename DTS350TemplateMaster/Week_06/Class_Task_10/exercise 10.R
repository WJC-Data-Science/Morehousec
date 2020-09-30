library(ggplot2)
library(dplyr)
library(nycflights13)

#ex 1 
#1
head(flights, 10)
#2 336,776
#3 
is.na(flights)
#there seems to be no NAs

fl_bp <- flights %>%
  ggplot(aes(x = carrier, y = dep_delay))
fl_sc <- flights %>%
  filter(dep_time > 800, dep_time < 900) %>%
  ggplot(aes(x = dep_time, y = dep_delay))

fl_bp + geom_boxplot()

fl_sc + geom_point()

#ex 2 
fl_bp + geom_boxplot() +
  xlab('Carrier Abriviation') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay Boxplots by Carrier')

fl_sc + geom_point() +
  xlab('Departure Time') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay for Each Departure Time')

#ex 3
fl_bp + geom_boxplot() +
  xlab('Carrier Abriviation') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay Boxplots by Carrier') +
  coord_cartesian(ylim = c(50:100))

fl_sc + geom_point() +
  xlab('Departure Time') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay for Each Departure Time') +
  coord_cartesian(ylim = c(50,100)) + 
  scale_y_continuous(breaks = c(60,75,90)) +
  scale_x_continuous(breaks = c(800,815,830,860))

#ex 4
fl_bp + geom_boxplot() +
  xlab('Carrier Abriviation') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay Boxplots by Carrier') +
  coord_cartesian(ylim = c(50:100)) 

fl_sc + geom_point(aes(col = origin)) +
  xlab('Departure Time') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay for Each Departure Time') +
  coord_cartesian(ylim = c(50,100)) + 
  scale_y_continuous(breaks = c(60,75,90)) +
  scale_x_continuous(breaks = c(800,815,830,860)) +
  scale_color_brewer(type = 'qual') 

#ex 5 
fl_bp + geom_boxplot() +
  xlab('Carrier Abriviation') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay Boxplots by Carrier') +
  coord_cartesian(ylim = c(50:100)) +
  theme_bw()

fl_sc + geom_point(aes(col = origin)) +
  xlab('Departure Time') +
  ylab('Departure Delay (minutes)') +
  labs(title = 'Departure Delay for Each Departure Time') +
  coord_cartesian(ylim = c(50,100)) + 
  scale_y_continuous(breaks = c(60,75,90)) +
  scale_x_continuous(breaks = c(800,815,830,845,860)) +
  scale_color_brewer(type = 'qual') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 35)) 

#ex 6
library(ggrepel)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(col = class), size = 3) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  xlab('Engine Displacement') +
  ylab('Miles Per Gallon (highway)') +
  labs(color = 'Vehicle Type') +
  ggrepel::geom_text_repel(aes(label = model, color = class), data = best_in_class)

  
