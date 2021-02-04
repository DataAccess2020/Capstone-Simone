library(rvest)

browseURL("https://www.fantacalcio.it/serie-a/classifica")

standing <- read_html("https://www.fantacalcio.it/serie-a/classifica") %>%
  html_nodes(css = 'table') %>%
  html_table() %>%
  .[[1]]