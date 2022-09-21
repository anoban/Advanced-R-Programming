library(profvis)
library(microbenchmark)
library(dplyr)

tidyTemp <- function(datafr, threshold){
    if (!is.element("dplyr", (.packages()))){
        if(!require(dplyr)) stop("This function requires the dplyr package to be installed on the machine!")
    }
    datafr <- datafr %>%
        mutate(over_threshold = temp >= threshold,
               date = strptime(date, format = "%Y-%m-%d"),
               cummax_temp = temp == cummax(temp),
               record_temp = over_threshold & cummax_temp) %>%
        select(date, temp, record_temp)
    return(as.data.frame(datafr))
}

vecTemp <- function(dframe, threshTemp){
    tab <- dframe |> transform(date = strptime(date, format = "%Y-%m-%d"))
    threshBool <- tab$temp >= threshTemp
    pdayBool <- c(NA, tab$temp[-nrow(tab)]) <= tab$temp
    tab["record_temp"] <- threshBool & pdayBool
    return(tab)
}

tempCalc <- function(dframe, threshTemp){
    tab <- dframe
    tab$date <- strptime(tab$date, format = "%Y-%m-%d") # this is not really needed! 
    for(i in 1:nrow(tab)){
        if(i == 1) tab[i, "record_temp"] <- NA
        else if(tab$temp[i] >= threshTemp && tab$temp[i] >= tab$temp[i-1]){
            tab[i, "record_temp"] <- TRUE
        }else tab[i, "record_temp"] <- FALSE
    }
    return(tab)
}

download.packages("dlnm", destdir = "D:/Advanced R Programming/")
load("D:/Advanced R Programming/chicagoNMMAPS.rda")
write.csv(chicagoNMMAPS, file = "D:/Advanced R Programming/chicagoNMMAPS.csv")
rm(chicagoNMMAPS)
data <- read.csv("D:/Advanced R Programming/chicagoNMMAPS.csv", header = TRUE)

names(data)
# date: Date in the period 1987-2000.
# time: The sequence of observations
# year: Year
# month: Month (numeric)
# doy: Day of the year
# dow: Day of the week (factor)
# death: Counts of all cause mortality excluding accident
# cvd: Cardiovascular Deaths
# resp: Respiratory Deaths
# temp: Mean temperature (in Celsius degrees)
# dptp: Dew point temperature
# rhum: Mean relative humidity
# pm10: PM10
# o3: Ozone

data <- data |> subset(select = c(date, temp))
dim(data)
# benchmarking functions with a dataset with 5114 rows & 2 columns
microbenchmark(tempCalc(data, 27), tidyTemp(data, 27), vecTemp(data, 27), times = 100)
# vectorized function is still the fastest! :))
# lets try again w/o parsing the date

tidyTemp <- function(datafr, threshold){
    if (!is.element("dplyr", (.packages()))){
        if(!require(dplyr)) stop("This function requires the dplyr package to be installed on the machine!")
    }
    datafr <- datafr %>%
        mutate(over_threshold = temp >= threshold,
               cummax_temp = temp == cummax(temp),
               record_temp = over_threshold & cummax_temp) %>%
        select(date, temp, record_temp)
    return(as.data.frame(datafr))
}

vecTemp <- function(dframe, threshTemp){
    tab <- dframe
    threshBool <- tab$temp >= threshTemp
    pdayBool <- c(NA, tab$temp[-nrow(tab)]) <= tab$temp
    tab["record_temp"] <- threshBool & pdayBool
    return(tab)
}

tempCalc <- function(dframe, threshTemp){
    tab <- dframe
    for(i in 1:nrow(tab)){
        if(i == 1) tab[i, "record_temp"] <- NA
        else if(tab$temp[i] >= threshTemp && tab$temp[i] >= tab$temp[i-1]){
            tab[i, "record_temp"] <- TRUE
        }else tab[i, "record_temp"] <- FALSE
    }
    return(tab)
}

microbenchmark(tempCalc(data, 27), tidyTemp(data, 27), vecTemp(data, 27), times = 100)
# vectorized function is 25 times faster than dplyr function & 1079 times faster than for loop :))

profvis({
    tab <- data
    threshTemp <- 27
    for(i in 1:nrow(tab)){
        if(i == 1) tab[i, "record_temp"] <- NA
        else if(tab$temp[i] >= threshTemp && tab$temp[i] >= tab$temp[i-1]){
            tab[i, "record_temp"] <- TRUE
        }else tab[i, "record_temp"] <- FALSE
    }
    return(tab)
    })

profvis({
    tab <- data
    threshTemp <- 27
    threshBool <- tab$temp >= threshTemp
    pdayBool <- c(NA, tab$temp[-nrow(tab)]) <= tab$temp
    tab["record_temp"] <- threshBool & pdayBool
    return(tab)
})
