## bag of words
bagOfWords <- function(inputFileName, textColNumber) {
  # read data
  data <- read.csv(inputFileName, header = T, colClasses='character')
  data <- (data[,textColNumber])
  # list
  data <- strsplit(data, " ") 
  # unlist
  data <- unlist(data)
  return(data)
}


## plot top X words
plotTopWords <- function(data, number = 5) {
  words.freqTable.sorted <- sort(table(data), decreasing = T)
  words.freqTable.sorted.percentage <- 100 *(words.freqTable.sorted / length(data))
  # plot
  plot(words.freqTable.sorted.percentage[1:number], 
       type ="b",
       xlab= paste("Top words", number, sep=" "),
       ylab="Percentage of Full text",
       xaxt = "n")
  axis(1, 1:number,
       labels=names(words.freqTable.sorted.percentage[1:number]))
}



