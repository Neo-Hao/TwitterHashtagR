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
usersInfo <- function(usernames, nameOfFile) {
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

# sample application of functions
userInfo("aect")

usernames <- c("aect", "AERA_EdResearch", "siteconf")
usersInfo(usernames, "three_conferences")
