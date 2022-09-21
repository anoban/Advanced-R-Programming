library(utils)

setwd("D:/Advanced R Programming/")
if(!file.exists("2021-12-02.csv.gz")){
    download.file("http://cran-logs.rstudio.com/2021/2021-12-02-r.csv.gz",destfile = "2021-12-02.csv.gz")
}

# get the working directory
getwd()

# list elements of the directory
dir()

# this file has the logs for all the R interpreter downloads from CRAN
cran_logs <- gzfile("2021-12-02.csv.gz", open = "r")
R_downloads <- read.csv(cran_logs, header = TRUE)
close.connection(cran_logs)

R_downloads |> subset(country == "HK", select = c(version, os)) |> table()
dim(cran_downloads)  # 15768     7


R_downloads |> subset(os == "win", select = country) |> table()
R_downloads |> subset(country == "SL")
# no fuckers from SL downloaded R on this date :((


dir()
connexion <- gzfile("2021-12-02.csv.gz", open = "r")
dec_2021 <- read.csv(connexion, header = TRUE)
close.connection(connexion)

dim(dec_2021)  # 6834356      10


# define a function that downloads download logs from CRAN for a given date
# filters & returns data for a named package

# sample url for package download logs http://cran-logs.rstudio.com/2022/2022-06-08.csv.gz
# sample url for R download logs http://cran-logs.rstudio.com/2020/2020-12-09-r.csv.gz

getDownloadLogs <- function(package_name, date){
    url_template <- "http://cran-logs.rstudio.com/"
    url <- paste0(url_template, substr(date, start = 1, stop = 4), "/", date, ".csv.gz")
    setwd("D:/Advanced R Programming/")
    fname <- paste0(date,".csv.gz")
    if (!file.exists(fname)){
        download.file(url = url, destfile = paste0(fname))
    }
   gzip <- gzfile(fname, open = "r")
   logs <- read.csv(file = gzip, header = TRUE)
   close.connection(gzip)
   return(nrow(subset(logs, package == package_name)))
}


getDownloadLogs("dplyr", "2019-11-19")
getDownloadLogs("ggplot2", "2022-02-27")

# let's double check manually

gzip <- gzfile(dir()[3], open = "r")
data <- read.csv(gzip, header = TRUE)
close.connection(gzip)
data |> subset(package == "ggplot2") |> nrow()
dim(data)

gzip <- gzfile(dir()[1], open = "r")
data <- read.csv(gzip, header = TRUE)
close.connection(gzip)
data |> subset(package == "dplyr") |> nrow()

getDownloadLogs("knitr", "2021-11-18")

# works great :))


# functions with default values for arguments

getDownloadLogs <- function(package_name, date = Sys.Date() - 10){  # default date is 10 days before today
    options("timeout" = Inf) # file download can take as long as it needs
    url_template <- "http://cran-logs.rstudio.com/"
    url <- paste0(url_template, substr(date, start = 1, stop = 4), "/", date, ".csv.gz")
    setwd("D:/Advanced R Programming/")
    fname <- paste0(date,".csv.gz")
    if (!file.exists(fname)){
        download.file(url = url, destfile = paste0(fname))
    }
    gzip <- gzfile(fname, open = "r")
    logs <- read.csv(file = gzip, header = TRUE)
    close.connection(gzip)
    return(nrow(subset(logs, package == package_name)))
}

# calling getDownloadLogs() without specifying a date!!
getDownloadLogs("stringr")

# below paragraph is a comment!!
 
"When using R in interactive mode, it can be a pain to have to specify the value of every argument 
Default values play a critical role in R functions because R functions are often called interactively.
in every instance of calling the function. Sometimes we want to call a function multiple times while 
varying a single argument (keeping the other arguments at a sensible default).
Also, function arguments have a tendency to proliferate. 
As functions mature and are continuously developed, one way to add more functionality is to increase the
number of arguments. But if these new arguments do not have sensible default values,
then users will generally have a harder time using the function.
As a function author, you have tremendous influence over the user's behavior by specifying defaults,
so take care in choosing them. However, just note that a judicious use of default values can greatly 
improve the user experience with respect to your function."


# CODE REFACTORING

# Now that we have a function written that handles the task at hand in a more general manner 
# (i.e. it can handle any package and any date), it is worth taking a closer look at the function and 
# asking whether it is written in the most useful possible manner.
# In particular, it could be argued that this function does too many things:
# Construct the path to the remote and local log file
# Download the log file (if it doesn't already exist locally)
# Read the log file into R
# Find the package and return the number of downloads
# It might make sense to abstract the first two things on this list into a separate function.

# a function for getting the log file
getCRANLogs <- function(date = Sys.Date() - 10){
    resource <- gsub("placeholder", paste0(substr(date, start = 1, stop = 4), "/", date), "http://cran-logs.rstudio.com/placeholder.csv.gz")
    options(timeout = Inf)
    setwd("D:/Advanced R Programming/")
    filename <- paste0(date, ".csv.gz")
    if (!file.exists(filename)){
        download.file(resource, destfile = filename)
        return(paste0("gzipped file ", filename, " has been successfully downloaded to ", getwd()))
    }else if (file.exists(filename)){
        return(paste0("The gzipped file ", filename, " already exists in your system at ", getwd()))
    }
}

dir()
getCRANLogs("2021-12-02")
getCRANLogs("2022-05-02")
getCRANLogs("2014-10-10")
# works great :))
    
packageDownloads <- function(packageName, date){
    getCRANLogs(date)
    gzip <- gzfile(paste0(date, ".csv.gz"), open = "r")
    logs <- read.csv(gzip, header = TRUE)
    close.connection(gzip)
    return(logs |> subset(package == packageName) |> nrow())
}

packageDownloads("dplyr", "2022-05-02")  # 77685
# lets double check
    
data <- read.csv(gzfile("2022-05-02.csv.gz", open = "r"), header = TRUE)
data |> subset(package == "dplyr") |> dim()  # 77685    10
# great :)))


# dependency management
# Without them installed, the function won't run. Sometimes it is useful to check
# to see that the needed packages are installed so that a useful error message 
# (or other behavior) can be provided for the user.

# refactoring our function to leverage third party libraries
library(dplyr, warn.conflicts = FALSE)
library(readr, warn.conflicts = FALSE)

packageDownloads <- function(packageName, date){
    getCRANLogs(date)
    gzip <- gzfile(paste0(date, ".csv.gz"), open = "rb")  # establishing a binary connection
    # since readr cannot handle generic read connections :((
    logs <- readr::read_csv(gzip, col_names = TRUE, show_col_types = FALSE)
    close.connection(gzip)
    return(logs %>% dplyr::filter(package == packageName) %>% .$package %>% length())
}

packageDownloads("XML", "2022-05-02")
packageDownloads("Rcpp", "2022-05-02")
packageDownloads("stringi", "2022-05-02")

# works great but if the user's machine doesn't have the required packages or if the user hasn't loaded
# the packages into R, we would run into problems
# we need an effective error handling tactic to deal with dependencies!

require("XML") == TRUE
require("XML") == FALSE
require("somepackage", warn.conflicts = FALSE) == TRUE

# unlike library() which returns error messages when R cannot load the specified library, require() 
# returns true or false based on the availability of the package

# functions that accounts for dependency checking
packageDownloads <- function(packageName, date){
    if (!require("dplyr")){
        install.packages("dplyr")
        message("Installing necessary dependencies......")
        message("Installing the dplyr package.....")
    }
    if (!require("readr")){
        stop("Error! Dependency resolution failed!")
        message("dplyr package is required for this function but not installed on your machine!")
    }
    getCRANLogs(date)
    gzip <- gzfile(paste0(date, ".csv.gz"), open = "rb")
    logs <- readr::read_csv(gzip, col_names = TRUE, show_col_types = FALSE)
    close.connection(gzip)
    return(logs %>% dplyr::filter(package == packageName) %>% .$package %>% length())
}


# vectorization
# our functions defined above only takes single values for arguments
# so, if we need log statistics for multiple packages we would have to call the function for each package
# it would be better if the function can take acharacter vector for the package_name argument!!!
# and return the download count for all requested packages!!

packageDownloads <- function(packageNames, date){
    getCRANLogs(date)
    gzip <- gzfile(paste0(date, ".csv.gz"), open = "r")
    logs <- read.csv(gzip, header = TRUE)
    close.connection(gzip)
    return(logs |> subset(package == as.vector(packageNames, mode = "character"), select = "package") |> table()) 
}

pacNames <- list("dplyr", "tidyr", "purr", "stringr", "ggplot2", "readr", "Rcpp", "forcats")
as.vector(pacNames, mode = "character")

# works great!
packageDownloads(pacNames, date = "2022-05-02")

packList <- installed.packages() |> as.data.frame() |> subset(select = "Package") |> as.vector()
packList <- packList[["Package"]]

# works great!
packageDownloads(packageNames = packList, date = "2022-05-02")


# argument checking
# we must ensure users do not pass a iterable for the date argument
# i.e the value passed for the date argument must be an atomic character variable!
# and the type of value passed for date must be a character and be in the yyyy-mm-dd format
    
packageDownloads <- function(packageNames, date){
    if(!length(date) == 1){
        stop("Date argument does not take multiple values!")
    }else if(!is.character(date)){
        stop("Only strings are accepted for date!")
    }else if (grepl("-", date, fixed = TRUE) == FALSE | nchar(date) != 10){
        stop("Incorrect format for date!")
    }else {
        getCRANLogs(date)
        gzip <- gzfile(paste0(date, ".csv.gz"), open = "r")
        logs <- read.csv(gzip, header = TRUE)
        close.connection(gzip)
        return(logs |> subset(package == as.vector(packageNames, mode = "character"), select = "package") |> table())   
    }
}

packageDownloads("tidyr", c("2022-09-11", "2021-11-04"))
packageDownloads("tidyr", 2022-12-11)
packageDownloads("tidyr", "2022/04/19")
packageDownloads("tidyr", "2022-7-24")
# perfect!
