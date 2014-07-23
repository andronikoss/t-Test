
generate <- function (N,Number.of.Samples=500, sim=sim) {
  
  if(N == 3){
      x <- c(10, 30, 50)
      #         y <- c(2, 3, 7)
  } else{
      repeat {
          x <- rnorm(N, 45, 18)
          if ((length(which(x<0)))==0){break}
      } 
  }
  
  set.seed(20+sim)
  M <- matrix(NA, Number.of.Samples,  3)
  for (i in 1:Number.of.Samples){
      k <- rep(1,Number.of.Samples)
      y <- 0.2 + 0.13*x + rnorm(k[i]*N, 0, sqrt(2))
      ols <- lm(y ~ x)
      M[i, 1] <- summary(ols)$coef[2,1]
      M[i, 2] <- summary(ols)$coef[2,2]
      M[i, 3] <- ols$df
  }
        return(M)
}
