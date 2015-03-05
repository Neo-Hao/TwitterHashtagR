# in case this package was not loaded in authentication script
install.packages("twitteR")

# collect tweets by username and save result in a csv file
## input: hastag -- character, numberOfTweets -- numeric, nameOfFile -- character
## output: a csv file in the working directory
tweetCollectByUser <- function(username, numberOfTweets, nameOfFile) {
  # get tweets of a user
  tweets <- userTimeline(username, numberOfTweets)
  
  # convert searchtwitter research into dataframe
  tweets <- twListToDF(tweets)
  
  # optional data cleaning
  # if you want full results, please don't run the code in this section
  tweets <- subset(tweets, is.na(tweets$replyToSN))
  tweets <- data.frame(tweets$screenName, tweets$text, tweets$favoriteCount, tweets$retweetCount)
  
  # write the result into csv file
  filename <- paste(nameOfFile, "csv", sep=".")
  write.csv(tweets, file = filename)
}
