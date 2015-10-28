# input: the prepared data frame
# output: h-cluster of the words in input

hclusterofwords <- function(data.fm) {
  # scale the data frame
  data.fm <- scale(data.fm)
  # h-cluster
  data.cluster <- hclust(dist(data.fm, method = "euclidean"), method = "ward.D2")
  # plot h-cluster
  plot(data.cluster)
  return (data.cluster)
}

test <- hclusterofwords(data.fm)
