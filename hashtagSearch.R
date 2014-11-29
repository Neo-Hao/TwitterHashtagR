# in case this package was not loaded in authentication script
install.packages("twitteR")

# collect tweets by hashtag and save result in a csv file
## input: hastag -- character, numberOfTweets -- numeric, nameOfFile -- character
## output: a csv file in the working directory
tweetCollect <- function(hashtag, numberOfTweets, nameOfFile) {
  # load library and OAuth
  library(twitteR)
  load("my_oauth")
  registerTwitterOAuth(my_oauth)
  
  # search tweets by hashtag
  if(.Platform$OS.type == "unix") {
    tweets <- searchTwitter(hashtag, n = numberOfTweets)
  } else {
    tweets <- searchTwitter(hashtag, n = numberOfTweets, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
  }
  
  # convert searchtwitter research into dataframe
  tweets <- twListToDF(tweets)
  # write the result into csv file
  filename <- paste(nameOfFile, "csv", sep=".")
  write.csv(tweets, file = filename)
}
