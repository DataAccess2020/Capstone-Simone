install.packages("rtweet")
install.packages("httpuv")

library(rtweet)
library(httpuv)

attanasio <- rtweet::search_tweets(
  q = "attanasio",
  n = 100,
  type = "recent",
  include_rts = FALSE,
  parse = TRUE,
  verbose = TRUE)

#cleaning <- delete the variables unuseful 

#Analysing screen_name
users.name <- table(attanasio$screen_name)

users.nameSorted <- sort(users.name, decreasing = TRUE)
head(users.nameSorted)

#Info about most active users

active.users <- lookup_users(c("saolvatore", "MaleficoRojo", "marianna_eg", "Raffael14504018"))
active.usersCount <- active.users[,c("screen_name", "followers_count")]
head(active.usersCount)

#Most active users arranged by followers

library(dplyr)
active.userFollow <- active.usersCount %>%
  arrange(desc(followers_count))

#ReTweet
attanasioTxtRt <- attanasio[, c("text", "retweet_count")]
attanasioTxtRtSort <- attanasioTxtRt %>% arrange(desc(retweet_count))
#Unique ReTweet
attanasio_tweet_unici <- unique(attanasioTxtRtSort, by = "text")

#Plot discussion
ts_plot(attanasio, by = "hours", color = "blue")

#Saving text column as dataframe
attanasio.text <- attanasio$text
head(attanasio.text)

#Removing url from text
install.packages("qdapRegex")
library(qdapRegex)
attanasio_nourl <- rm_twitter_url(attanasio.text)
head(attanasio_nourl, 5)

#Removing special characters
attanasio_nosp <- gsub("[^A-Za-z]", " ", attanasio_nourl)
head(attanasio_nosp, 5)

#Converting text in corpus
install.packages("tm")
library(tm)
attanasio_corpus <- attanasio_nosp %>%
  VectorSource() %>%
  Corpus()
attanasio_corpus[[3]]$content

#Converting text in minuscolo
attanasio_min <- tm_map(attanasio_corpus, tolower)
attanasio_min[[3]]$content

#Removing stop words
stopwords("it")
attanasio_nostwo <- tm_map(attanasio_min, removeWords, stopwords("it"))
attanasio_nostwo[[3]]$content

#Removing white spaces
attanasio_final <- tm_map(attanasio_nostwo, striWhitespace) #not working
covid19final[[3]]$content

#Word frequency
#install.packages("rJava")
library(rJava)
#install.packages("qdap")
library(qdap)
freq_attanasio <- freq_terms(attanasio_nostwo, 40)
head(freq_attanasio, 40)

#Popular words
top50term <- subset(freq_attanasio, freq_attanasio$FREQ > 5)
head(top50term)

#Plot the popular words 
library(ggplot2)
ggplot(top50term, aes(x = reorder(WORD, -FREQ), y = FREQ)) +
  geom_bar(stat = "identity", fill = "cadetblue3") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Termini") + ylab("Frequenza") +
  labs(title = "Termini con frequenza maggiore di 5")

library(wordcloud) #not working
wordcloud(freq_attanasio, scale = c(3, 0.5), min.freq = 5, colors = "blue", random.order = FALSE)

#creazione di una document term matrix
library(tm)
DTM <- DocumentTermMatrix(covid91_final)
inspect(DTM)

right_tot <- apply(DTM, 1, sum)
covid19_dtm <- DTM[totale_righe> 0, ]


#costruzione topic modeling
install.packages("topicmodels")
library(topicmodels)
covid19_lda <- LDA(covid19_dtm, k = 6)
#visualizzazione 10 termini più diffusi nel topic modeling
top_10 <- terms(covid_19_lda, 10)
top_10


#Sentiment analysis
install.packages("syuzhet")
library(syuzhet)
attanasio_value <- get_nrc_sentiment(attanasio_nosp)

#calcolo somma sentiment
counting <- colSums(attanasio_value[, ])
#conversione punteggio in dataframe
counting_df <- data.frame(counting)
head(counting_df)

countingDEF <- cbind(sentiment = row.names(counting_df), counting_df, row.names = NULL)
countingDEF

library(ggplot2)
ggplot(countingDEF, aes(x = sentiment, y = counting, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Sentiment Analysis Attentato")
