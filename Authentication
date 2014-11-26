# Connect R to Twitter
## input: consumer key & consumer secret
## output: authentication object for registeration use
my_oauth <- function(consumerKey, consumerSecret) {
  # load necessary packages
  install.packages("ROAuth")
  library(ROAuth)
  
  # prepare for authentication
  requestURL <- "https://api.twitter.com/oauth/request_token"
  accessURL <- "https://api.twitter.com/oauth/access_token"
  authURL <- "https://api.twitter.com/oauth/authorize"
  my_oauth <- OAuthFactory$new(consumerKey=consumerKey,
                               consumerSecret=consumerSecret, requestURL=requestURL,
                               accessURL=accessURL, authURL=authURL)
  
  # authenticate in either unix or windows
  if(.Platform$OS.type == "unix") {
    my_oauth$handshake()
  } else {
    my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
  }
  
  # return my_oauth object
  my_oauth
}

# save registeration info to avoid repeating the above steps
## input: oauthentication object, desired folder location
## output: oauthentication token
register <- function(my_oauth, folder_location) {
  # load necessary packages
  install.packages("twitteR")
  library(twitteR)
  # register
  registerTwitterOAuth(my_oauth)
  ### save the authentication for future use
  ## Setting working folder
  # From windows machine in lab computer:
  # setwd("D:\\R\\")
  # From Mac computer, something like ~/Dropbox/
  setwd(folder_location)
  # save the authentication token
  save(my_oauth, file="my_oauth")
}

# connect and register
## input: consumer key & consumer secret, and desired folder location
connectRegistr <- function(consumerKey, consumerSecret, folder_location) {
  oauth <- my_oauth(consumerKey, consumerSecret)
  # fill folder location before running it
  register(oauth, folder_location)
}
