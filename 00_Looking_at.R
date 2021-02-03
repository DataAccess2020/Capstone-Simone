library(tidyverse)

library(readxl)

fanta_stat <- read_excel("Data/Statistiche_Fantacalcio_2020-21.xlsx")

head(fanta_stat)

#Convert row to column names
colnames(fanta_stat) <- as.character(fanta_stat[1, ])
fanta_stat <- fanta_stat[-1,]

fanta_stat <- as.data.frame(fanta_stat)
str(fanta_stat)

#Convert data frame column to numeric type
fanta_stat[, c(1,5:18)] <- sapply(fanta_stat[, c(1,5:18)], as.numeric)

#Plotting

#FantaMedia by appearances 
ggplot(data = fanta_stat, mapping =
        aes(x = Pg, y = Mf)) +
  geom_point()

#FantaMedia by player position
ggplot(data = fanta_stat, mapping =
         aes(x = Pg, y = Mf,
             color = R, shape = R)) +
  geom_point() +
  geom_smooth()
# + facet_grid(R~.) #separated

#FantaMedia by player position and by team
ggplot(data = fanta_stat, mapping =
         aes(x = Pg, y = Mf,
             color = R)) + 
  geom_point() + 
  facet_wrap(~Squadra, nrow = 4)
