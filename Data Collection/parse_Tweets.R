# load necessary packages
if (require(stringr) == FALSE) {
  install.packages("stringr")
  library(stringr)
}
if (require(XML) == FALSE) {
  install.packages("XML")
  library(XML)
}


# trim the white leading and tailing space
trim <- function (x) {
  gsub("^\\s+|\\s+$", "", x)
}


# save the clean data in a csv file in the working directory
# input: hashtag -- character, fileLocation -- character, nameOfFile -- character
# output: a csv file in the working directory
getData <- function(hashtag, inputFileName, outputFileName) {
  fileUrl <- inputFileName
  doc <- htmlTreeParse(fileUrl, useInternal= TRUE)
  rootNode <- xmlRoot(doc)
  # get the unchanged tweet content
  tweets.messyContent <- xpathSApply(rootNode, "//p[@class='TweetTextSize  js-tweet-text tweet-text']", xmlValue)
  
  # merge the data into a dataframe
  data <- data.frame(tweets.messyContent)
  names(data) <- c("Messy text")
  
  # write the result into csv file
  write.csv(data, file = outputFileName)
}


# save the clean data in a csv file in the working directory
# input: hashtag -- character, fileLocation -- character, nameOfFile -- character
# output: a csv file in the working directory
getData <- function(hashtag, inputFileName, outputFileName) {
  fileUrl <- inputFileName
  doc <- htmlTreeParse(fileUrl, useInternal= TRUE)
  rootNode <- xmlRoot(doc)
  # get the unchanged tweet content
  tweets.messyContent <- xpathSApply(rootNode, "//p[@class='TweetTextSize  js-tweet-text tweet-text']", xmlValue)
  # clean up the tweet content
  ## get rid of url if possible
  reg <- "([a-zA-Z0-9]+://)?([a-zA-Z0-9_]+:[a-zA-Z0-9_]+@)?([a-zA-Z0-9.-]+\\.[A-Za-z]{2,4})(:[0-9]+)?(/.*)?"
  tweets.content <- gsub(pattern = reg, replacement = "", tweets.messyContent, ignore.case = T)
  ## get of the searched hashtag
  tweets.content <- gsub(pattern = hashtag, replacement = "", tweets.content, ignore.case = T)
  # trim white space
  tweets.content <- lapply(tweets.content, function(x) trim(x))
  tweets.content <- unlist(tweets.content)
  
  # tweet time
  tweet.time <- xpathSApply(rootNode, "//span[@class='_timestamp js-short-timestamp ']", xmlValue)
  # retweet number
  retweet <- xpathSApply(rootNode,
                        "//button[@class='ProfileTweet-actionButton  js-actionButton js-actionRetweet']//span[@class='ProfileTweet-actionCountForPresentation']",
                        xmlValue)
  # favor
  favored <- xpathSApply(rootNode,
                        "//button[@class='ProfileTweet-actionButton js-actionButton js-actionFavorite']//span[@class='ProfileTweet-actionCountForPresentation']",
                        xmlValue)
  
  # merge the data into a dataframe
  data <- data.frame(tweets.messyContent, tweets.content, tweet.time, retweet, favored)
  names(data) <- c("Messy text", "text", "time", "retweet", "favor")
  
  # write the result into csv file
  write.csv(data, file = outputFileName)
}


# sample application of functions
getData("AECT15", "#aect15 - Twitter Search.html", "AECT15.csv")

