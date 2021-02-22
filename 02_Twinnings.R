library(tidyverse)
library(dplyr)
library(rvest)                                

setwd("/Users/pc/Desktop/Data access/Capstone-Simone/Data")

url <- "https://inchieste.repubblica.it/it/repubblica/rep-it/2014/03/20/news/calcio_la_tifoseria_degli_ultras-81427305/"

download.file(url = url, destfile = "international_twinnings.html")

intern_twin <- read_html("https://inchieste.repubblica.it/it/repubblica/rep-it/2014/03/20/news/calcio_la_tifoseria_degli_ultras-81427305/") %>%                           
  html_node(xpath = '//*[@id="verticale"]/div[1]/table') %>%        
  html_table(fill = TRUE)
