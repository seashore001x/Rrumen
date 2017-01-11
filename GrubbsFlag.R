library(outliers)
# comparing the value of vectors element-wise
# BTW, what a stupid looping!
match_allequal <- function(x, y){
  Logical_i <- FALSE
  for(i in 1:length(y)){
    Logical_j <- NULL
    for( j in 1:length(x)){
      Logical_j <- c(Logical_j, isTRUE(all.equal(x[j], y[i])))
    }
    Logical_i <- Logical_j|Logical_i
  }
  return (Logical_i)
}
  
#flags the outliers
GrubbsFlag <- function(x) {
  outliers <- NULL
  test <- x
  grubbs.result <- grubbs.test(test)
  pv <- grubbs.result$p.value
  while(pv < 0.05) {
    outliers <- c(outliers, as.numeric(strsplit(grubbs.result$alternative, " ")[[1]][3]))
    test <- x[!match_allequal(x, outliers)]
    grubbs.result <- grubbs.test(test)
    pv <- grubbs.result$p.value
  }
  return(data.frame(X = x, Outlier = match_allequal(x, outliers)))
}



