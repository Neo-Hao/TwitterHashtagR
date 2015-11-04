# collect tweets for a single user

## input: username, numberofTweets, saveAsCSV, filterString
### saveAsCSV (optional): a boolean value: TRUE or FALSE
### filterString (optional): help filter out strings that don't contain specified text

## output: if saveAsCSV == TRUE, csv file with the same name as username; else a data frame

tweetCollectByUser <- function(username, numberOfTweets, saveAsCSV = FALSE, filterString = NULL) {
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
  
  if (saveAsCSV == TRUE) {
    filename <- paste(username, "csv", sep=".")
    write.csv(tweets, file = filename)
  } else {
    tweets
  }
}

# collect tweets of several users
## input: inputFileName, outputFileName, filterString
### inputFileName --- a file generated from function usersInfo in collectUsers.R
### colNumberOfText -- the number of the column that contains texts
### outputFileName --- the name of output file
### filterString (optional): help filter out strings that don't contain specified text

## output: csv file named as outputFileName 
tweetCollectByAllUser <- function(inputFileName, colNumberOfText, outputFileName, filterString = NULL) {
  # get the vector of usernames
  filename <- paste(inputFileName, "csv", sep=".")
  users <- read.csv(filename, header = T)
  users <- na.omit(users)
  usernames <- users[,colNumberOfText]
  
  allTweets <- tweetCollectByUser(usernames[1], 500, FALSE, filterString)
  i = 2
  while (i <= length(usernames)) {
    tweets <- tweetCollectByUser(usernames[i], 500, FALSE, filterString)
    allTweets <- rbind(allTweets, tweets)
    i = i + 1
  }
  
  filename <- paste(outputFileName, "csv", sep=".")
  write.csv(allTweets, file = filename)
}

# sample application of functions
usernames <- c("aect", "aace", "siteconf")
tweetCollectByUser("aace", 300, "tweetsOfAace")
tweetCollectByAllUser("three_conferences", 2, "tweets_three_conferences")
