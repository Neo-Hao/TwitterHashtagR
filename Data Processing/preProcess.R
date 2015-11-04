
# stop words

## input: inputFileName, textColNumber, outputFileName
### inputFileName: the text file to be processed
### textColNumber: the number of column that contains texts
### outputFileName: the name of output file

removeStopWords <- function(inputFileName, textColNumber, outputFileName, stopWordsFileName = "stopwords.csv") {
  # prepare stop word vector
  stopWords <- read.csv(stopWordsFileName, header = T, colClasses= "character")
  stopWords <- stopWords$words
  # read in data
  data <- read.csv(inputFileName, header = T, colClasses= "character")
  data <- data[,textColNumber]
  # delete stop words
  len <- length(data)
  data <- strsplit(data, " ")
  for (i in 1:len) {
    if (length(data[[i]]) <= 0) {
      next
    }
    for (j in 1:length(data[[i]])) {
      if (data[[i]][j] %in% stopWords) {
        data[[i]][j] = ""
      }
    }
  }
  # delete blanks spaces
  for (i in 1:len) {
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

