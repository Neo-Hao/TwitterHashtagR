# collect tweets by username and save result in a csv file
## input: username, number Of Tweets, name Of File, filterString
## output: a csv file in the working directory
tweetCollectByUser <- function(username, numberOfTweets, nameOfFile, filterString = NULL) {
  # get tweets of a user
  tweets <- userTimeline(username, numberOfTweets, filterString)
  
  # convert searchtwitter research into dataframe
  tweets <- twListToDF(tweets)
  # get rid of stupid emoticons
  tweets$text <- sapply(tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
  
  # optional data cleaning
  # if you want full results, please don't run the code in this section
  tweets <- subset(tweets, is.na(tweets$replyToSN))
  tweets <- data.frame(tweets$screenName, tweets$text, tweets$favoriteCount, tweets$retweetCount)
  
  # optional filter: if the tweet text contrains filterString, true; else false
  tweets$flag <- grepl(filterString, tweets$tweets.text)
  
  # optional data subset
  tweets <- tweets[which(tweets$flag == TRUE),]
  
  # write the result into csv file
  filename <- paste(nameOfFile, "csv", sep=".")
  write.csv(tweets, file = filename)
}

