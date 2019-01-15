library(data.table)
proj.dir = "W:\\Users\\Victor\\R packages\\yasso15\\"
thetas = as.matrix(read.fwf(file=paste0(proj.dir,"inst\\rawdata\\yasso15.dat"), widths=rep(16,35)))
turnover.1 = as.matrix(read.csv(paste0(proj.dir,"inst\\rawdata\\turnover_1.csv")))
AWEN.fractions = fread(paste0(proj.dir,"inst\\rawdata\\AWEN.csv"))
AWEN.array = array(as.matrix(AWEN.fractions[,c("A","W","E","N")]),dim=c(3,8,4))

save(thetas,     file=paste0(proj.dir,"data\\thetas.rda"),   compress=T,overwrite=T)
save(turnover.1, file=paste0(proj.dir,"data\\turnover.rda"), compress=T,overwrite=T)
save(AWEN.array, file=paste0(proj.dir,"data\\AWEN.rda"),     compress=T,overwrite=T)
