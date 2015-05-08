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
  # get screen name
  name.screen <- xpathSApply(doc, "//strong[@class='fullname js-action-profile-name show-popup-with-id']", xmlValue)
  # get the userID
  name.username <- xpathSApply(doc, "//span[@class='username js-action-profile-name']", xmlValue)
  # get the unchanged tweet content
  tweets.messyContent <- xpathSApply(doc, "//p[@class='js-tweet-text tweet-text']", xmlValue)
  # check whether the tweet content contains url or picture
  tweets.hasPicture <- str_detect(tweets.messyContent, 'pic.twitter')
  tweets.hasSuperLink <- str_detect(tweets.messyContent, 'http')
  # clean up the tweet content
  ## get rid of url if possible
  ## get of the searched hashtag
  reg <- "([a-zA-Z0-9]+://)?([a-zA-Z0-9_]+:[a-zA-Z0-9_]+@)?([a-zA-Z0-9.-]+\\.[A-Za-z]{2,4})(:[0-9]+)?(/.*)?"
  tweets.content <- gsub(pattern = reg, replacement = "", tweets.messyContent, ignore.case = T)
  tweets.content <- gsub(pattern = hashtag, replacement = "", tweets.content, ignore.case = T)
  # trim white space
  tweets.content <- lapply(tweets.content, function(x) trim(x))
  tweets.content <- unlist(tweets.content)
  # get character count of a tweet
  tweets.count <- lapply(tweets.content, function(x) nchar(x))
  tweets.count <- unlist(tweets.count)
  # get tweet time
  tweets.time <- xpathSApply(doc, "//a[@class='tweet-timestamp js-permalink js-nav js-tooltip']", xmlGetAttr, 'title')
  # get retweet count
  tweets.retweetCount <- xpathSApply(doc, "//span[@class='ProfileTweet-actionCountForPresentation']", xmlValue)
  # get favor count
  tweets.favorCount <- xpathSApply(doc, "//span[@class='ProfileTweet-actionCountForPresentation']", xmlValue)
  # merge the data into a dataframe
  data <- data.frame(name.screen, name.username, tweets.messyContent, tweets.content, tweets.hasPicture, tweets.hasSuperLink, tweets.count, tweets.time, tweets.retweetCount, tweets.favorCount)
  
  # write the result into csv file
  filename <- paste(outputFileName, "csv", sep=".")
  write.csv(data, file = filename)
}
