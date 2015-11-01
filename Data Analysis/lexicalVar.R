
# lexical variety - measure 1
richness <- function(inputFileName, textColNumber, outputFileName) {
  # read data
  data <- read.csv(inputFileName, header = T, colClasses = "character")
  data <- data[,textColNumber]
  len <- length(data)
  # calculate lexical variety
  data <- strsplit(data, " ") 
  vars <- vector()
  for (i in 1:len) {
    data.unique <- unique(data[[i]])
    variety <- length(data.unique) / length(data[[i]])
    vars[i] <- variety
  }
  # plot
  plot(vars, 
       type ="b",
       xlab= paste("Personal ID"),
       ylab="Lexical Variety",
       xaxt = "n")
  axis(1, 1:len,
       labels=1:len)
  # write the result into csv file
  outputFileName <- paste(outputFileName, "csv", sep=".")
  write.csv(vars, file = outputFileName)
}

# lexical variety - measure 2
meanWordFrequency <- function(inputFileName, textColNumber, outputFileName) {
  # read data
  data <- read.csv(inputFileName, header = T, colClasses = "character")
  data <- data[,textColNumber]
  len <- length(data)
  # calculate lexical variety
  data <- strsplit(data, " ") 
  vars <- vector()
  for (i in 1:len) {
    data.table <- table(data[[i]])
    variety <- sum(data.table) / length(data.table)
    vars[i] <- variety
  }
  vars <- scale(vars)
  # plot
  plot(vars, 
       type ="h",
       xlab= paste("Personal ID"),
       ylab="Mean Word Frequency",
       xaxt = "n")
  axis(1, 1:len,
       labels=1:len)
  # write the result into csv file
  outputFileName <- paste(outputFileName, "csv", sep=".")
  write.csv(vars, file = outputFileName)
}