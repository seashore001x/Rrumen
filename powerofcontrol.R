calcPowerForRCT <- function(alpha,piT,piC,n)
{
  qalpha <- qnorm(p=1-(alpha/2))
  pi0 <- (piT + piC)/2
  denominator <- 2 * pi0 * (1 - pi0)
  fraction <- n/denominator
  qgamma <- (abs(piT - piC) * sqrt(fraction)) - qalpha
  gamma <- pnorm(qgamma)
  print(paste("Power for the randomised controlled trial = ",gamma))
}
