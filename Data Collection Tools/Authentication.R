# TwitterR was updated recently, which cause the change in authentication method
# the following works with the latest version of TwitterR

# load necessary packages
if (require(ROAuth) == FALSE) {
  install.packages("ROAuth")
  library(ROAuth)
}
if (require(twitteR) == FALSE) {
  install.packages("twitteR")
  library(twitteR)
}
if (require(base64enc) == FALSE) {
  install.packages("base64enc")
  library(base64enc)
}
if (require(httpuv) == FALSE) {
  install.packages("httpuv")
  library(httpuv)
}

# consumer key and secret come from twitter
# change the key and secret by the info of your twitter app
consumer_key <- "xxxxx"
consumer_secret <- "xxxxx"

# register function
# input: consumer_key, consumer_secret
register <- function(consumer_key, consumer_secret) {
  # register
  setup_twitter_oauth(consumer_key, consumer_secret)
  ### save the authentication for future use
  ## Setting working folder
  # From windows machine in lab computer:
  # setwd("D:\\R\\")
  # From Mac computer, something like ~/Dropbox/
  # setwd(folder_location)
  # save the authentication token
  # save(my_oauth, file="my_oauth")
}

register(consumer_key, consumer_secret)
