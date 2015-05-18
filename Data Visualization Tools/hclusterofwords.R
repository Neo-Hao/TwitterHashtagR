# input: the prepared term document matrix
# output: h-cluster of the words in input

hclusterofwords <- function(data) {
  # Remove sparse terms
  data.trial <-removeSparseTerms(data, sparse=0.92)
  # make the names of each doc different: from 1 to length(data)
  data.trial$dimnames$Docs <- seq(1:length(data))
  # change the type of names from numeric to character
  # otherwise the conversion from term-doc matrix to matrix will fail
  data.trial$dimnames$Docs <- as.character(data.trial$dimnames$Docs)
  # convert term-doc matrix to matrix
  data.m <- as.matrix(data.trial)
  # convert matrix to data frame
  data.fm <- as.data.frame(data.m)
  # scale the data frame
  data.fm <- scale(data.fm)
  # h-cluster
  data.cluster <- hclust(dist(data.fm, method = "euclidean"), method = "ward.D2")
  # plot h-cluster
  plot(data.cluster)
  return (data.cluster)
}
