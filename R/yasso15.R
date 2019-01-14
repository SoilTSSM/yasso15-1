.onAttach = function(lib, pkg){
  library(data.table)
  library(matrixStats)
  library(skogR)
  cat("yasso15 v0.1")
}

.onLoad = function(lib, pkg){
  library.dynam("yasso15", pkg, lib)
}
