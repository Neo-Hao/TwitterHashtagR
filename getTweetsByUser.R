# in case this package was not loaded in authentication script
install.packages("twitteR")

# collect tweets by username and save result in a csv file
## input: hastag -- character, numberOfTweets -- numeric, nameOfFile -- character
## output: a csv file in the working directory
tweetCollectByUser <- function(username, numberOfTweets, nameOfFile) {
  # load library and OAuth
  library(twitteR)
  load("my_oauth")
  registerTwitterOAuth(my_oauth)
  
  # get tweets of a user
  tweets <- userTimeline(username, numberOfTweets)
  
  # convert searchtwitter research into dataframe
  tweets <- twListToDF(tweets)
  # write the result into csv file
  filename <- paste(nameOfFile, "csv", sep=".")
  write.csv(tweets, file = filename)
}
