.onAttach = function(lib, pkg){
  library(data.table)
  library(matrixStats)
  library(skogR)
  # load external binaries;
  #  d1.file = system.file("dlls", "libgcc_s_seh-1.dll", package = "yasso15")
  #  cat(d1.file," ",file.exists(d1.file))
  #  library.dynam(chname="libgcc_s_seh-1" , lib.loc = "dlls", package="yasso15")

  #dyn.load(paste0(path.package("yasso15"),"\\external\\libquadmath-0.dll"))
  #dyn.load(paste0(path.package("yasso15"),"\\external\\libwinpthread-1.dll"))
  #dyn.load(paste0(path.package("yasso15"),"\\external\\libgfortran-4.dll"))
  #dyn.load(paste0(path.package("yasso15"),"\\external\\yasso15.dll"))

  cat("yasso15 v0.1")
}

.onLoad = function(lib, pkg){
  library.dynam("yasso15", pkg, lib)
}

# .onLoad = function(libname, pkgname){
#   d1.file = system.file("dlls", "libgcc_s_seh-1.dll", package = "yasso15")
#   cat(d1.file)
#   dyn.load(d1.file)
# }
