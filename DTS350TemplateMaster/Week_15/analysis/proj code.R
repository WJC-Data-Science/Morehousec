#####
# set up #

require(tidyverse)
require(open)
require(ggplot2)
require(png)



img <- readPNG('square.png')

#rays lineup
jm20all <- read_csv('ji-man20_all_pitches.csv')
ra20all <- read_csv('arozarena_all_pitches.csv')
am20all <- read_csv('meadown_all_pitches.csv')
bl20all <- read_csv('lowe_all_pitches.csv')
mm20all <- read_csv('margot_all_pitches.csv')
jw20all <- read_csv('wendle_all_pitches.csv')
wa20all <- read_csv('adames_all_pitches.csv')
kk20all <- read_csv('kiermaier_all_pitches.csv')
mz20all <- read_csv('zunio_all_pitches.csv')

tg20all <- read.csv('glasnow_all_pitches.csv')


#dodgers lineup
mb20all <- read_csv('betts_all_pitches.csv')
cs20all <- read_csv('seager_all_pitches.csv')
jt20all <- read_csv('turner_all_pitches.csv')
mm20all <- read_csv('muncy_all_pitches.csv')
ws20all <- read_csv('smith_all_pitches.csv')
cb20all <- read_csv('bellinger_all_pitches.csv')
ct20all <- read_csv('taylor_all_pitches.csv')
ap20all <- read_csv('pollock_all_pitches.csv')
ab20all <- read_csv('barnes_all_pitches.csv')

wb20all <- read_csv('buehler_all_pitches.csv')

#####
# functions #

'%notin%' <- Negate('%in%')

xwoba <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null') %>% 
    filter(estimated_woba_using_speedangle != 'null')
  
  x$plate_x <- as.numeric(x$plate_x)
  x$plate_z <- as.numeric(x$plate_z)
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax= sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_summary_2d(aes(z = as.numeric(estimated_woba_using_speedangle)), binwidth = .3,  alpha = .8) +
    scale_fill_gradient(low = 'blue', high = 'green') +
    labs(fill = 'xwoba') +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  px
}

allswings <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null') %>% 
    filter(type != 'B' & description != 'called_strike' & description != 'foul_bunt')
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax = sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_density_2d_filled(contour_var = 'count', alpha = .6) +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = 'none')
  px
}

swingandmiss <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null') %>% 
    filter(description %in% sm)
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax = sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_density_2d_filled(contour_var = 'count', alpha = .6) +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  px
}

xwobafb <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null' & estimated_woba_using_speedangle != 'null') %>% 
    filter(pitch_type %in% fb)
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax = sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_summary_2d(aes(z = as.numeric(estimated_woba_using_speedangle)), binwidth = .3,  alpha = .7) +
    scale_fill_gradient(low = 'blue', high = 'green') +
    labs(fill = 'xwoba') +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  px
}

xwobabb <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null' & estimated_woba_using_speedangle != 'null') %>% 
    filter(pitch_type %in% bb) 
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax = sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_summary_2d(aes(z = as.numeric(estimated_woba_using_speedangle)), binwidth = .3,  alpha = .7) +
    scale_fill_gradient(low = 'blue', high = 'green') +
    labs(fill = 'xwoba') +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  px
}

smfb <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null') %>% 
    filter(description %in% sm) %>% 
    filter(pitch_type %in% fb)
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax = sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_density_2d_filled(contour_var = 'count', alpha = .6) +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  px
}

smbb <- function(x,y) {
  x <- x %>% 
    filter(plate_x != 'null') %>% 
    filter(description %in% sm) %>% 
    filter(pitch_type %in% bb)
  
  sztop <- mean(x$sz_top)
  szbot <- mean(x$sz_bot)
  
  px <- ggplot(x, aes(x = plate_x, y = plate_z)) +
    annotation_raster(img, ymin = szbot, ymax = sztop, xmin = -0.7083333, xmax = 0.7083333) +
    stat_density_2d_filled(contour_var = 'count', alpha = .6) +
    ggtitle(y) +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank())
  px
}

#####
# ji-man 20 xwoba #

xwoba(jm20all,'Ji-Man 2020 xwoba by pitch location')

#####
# ji-man 20 bb xwoba #

xwobabb(jm20all,'Ji-Man 2020 xwoba by pitch location (bb only)')

#####
# ji-man 20 fb xwoba #

xwobafb(jm20all, 'Ji-Man 2020 xwoba by pitch location (fb only)')

#####
# ji-man 20 swings #

allswings(jm20all,'Ji-Man all 2020 swings by pitch location')

#####
# joi-man 20 sm # 

swingandmiss(jm20all, 'Ji-Man 2020 swing and misses by pitch location')

#####
# 
