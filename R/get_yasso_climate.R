#' @title Yasso Climate parameters
#'
#' @description
#' Calculate Yasso climate parameters from historical climate data provided by the Norwegian Meteorological Institute
#'
#' @param long longitude
#' @param lat latitude
#' @param start.date beginging of the time interval
#' @param end.date end of the time interval
#' @return a vector with three elements: mean temperature (°C), accumulated precipitition (mm), and mean difference between min and max monthly temperature(°C)
#' @details Uses the webservice provided by https://frost.met.no/. Climate data is fetched from the nearest weather station.
#' @examples
#' # this is Sørhellinga
#' long = 10.776966
#' lat = 59.666850
#'
#' start.date = "2015-01-01T00:00"
#' end.date = "2016-01-01T00:00"
#'
#' get.yasso.climate(long,lat,start.date,end.date)
#' @rdname get_yasso_climate
#' @author Victor Felix Strîmbu \email{victor.strimbu@@nmbu.no}
#' @export

get.yasso.climate = function(long,lat,start.date,end.date){
  # I registered and got this client ID. We can use this for now.
  client = "783d43b8-d6c3-4a02-a9d7-04b5b2cf299f:92109e96-ac2b-48a7-8408-a38bddd6fb15"

  # find nearest station
  cat("find nearest weather station...\n")
  nearest.station = scan(paste("https://", client, "@frost.met.no/sources/v0.jsonld?types=SensorSystem&geometry=nearest(POINT(",long," ",lat,"))",sep=""), what="",quiet=T)
  station = nearest.station[grep("^id$",nearest.station)+2]

  # weather paramaters that we need
  elements = c ("mean(air_temperature P1M)","max(air_temperature P1M)","min(air_temperature P1M)","sum(precipitation_amount P1M)")

  # URL for collection is aggregated
  url = paste ("https://", client, "@frost.met.no/observations/v0.jsonld?",
               "sources=", paste (station, collapse = ","),
               "&referencetime=", start.date, "/", end.date,
               "&elements=", paste (elements, collapse = ","),
               sep = "", collapse = "")
  # send request
  cat("request data...\n")
  xs = scan(url, what = "",quiet=T)

  # build the data from server response
  cat("calculate Yasso climate parameters...\n")
  climate.dt = data.table(referenceTime=character(0),elementId=character(0),value = numeric(0),timeOffset = character(0))
  for (i in 1:length(xs)){
    if(xs[i]=="referenceTime"){
      referenceTime = xs[i+2]}
    if(xs[i]=="elementId"){
      elementId = xs[i+2]
      value = as.numeric(gsub(",","",xs[i+6]))
    }
    if(xs[i]=="timeOffset")
    {
      timeOffset = xs[i+2]
      climate.dt = rbind(climate.dt,list(referenceTime,elementId,value,timeOffset))
    }
  }

  climate.dt = climate.dt[,.(val=mean(value)),by=.(referenceTime,elementId)]

  # the Yasso climate paramaters
  mean.temp = mean(climate.dt[elementId=="mean(air_temperature P1M)",val])
  diff.temp = mean(climate.dt[elementId=="max(air_temperature P1M)",val]-climate.dt[elementId=="min(air_temperature P1M)",val])
  prec = sum(climate.dt[elementId=="sum(precipitation_amount P1M)",val])

  climate = c(mean.temp,prec,diff.temp)
  names(climate) = c("mean.temp","prec","diff.temp")
  return (climate)
}
