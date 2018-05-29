# use first set of parmeters
theta = as.numeric(thetas[1])
time = 5                    # in years
climate = c(10,700,10)      # mean temperature (Celsius), anual precipitation (mm), max-min monthly temp (Celsius)
init = c(10,10,10,10,10)    # initial quanities in each pool
b = c(2,2,2,2,2)            # yearly litter input to each pool
d = 0                       # diameter if necessary
leac = 0                    # leaching..? not sure what this does but in Tony's example was 0
steady = F                  # weather to calculate the steady state. if true it ignores "time" parameter and loops until xt becomes stable

# call the wrapper
yasso.out = yasso.15(theta,time,climate,init,b,d,leac,xt,steady)
yasso.out.se = yasso.15.se(thetas,time,climate,init,b,d,leac,xt,steady)


trees = data.table(d=c(10,15,20),h=c(10,15,17),sp=c(1,2,2))
get.Yasso.b(trees)

data.dir = "W:\\Users\\Victor\\R packages\\yasso15\\inst"
thetas = data.table(read.fwf(file=paste0(data.dir,"\\external\\Yasso15.dat"), widths=rep(16,35)))
turnover = as.matrix(read.csv(paste0(data.dir,"\\external\\turnover.csv")))
AWEN.fractions = fread(paste0(data.dir,"\\external\\AWEN.csv"))
AWEN.array = array(as.matrix(AWEN.fractions[,c("A","W","E","N")]),dim=c(3,8,4))

save(thetas, file="W:\\Users\\Victor\\R packages\\yasso15\\data\\thetas.rda",compress=T)
save(turnover, file="W:\\Users\\Victor\\R packages\\yasso15\\data\\turnover.rda",compress=T)
save(AWEN.array, file="W:\\Users\\Victor\\R packages\\yasso15\\data\\AWEN.rda",compress=T)

library(devtools)
install_github("vstrimbu/yasso15")
.libPaths( c( "E:\\Users\\Victor\\R Lib",.libPaths()) )
loadDLLs()
trees[,.(sp,h)]
library("yasso15")
# this is Sørhellinga
 long = 10.776966
 lat = 59.666850

 start.date = "2015-01-01T00:00"
 end.date = "2016-01-01T00:00"

 get.yasso.climate(long,lat,start.date,end.date)
