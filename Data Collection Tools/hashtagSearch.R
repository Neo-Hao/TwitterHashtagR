# collect tweets by hashtag and save result in a csv file
## input: hastag -- character, numberOfTweets -- numeric, nameOfFile -- character
## output: a csv file in the working directory
tweetCollect <- function(hashtag, numberOfTweets, nameOfFile) {
  # search tweets by hashtag
  tweets <- searchTwitter(hashtag, n = numberOfTweets)
#   # search tweets by hashtag/ This part no longer works
#   if(.Platform$OS.type == "unix") {
#     tweets <- searchTwitter(hashtag, n = numberOfTweets)
#   } else {
#     tweets <- searchTwitter(hashtag, n = numberOfTweets, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
#   }
  
  # convert searchtwitter research into dataframe
  tweets <- twListToDF(tweets)
  # write the result into csv file
  filename <- paste(nameOfFile, "csv", sep=".")
  write.csv(tweets, file = filename)
}

# sample application of functions
tweetCollect("#sarcastic", 100, "sarcastic")
