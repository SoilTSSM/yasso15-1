.onAttach = function(lib, pkg){
  library(data.table)
  library(matrixStats)
  library(skogR)
  # load external binaries
  dyn.load("external\\libgcc_s_seh-1.dll")
  dyn.load("external\\libquadmath-0.dll")
  dyn.load("external\\libwinpthread-1.dll")
  dyn.load("external\\libgfortran-4.dll")
  # load the yasso fortran rutine
  dyn.load("external\\yasso15.dll")

  # yasso theta parameters
  thetas = data.table(read.fwf(file="data\\Yasso15.dat", widths=rep(16,35)))
  turnover = as.matrix(read.csv("data\\turnover.csv"))
  AWEN.fractions = fread("data\\AWEN.csv")
  AWEN.array = array(as.matrix(AWEN.fractions[,c("A","W","E","N")]),dim=c(3,8,4))

  cat("yasso15 v0.1")
}

.onLoad = function(){
  library.dynam('libgcc_s_seh-1.dll', pkg, lib)
  library.dynam('libquadmath-0.dll', pkg, lib)
  library.dynam('libwinpthread-1.dll', pkg, lib)
  library.dynam('libgfortran-4.dll', pkg, lib)
  library.dynam('yasso15.dll', pkg, lib)
}
