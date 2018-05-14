#' @title Yasso15 wrapper
#'
#' @description
#' Yasso15 wrapper around the FORTRAN rutine
#'
#' @param theta yasso15 model parameters
#' @param time time interval in years
#' @param climate a 3 element vector with climate parameters: mean temperature (°C), accumulated precipitition (mm), and mean difference between min and max monthly temperature(°C)
#' @param init 5 element vector with initial carbon quantities in each chemical pool
#' @param b 5 element vector with yearly litter input to each chemical pool
#' @param d litter diameter if needed
#' @param leac leaching parameter
#' @param steady weather to calculate the steady state. If true it ignores "time" parameter and loops until the carbon in chemical pools stabilizes
#' @return a vector with three elements:
#' @details Uses the webservice provided by https://frost.met.no/. Climate data is fetched from the nearest weather station.
#' @examples
#' theta = as.numeric(thetas[1])
#' time = 5
#' climate = c(10,700,10)
#' init = c(10,10,10,10,10)
#' b = c(2,2,2,2,2)
#' d = 0
#' leac = 0
#' steady = F
#'
#' yasso.out = yasso.15(theta,time,climate,init,b,d,leac,xt,steady)
#' yasso.out.se = yasso.15.se(thetas,time,climate,init,b,d,leac,xt,steady)

#' @rdname yasso15_wrapper
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export

yasso.15 = function(theta,time,climate,init,b,d,leac,steady){
  xt = c(0,0,0,0,0)
  mod5c.res = .Fortran("mod5c",as.double(theta),as.double(time),as.double(climate),as.double(init),as.double(b),as.double(d),as.double(leac),as.double(xt),as.logical(steady),PACKAGE="yasso15")
  mod5c.res[[8]]
}

# model error function
yasso.15.se = function(thetas,time,climate,init,b,d,leac,steady){
  # to get confidence intervals must run for the 10000 theta paramaters
  yasso.out.matrix = matrix(NA,nrow(thetas),5)
  for (i in 1:nrow(thetas)){
    yasso.out.matrix[i,] = yasso.15(as.numeric(thetas[i]),time,climate,init,b,d,leac,steady)
  }
  return(colSds(yasso.out.matrix))
}
