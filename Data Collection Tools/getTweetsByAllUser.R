
tweetCollectByUser <- function(username, numberOfTweets, filterString = NULL) {
  # get tweets of a user
  tweets <- userTimeline(username, numberOfTweets)
  
  # convert searchtwitter research into dataframe
  tweets <- twListToDF(tweets)
  # get rid of stupid emoticons
  tweets$text <- sapply(tweets$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
  
  # optional data cleaning
  # if you want full results, please don't run the code in this section
  tweets <- subset(tweets, is.na(tweets$replyToSN))
  tweets <- data.frame(tweets$screenName, tweets$text, tweets$favoriteCount, tweets$retweetCount)
  
  # optional data subset
  if (length(filterString) > 0) {
    # optional filter: if the tweet text contrains filterString, true; else false
    tweets$flag <- grepl(filterString, tweets$tweets.text)
    # data subset
    tweets <- tweets[which(tweets$flag == TRUE),]
  }

  tweets
}

tweetCollectByAllUser <- function(nameOfFile, columnTitle, filterString) {
  # get the vector of usernames
  filename <- paste(nameOfFile, "csv", sep=".")
  users <- read.csv(filename, header = T)
  users <- na.omit(users)
  usernames <- users[,columnTitle]
  
  allTweets <- tweetCollectByUser(usernames[1], 500, filterString)
  i = 2
  while (i <= length(usernames)) {
    tweets <- tweetCollectByUser(usernames[i], 500, filterString)
    allTweets <- rbind(allTweets, tweets)
    i = i + 1
  }
  
  allTweets
  
}
