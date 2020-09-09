1 / 200 * 30
#> [1] 0.15
(59 + 73 + 2) / 3
#> [1] 44.7
sin(pi / 2)
#> [1] 1

x <- 3 * 4

x
#> [1] 12

this_is_a_really_long_name <- 2.5

r_rocks <- 2 ^ 3

r_rock
#> Error: object 'r_rock' not found
R_rocks
#> Error: object 'R_rocks' not found

seq(1, 10)

x <- "hello world"

y <- seq(1, 10, length.out = 5)
y

(y <- seq(1, 10, length.out = 5))

my_variable <- 10
my_variable

library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

library(ggplot2)

library(nycflights13)
library(dplyr)
library(knitr)

install.packages('nycflights13')

flights

glimpse(flights)

airlines
kable(airlines)

airlines$name

glimpse(airports)

?flights

#learned about glimpse that gives a look at all the variables and kable that does does the same thing
#as glimpse it just looks better 


head(iris)

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 5,shape = 'star')
     

#do different have differenet sepal sizes 

#yes they do, we can see that the setosa have a distinctly different size while the others are 
#more difficult to distingush