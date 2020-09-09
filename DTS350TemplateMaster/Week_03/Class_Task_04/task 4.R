library(tidyverse)

#exercis 1
ggplot(data = iris, mapping = aes(x=Sepal.Width, y = Sepal.Length)) +
  geom_point()

ggplot(data = iris) +
  geom_point(mapping = aes(x=Sepal.Width, y = Sepal.Length)

#no change, but we can pass specific instructions to certain layers
#of the graph 

#exercise 2
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species)) +
  geom_point(shape = 2)

#exercise 3
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point()
#it doesn't do thing if its outside aes()

#exercise 5 
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10()

#exercise 6 
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10() +
scale_color_manual(values = c("purple", "darkorange", "blue"))

#exersice 8
ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10() +
  scale_color_manual(values = c("purple", "darkorange", "blue")) +
  labs(shape = 'species of iris',color = 'species of iris')
#combines the 2 legends back together 

#exercise 10
p <- ggplot(data = iris, mapping = aes(x = Sepal.Width, 
                                  y = Sepal.Length, 
                                  color = Species,
                                  shape = Species)) +
  geom_point() +
  scale_x_log10() + 
  scale_y_log10() +
  scale_color_manual(values = c("purple", "darkorange", "blue")) +
  labs(shape = 'species of iris',color = 'species of iris') +
  theme_classic()

#exercise 11
averages <- iris %>% group_by(Species) %>% summarise(avgLength = mean(Sepal.Length))

p + geom_hline(data = averages, mapping = aes(yintercept = avgLength))
