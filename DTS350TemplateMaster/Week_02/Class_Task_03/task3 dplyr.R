library(dplyr)
newiris <- arrange(iris, Sepal.Length)
head(newiris)

testdata <- select(iris, Species, Petal.Width)
species <- iris %>% 
  group_by(Species) %>% 
  summarise( avg_sepalL = mean(Sepal.Length, na.rm = TRUE),
             avg_sepalW = mean(Sepal.Width, na.rm = TRUE),
             avg_petalL = mean(Petal.Length, na.rm = TRUE),
             avg_petalW = mean(Petal.Width, na.rm = TRUE))
species

spec2 <- iris %>%
  group_by(Species) %>%
  summarise_all(c(mean,sd))
spec2

