#' @title Yasso15 wrapper
#'
#' @description
#' Yasso15 wrapper around the FORTRAN rutine
#'
#' @param time time interval in years
#' @param climate a 3 element vector with climate parameters: mean temperature (°C), accumulated precipitition (mm), and mean difference between min and max monthly temperature(°C)
#' @param init 5 element vector with initial carbon quantities in each chemical pool
#' @param b 5 element vector with yearly litter input to each chemical pool
#' @param d litter diameter if needed
#' @param steady weather to calculate the steady state. If true it ignores "time" parameter and loops until the carbon in chemical pools stabilizes
#' @return a vector with three elements:
#' @examples
#' time = 5
#' climate = c(10,700,10)
#' init = c(10,10,10,10,10)
#' b = c(2,2,2,2,2)
#' d = 0
#' steady = F
#'
#' yasso.15(time,climate,init,b,d,steady)
#'
#' @rdname yasso15_wrapper
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export

yasso.15 = function(time,climate,init,b,d,steady){
  xt = c(0,0,0,0,0)
  theta = as.numeric(thetas[1])
  leac = 0
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
#' @param steady weather to calculate the steady state. If true it ignores "time" parameter and loops until the carbon in chemical pools stabilizes
#' @return a vector with three elements:
#' @examples
#' time = 5
#' climate = c(10,700,10)
#' init = c(10,10,10,10,10)
#' b = c(2,2,2,2,2)
#' d = 0
#' steady = F
#'
#' yasso.15.se(time,climate,init,b,d,steady)
#'
#' @rdname yasso15_wrapper
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export

yasso.15.se = function(time,climate,init,b,d,steady){
  # to get confidence intervals run the model for all 10000 sets of theta paramaters
  yasso.out.matrix = matrix(NA,nrow(thetas),5)
  for (i in 1:nrow(thetas)){
    yasso.out.matrix[i,] = yasso.15(as.numeric(thetas[i]),time,climate,init,b,d,leac,steady)
  }
  return(colSds(yasso.out.matrix))
}

# load the dlls
loadDLLs = function(){
  dyn.load(system.file("dlls", "libgcc_s_seh-1.dll", package = "yasso15"))
  dyn.load(system.file("dlls", "libquadmath-0.dll", package = "yasso15"))
  dyn.load(system.file("dlls", "libwinpthread-1.dll", package = "yasso15"))
  dyn.load(system.file("dlls", "libgfortran-4.dll", package = "yasso15"))
  dyn.load(system.file("dlls", "yasso15.dll", package = "yasso15"))
}
