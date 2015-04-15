install.packages("tm")
library(tm)
install.packages("stringr")
library(stringr)

# convert text vector into a term-Document Matrix
# parameter: text vector
# return term-Document Matrix
termDocumentMatrixConverter <- function(data) {
  # remove non utf-8 characters
  data <- str_replace_all(data,"[^[:graph:]]", " ")
  # convert data to corpus
  data <- Corpus(VectorSource(data))
  # lowercase
  data <- tm_map(data, tolower)
  # remove punctuation
  data <- tm_map(data, removePunctuation)
  # remove stop words
  data <- tm_map(data, function(x) removeWords(x, stopwords()))
  # make sure the data is PlainTextDocument 
  data <- tm_map(data, PlainTextDocument)
  data <- TermDocumentMatrix(data)
  return(data)
}
