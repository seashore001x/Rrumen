calcSampleSizeForRCT <- function(alpha,gamma,piT,piC,p=0)
{
  # p is the estimated of the likely fraction of losses to follow-up
  qalpha <- qnorm(p=1-(alpha/2))
  qgamma <- qnorm(p=gamma)
  pi0 <- (piT + piC)/2
  numerator <- 2 * ((qalpha + qgamma)^2) * pi0 * (1 - pi0)
  denominator <- (piT - piC)^2
  n <- numerator/denominator
  n <- ceiling(n) # round up to the nearest integer
  # adjust for likely losses to folow-up
  n <- n/(1-p)
  n <- ceiling(n) # round up to the nearest integer
  print(paste("Sample size for each trial group = ",n))
}
