# profiling is optimizing R code for performance
# this is helpful when writing functions that will be used repeatedly
# it is often a wasteful process to profile one-time scripts since profiling will consume 
# more time than the time that will be saved by the optimized code!

# there are several packages available to carry out optimizations in R
# microbenchmark and profvis

install.packages(c("microbenchmark","profvis"))
library(microbenchmark)
library(profvis)

# microbenchmark will run a given code multiple times and will return a summary stats for the 
# execution
# microbenchmark can take multiple lines of code for arguments, but to get separate stats for rach
# expression they must be separated by comma

microbenchmark(rnorm(1000), mean(rnorm(1000)), times = 1000)
microbenchmark(rnorm(10000), mean(rnorm(10000)), times = 1000)
microbenchmark(rnorm(100000), mean(rnorm(100000)), times = 1000)
# benchmarking two functions!


data <- data.frame(date = c("2015-07-01", "2015-07-02", "2015-07-03", "2015-07-04", "2015-07-05", "2015-07-06", 
             "2015-07-07", "2015-07-08", "2015-07-09"),
             temp = c(26.5, 27.2, 28.0, 26.9, 27.5, 25.9, 28.0, 28.2, 27.9))

# function that uses a for loop!
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

tempCalc(data, 23)
tempCalc(data, 27)
# perfecto :))

# vectorized function
vecTemp <- function(dframe, threshTemp){
    tab <- dframe |> transform(date = strptime(date, format = "%Y-%m-%d"))
    threshBool <- tab$temp >= threshTemp
    pdayBool <- c(NA, tab$temp[-nrow(tab)]) <= tab$temp
    tab["record_temp"] <- threshBool & pdayBool
    return(tab)
}

vecTemp(data, 27)

# function using tidyverse
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

tidyTemp(data, 27)

# let's benchmark
microbenchmark(tempCalc(data, 27), vecTemp(data, 27), tidyTemp(data, 27), times = 10000)

# my vectorized function was the fastest amongst all :)))))))))))))
