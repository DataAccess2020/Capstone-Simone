library(rvest)

browseURL("https://www.fantacalcio.it/serie-a/classifica")

standing <- read_html("https://www.fantacalcio.it/serie-a/classifica") %>%
  html_nodes(css = 'table') %>%
  html_table() %>%
  .[[1]]

home_table <- read_html("https://www.fantacalcio.it/serie-a/classifica") %>%
  html_nodes(css = 'table') %>%
  html_table() %>%
  .[[2]]

away_table <- read_html("https://www.fantacalcio.it/serie-a/classifica") %>%
  html_nodes(css = 'table') %>%
  html_table() %>%
  .[[3]]

top_scorers <- read_html("https://www.fantacalcio.it/serie-a/classifica") %>%
  html_nodes(css = 'table') %>%
  html_table() %>%
  .[[4]]