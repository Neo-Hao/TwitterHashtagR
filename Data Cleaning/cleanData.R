# load necessary packages
if (require(stringr) == FALSE) {
  install.packages("stringr")
  library(stringr)
}

# save the clean data in a csv file in the working directory
# input: hashtag -- character, fileLocation -- character, nameOfFile -- character
# output: a csv file in the working directory
cleanData <- function(inputFileName, textColNumber, outputFileName, hashtag = "") {
  data <- read.csv(inputFileName, header = T)
  data <- data[,textColNumber]
  len <- length(data)
  # lowercase
  data <- tolower(data)
  
  ## delete url if possible
  reg <- "([a-zA-Z0-9]+://)?([a-zA-Z0-9_]+:[a-zA-Z0-9_]+@)?([a-zA-Z0-9.-]+\\.[A-Za-z]{2,4})(:[0-9]+)?(/.*)?"
  data <- gsub(pattern = reg, replacement = "", data, ignore.case = T)
  ## delete <...>
  reg <- "<u\\+([a-zA-Z0-9]+)>"
  data <- gsub(pattern = reg, replacement = "", data, ignore.case = T)
  ## delete anything start with @
  reg <- "@([a-zA-Z0-9]+)?"
  data <- gsub(pattern = reg, replacement = "", data, ignore.case = T)
  # delete rt
  reg <- "rt"
  data <- gsub(pattern = reg, replacement = "", data, ignore.case = T)
  ## delete the searched hashtag
  data <- gsub(pattern = "#sarcastic", replacement = "", data, ignore.case = T)
  ## delete # 
  data <- gsub(pattern = "#", replacement = "", data, ignore.case = T)
  
  ## delete non-word character
  data <- strsplit(data, "\\W")
  
  ## delete blanks spaces
  for (i in 1:length(data)) {
    not.blanks <- which(data[[i]] != "")
    data[[i]] <- data[[i]][not.blanks]
    # turn each item into a str
    data[[i]] <- paste(data[[i]], collapse = ' ')
  }
  
  ## new data
  newData <- data.frame(matrix(NA, nrow = len, ncol = 1))
  for (i in 1:len) {
    newData[i,] <- data[[i]]
  }
  
  # write the result into csv file
  outputFileName <- paste(outputFileName, "csv", sep=".")
  write.csv(newData, file = outputFileName)
}

# sample application
cleanData("sarcastic.csv", 2, "sarcastic_cleaned", "#sacarstic")
