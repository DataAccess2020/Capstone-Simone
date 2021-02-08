library(tidyverse)

library(readxl)

fanta_stat <- read_excel("Data/Statistiche_Fantacalcio_2020-21.xlsx")
fanta_ratings <- read_excel("Data/Quotazioni_Fantacalcio.xlsx")

head(fanta_stat)

#Convert row to column names
colnames(fanta_stat) <- as.character(fanta_stat[1, ])
fanta_stat <- fanta_stat[-1,]

fanta_stat <- as.data.frame(fanta_stat)
str(fanta_stat)

colnames(fanta_ratings) <- as.character(fanta_ratings[1, ])
fanta_ratings <- fanta_ratings[-1,]

fanta_ratings <- as.data.frame(fanta_ratings)
str(fanta_stat)

#Convert data frame column to numeric type
fanta_stat[, c(1,5:18)] <- sapply(fanta_stat[, c(1,5:18)], as.numeric)

fanta_ratings[, c(1,5:7)] <- sapply(fanta_ratings[, c(1,5:7)], as.numeric)

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

#Barplot of observations by positions
ggplot(data = fanta_stat) + 
  geom_bar(mapping=aes(x = R))

#Barplot of FantaMedia by positions
ggplot(data = fanta_stat, mapping =
         aes(x = R, y = Mf,
             fill = R)) +
  geom_bar(stat = "identity")


#Coxcomb chart of FantaMedia by positions
ggplot(data = fanta_stat, mapping =
         aes(x = R, y = Mf,
             fill = R)) +
  geom_bar(stat = "identity", width = 1) + 
  coord_polar()

#It seems that defenders make the greatest contribution to the score, followed by midfielders,
#forwards and goalkeepers. The result could be related to the number of observations by positions
#and to the formations, which usually make use of more defenders and midfielders in the 11th.