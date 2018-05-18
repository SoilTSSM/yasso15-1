.onAttach = function(lib, pkg){
  library(data.table)
  library(matrixStats)
  library(skogR)
  # load external binaries
  filepath = paste0(getwd(),"\\data\\libgcc_s_seh-1.dll")
  cat(filepath,": ",file.exists(filepath))

  dyn.load("data\\libgcc_s_seh-1.dll")
  dyn.load("data\\libquadmath-0.dll")
  dyn.load("data\\libwinpthread-1.dll")
  dyn.load("data\\libgfortran-4.dll")
  # load the yasso fortran rutine
  dyn.load("data\\yasso15.dll")

  # yasso theta parameters
  thetas = data.table(read.fwf(file="data\\Yasso15.dat", widths=rep(16,35)))
  turnover = as.matrix(read.csv("data\\turnover.csv"))
  AWEN.fractions = fread("data\\AWEN.csv")
  AWEN.array = array(as.matrix(AWEN.fractions[,c("A","W","E","N")]),dim=c(3,8,4))

  cat("yasso15 v0.1")
}

# .onLoad = function(){
#   library.dynam('libgcc_s_seh-1.dll', pkg, lib)
#   library.dynam('libquadmath-0.dll', pkg, lib)
#   library.dynam('libwinpthread-1.dll', pkg, lib)
#   library.dynam('libgfortran-4.dll', pkg, lib)
#   library.dynam('yasso15.dll', pkg, lib)
# }
