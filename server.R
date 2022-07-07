

### Johns Hopkins Data Science Capstone Final Project
### WORD PREDICTOR GENIE!
## The following code describes the server function of the word prediction app.


## Load packages.

library(tidyverse)
library(stringr)


## Load ngrams.

Bigrams3 <- readRDS("bigrams.rds")
Trigrams3  <- readRDS("trigrams.rds")
Quadgrams3 <- readRDS("quadgrams.rds")
Quintgrams3 <- readRDS("quintgrams.rds")
Sexgrams3 <- readRDS("sextgrams.rds")


## Create Ngram Matching Functions

Bigrams4 <- function(input_words){
  num <- length(input_words)
  filter(Bigrams3,
         word1==input_words[num]) %>%
    top_n(1, n) %>%
    filter(row_number() == 1L) %>%
    select(num_range("word", 2)) %>%
    as.character() -> out
  ifelse(out =="character(0)", "?", return(out))}

Trigrams4 <- function(input_words){
  num <- length(input_words)
  filter(Trigrams3,
         word1==input_words[num-1],
         word2==input_words[num])  %>%
    top_n(1, n) %>%
    filter(row_number() == 1L) %>%
    select(num_range("word", 3)) %>%
    as.character() -> out
  ifelse(out=="character(0)", Bigrams4(input_words), return(out))}

Quadgrams4 <- function(input_words){
  num <- length(input_words)
  filter(Quadgrams3,
         word1==input_words[num-2],
         word2==input_words[num-1],
         word3==input_words[num])  %>%
    top_n(1, n) %>%
    filter(row_number() == 1L) %>%
    select(num_range("word", 4)) %>%
    as.character() -> out
  ifelse(out=="character(0)", Trigrams4(input_words), return(out))}

Quintgrams4 <- function(input_words){
  num <- length(input_words)
  filter(Quintgrams3,
         word1==input_words[num-3],
         word2==input_words[num-2],
         word3==input_words[num-1],
         word4==input_words[num])  %>%
    top_n(1, n) %>%
    filter(row_number() == 1L) %>%
    select(num_range("word", 5)) %>%
    as.character() -> out
  ifelse(out=="character(0)", Quadgrams4(input_words), return(out))}

Sexgrams4 <- function(input_words){
  num <- length(input_words)
  filter(Sexgrams3,
         word1==input_words[num-3],
         word2==input_words[num-2],
         word3==input_words[num-1],
         word4==input_words[num])  %>%
    top_n(1, n) %>%
    filter(row_number() == 1L) %>%
    select(num_range("word", 5)) %>%
    as.character() -> out
  ifelse(out=="character(0)", Quintgrams4(input_words), return(out))}


#Final input and matching function.

ngrams <- function(Query){Query <- data_frame(text = Query)
  Clean1 <- "[^[:alpha:][:space:]]*"
  Query <- Query %>%
  mutate(text = str_replace_all(text, Clean1, ""))
  Count1 <- str_count(Query, boundary("word"))
  input_words <- unlist(str_split(Query, boundary("word")))
  input_words <- tolower(input_words)
  WordAnswer <- ifelse (Count1 == 0, "Enter your phrase query in the left text box.",
              ifelse (Count1 == 1, Bigrams4(input_words),
              ifelse (Count1 == 2, Trigrams4(input_words),
              ifelse (Count1 == 3, Quadgrams4(input_words),
              ifelse (Count1 == 4, Quintgrams4(input_words),
                      Sexgrams4(input_words))))))
  if(WordAnswer == "?"){WordAnswer = "Query cannot be determined, please try another."}
  return(WordAnswer)}

shinyServer(function(input, output){
  output$prediction <- renderPrint({
    WordAnswer <- ngrams(input$inputString)
    WordAnswer})

  output$text1 <- renderText({
    input$inputString});})
