.onAttach = function(lib, pkg){
  library(data.table)
  library(matrixStats)
  library(skogR)
  # load external binaries;
  d1.file = system.file("dlls", "libgcc_s_seh-1.dll", package = "yasso15")
  cat(d1.file)
  dyn.load(d1.file)
  #dyn.load(paste0(path.package("yasso15"),"\\external\\libquadmath-0.dll"))
  #dyn.load(paste0(path.package("yasso15"),"\\external\\libwinpthread-1.dll"))
  #dyn.load(paste0(path.package("yasso15"),"\\external\\libgfortran-4.dll"))
  #dyn.load(paste0(path.package("yasso15"),"\\external\\yasso15.dll"))

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
