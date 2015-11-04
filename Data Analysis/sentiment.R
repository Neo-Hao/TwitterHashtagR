
sentiment <- function(inputFileName, textColNumber, outputFileName, lexicon = "lexicon.csv") {
  # loading lexicon of positive and negative words
  lexicon <- read.csv(lexicon, stringsAsFactors = F)
  pos.words <- lexicon$word[lexicon$polarity == "positive"]
  neg.words <- lexicon$word[lexicon$polarity == "negative"]
  # read data
  data <- read.csv(inputFileName, header = T, stringsAsFactors = F)
  data <- data[,textColNumber]
  len <- length(data)
  # list
  data <- strsplit(data, " ")
  # prep data frame
  newData <- data.frame(matrix(NA, nrow = len, ncol = 3))
  names(newData) <- c("Positive", "Negative", "Neutral")
  # prep ratio
  pros.ratio <- 0
  neg.ratio <- 0
  neu.ratior <- 0
  # calculate ratio
  for (i in 1:len) {
    if (length(data[[i]]) == 0) {
      next
    }
    # count for pros and neg
    pros.count <- 0
    neg.count <- 0
    
    # prep the tables
    table.unique <- unique(data[[i]])
    table.count <- table(data[[i]])
    
    for (j in 1:length(table.unique)) {
      if (table.unique[j]  %in% pos.words) {
        pros.count <- pros.count + table.count[table.unique[j]]
      }
      
      if (table.unique[j]  %in% neg.words) {
        neg.count <- neg.count + table.count[table.unique[j]]
      }
    }
    
    # calculate ratio
    pros.ratio <- 100 * as.integer(pros.count) / length(data[[i]])
    neg.ratio <- 100 * as.integer(neg.count) / length(data[[i]])
    neu.ratior <- 100 - pros.ratio - neg.ratio
    # save data
    newData[i,][,1] <- pros.ratio
    newData[i,][,2] <- neg.ratio
    newData[i,][,3] <- neu.ratior
  }
  
  # write the result into csv file
  outputFileName <- paste(outputFileName, "csv", sep=".")
  write.csv(newData, file = outputFileName)
}
