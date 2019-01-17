#' @title Yasso15 wrapper
#'
#' @description
#' Yasso15 wrapper around the FORTRAN rutine
#' @param theta the yasso model parameter values. default values if omited
#' @param time time interval in years
#' @param climate a 3 element vector with climate parameters: mean temperature (°C), accumulated precipitition (mm), and mean difference between min and max monthly temperature(°C)
#' @param init 5 element vector with initial carbon quantities in each chemical pool
#' @param b 5 element vector with yearly litter input to each chemical pool
#' @param d litter diameter if needed
#' @param leac leach parameter, default = 0
#' @param steady weather to calculate the steady state. If true it ignores "time" parameter and loops until the carbon in chemical pools stabilizes
#' @return a vector with 5 elements representing the carbon quantities in each chemical pool
#' @examples
#' time = 5
#' climate = c(10,700,10)
#' init = c(10,10,10,10,10)
#' b = c(2,2,2,2,2)
#' d = 0
#' steady = F
#'
#' yasso.15(time=time,climate=climate,init=init,b=b,d=d,steady=steady)
#'
#' @rdname yasso15_wrapper
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export

yasso.15 = function(theta,time,climate,init,b,d,leac,steady){
  xt = c(0,0,0,0,0)
  if (missing(theta)){theta = thetas[1,]}
  if (missing(leac)){leac = 0}
  mod5c.res = .Fortran("mod5c",as.double(theta),as.double(time),as.double(climate),as.double(init),as.double(b),as.double(d),as.double(leac),as.double(xt),as.logical(steady),PACKAGE="yasso15")
  mod5c.res[[8]]
}

#' @title Yasso15 error
#'
#' @description
#' Calculates the error of soil carbon prediction due to errors in the model parameters
#'
#' @param time time interval in years
#' @param climate a 3 element vector with climate parameters: mean temperature (°C), accumulated precipitition (mm), and mean difference between min and max monthly temperature(°C)
#' @param init 5 element vector with initial carbon quantities in each chemical pool
#' @param b 5 element vector with yearly litter input to each chemical pool
#' @param d litter diameter if needed
#' @param leac leach parameter, default = 0
#' @param steady weather to calculate the steady state. If true it ignores "time" parameter and loops until the carbon in chemical pools stabilizes
#' @return a vector with 5 elements representing the carbon quantities in each chemical pool
#' @examples
#' time = 5
#' climate = c(10,700,10)
#' init = c(10,10,10,10,10)
#' b = c(2,2,2,2,2)
#' d = 0
#' steady = F
#'
#' yasso.15.se(time=time,climate=climate,init=init,b=b,d=d,steady=steady)
#'
#' @rdname yasso15_se
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export

yasso.15.se = function(time,climate,init,b,d,steady){
  # to get confidence intervals run the model for all 10000 sets of theta parameters
  yasso.out.matrix = apply(thetas,1,yasso.15,time=time,climate=climate,init=init,b=b,d=d,steady=steady)
  apply(yasso.out.matrix,1,sd)
}
