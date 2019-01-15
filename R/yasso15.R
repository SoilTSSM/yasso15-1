.onAttach = function(lib, pkg){
  library(data.table)
  if (!"skogR" %in% installed.packages()[, "Package"]){
    if (!"devtools" %in% installed.packages()[, "Package"]){
      install.packages("devtools")
    }
    library(devtools)
    install_github("hansoleorka/skogR")
  }
  library(skogR)
  cat("yasso15 v0.1")
}

.onLoad = function(lib, pkg){
  library.dynam("yasso15", pkg, lib)
}
