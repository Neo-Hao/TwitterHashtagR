# TwitterR was updated recently, which cause the change in authentication method
# the following works with the latest version of TwitterR

# load necessary packages
install.packages("ROAuth")
library(ROAuth)
install.packages("twitteR")
library(twitteR)

# consumer key and secret come from twitter
# remember to set callback URL of your twitter app as http://127.0.0.1:1410
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
