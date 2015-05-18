# in case this package was not loaded in authentication script
install.packages("twitteR")

# collect user info
## input: username
## output: user info including username, description, tweet number, follower number
userInfo <- function(username) {
  
  # get user info
  user <- getUser(username)
  userinfo <- c(user$screenName, user$name, user$description, user$statusesCount, user$followersCount)
  
  userinfo
}

# collect user info in a batch and save it in a csv file
userInfos <- function(usernames, nameOfFile) {
  # load library and OAuth
  library(twitteR)
  load("my_oauth")
  registerTwitterOAuth(my_oauth)
  # prepare the data frame
  allUsers <- data.frame(as.list(userInfo(usernames[1])), stringsAsFactors=FALSE)
  names(allUsers) <- c('ScreenName', 'Name', 'Description', 'TweetNumber', 'FollowerNumber')
  # add all users into the data frame
  count = length(usernames)
  i = 2
  while (i <= count) {
    allUsers <- rbind(allUsers, userInfo(usernames[i]))
    i = i + 1
  }
  
  # write the result into csv file
  filename <- paste(nameOfFile, "csv", sep=".")
  write.csv(allUsers, file = filename)
  
}
