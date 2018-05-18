.onAttach = function(lib, pkg){
  library(data.table)
  library(matrixStats)
  library(skogR)
  # load external binaries; temporrary moved this to yasso15_wrapper


  # yasso theta parameters

  cat("yasso15 v0.1")
}

# .onLoad = function(){
#   library.dynam('libgcc_s_seh-1.dll', pkg, lib)
#   library.dynam('libquadmath-0.dll', pkg, lib)
#   library.dynam('libwinpthread-1.dll', pkg, lib)
#   library.dynam('libgfortran-4.dll', pkg, lib)
#   library.dynam('yasso15.dll', pkg, lib)
# }
