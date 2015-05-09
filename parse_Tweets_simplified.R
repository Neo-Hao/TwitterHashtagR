# load necessary packages
install.packages("stringr")
install.packages("XML")
library(XML)
library(stringr)


# trim the while leading and tailing space
trim <- function (x) {
  gsub("^\\s+|\\s+$", "", x)
}

# save the clean data in a csv file in the working directory
# input: hashtag -- character, fileLocation -- character, nameOfFile -- character
# output: a csv file in the working directory
getData <- function(hashtag, inputFileName, outputFileName) {
  fileUrl <- inputFileName
  doc <- htmlTreeParse(fileUrl, useInternal= TRUE)
  # get the unchanged tweet content
  tweets.messyContent <- xpathSApply(doc, "//p[@class='TweetTextSize  js-tweet-text tweet-text']", xmlValue)
  # clean up the tweet content
  ## get rid of url if possible
  ## get of the searched hashtag
  reg <- "([a-zA-Z0-9]+://)?([a-zA-Z0-9_]+:[a-zA-Z0-9_]+@)?([a-zA-Z0-9.-]+\\.[A-Za-z]{2,4})(:[0-9]+)?(/.*)?"
  tweets.content <- gsub(pattern = reg, replacement = "", tweets.messyContent, ignore.case = T)
  tweets.content <- gsub(pattern = hashtag, replacement = "", tweets.content, ignore.case = T)
  # trim white space
  tweets.content <- lapply(tweets.content, function(x) trim(x))
  tweets.content <- unlist(tweets.content)
  # merge the data into a dataframe
  data <- data.frame(tweets.messyContent, tweets.content)
  names(data) <- c("Messy text", "text")
  
  # write the result into csv file
  write.csv(data, file = filename)
}
