data <- read.csv("D:/Advanced R Programming/MIE.csv")

# id: the subject identification number
# visit: the visit number which can be 0, 1, or 2
# room: the room in which the monitor was placed
# value: the level of pollution in micrograms per cubic meter
# timepoint: the time point of the monitor value for a given visit/room

setClass(Class = "LongitudinalData",
            slots = list(id = "numeric", visit = "numeric", room = "character", value = "numeric", timepoint = "numeric")
         )

setGeneric(name = "make_LD", function(x){
    standardGeneric(f = "make_LD")
})
setMethod(f = "make_LD", c(x = "data.frame"), function(x){
    return(new(Class = "LongitudinalData", id = x$id, visit = x$visit, value = x$value, room = x$room, timepoint = x$timepoint))
})


setGeneric("print")
setMethod(f = "print", c(x = "LongitudinalData"), function(x){
    return(paste("A longitudinal dataset with 10 subjects"))
})

setClass(Class = "Subject", 
         slots = list(id = "numeric", visit = "numeric", room = "character", value = "numeric", timepoint = "numeric"),
         contains = "LongitudinalData"
         )

setGeneric(name = "subject", function(x, ID){
    standardGeneric(f = "subject")
})
setMethod(f = "subject", c(x = "LongitudinalData"), function(x, ID){
    if(is.element(ID, x@id)) {
        return(new(Class = "Subject", id = x@id[x@id == ID], visit = x@visit[x@id == ID], room = x@room[x@id == ID], 
                   value = x@value[x@id == ID], timepoint = x@timepoint[x@id == ID]))    
    }else return(NULL)
})

setMethod(f = "print", c(x = "Subject"), function(x){
    return(paste("Subject ID", unique(x@id)))
})

setClass(Class = "Visit",
         slots = list(id = "numeric", visit = "numeric", room = "character", value = "numeric", timepoint = "numeric"),
         contains = "Subject"
)

setGeneric(name = "visit", function(x, n){
    standardGeneric("visit")
})
setMethod(f = "visit", c(x = "Subject"), function(x, n){
    if(is.element(n, x@visit)){
        return(new(Class = "Visit", id = x@id[x@visit == n], visit = x@visit[x@visit == n], room = x@room[x@visit == n],
                   value = x@value[x@visit == n], timepoint = x@timepoint[x@visit == n]))    
    }else return(NULL)
    
})

setClass(Class = "Room",
         slots = list(id = "numeric", visit = "numeric", room = "character", value = "numeric", timepoint = "numeric"),
         contains = "Visit"
)

setGeneric(name = "room", function(x, rname){
    standardGeneric("room")
})
setMethod(f = "room", c(x = "Visit"), function(x, rname){
    if(is.element(rname, x@room)){
        return(new(Class = "Room", id = x@id[x@room == rname], visit = x@visit[x@room == rname], room = x@room[x@room == rname],
                   value = x@value[x@room == rname], timepoint = x@timepoint[x@room == rname]))    
    }else return(NULL)
    
})

setGeneric(name = "print", function(x){
    standardGeneric("print")
})
setMethod(f = "print", c(x = "Room"), function(x){
    return(cat("ID:", unique(x@id), "\nVisit:", unique(x@visit), "\nRoom:", unique(x@room)))
})


# implementing summary as a method, not as an attribute shown in the example :(
setGeneric("summary", function(x){
    standardGeneric("summary")
})
setMethod(f = "summary", c(x = "Subject"), function(x){
    base::cat(paste("ID: ", unique(x@id)), "\n")
    dframe <- data.frame("room" = x@room, "visit" = x@visit, "value" = x@value)
    return(aggregate.data.frame(dframe["value"], by = list(dframe$visit, dframe$room), FUN = mean) |>
               `names<-`(list("Visit", "Room", "Value")))
})
setMethod(f = "summary", c(x = "Room"), function(x){
    base::cat(paste("ID: ", unique(x@id)), "\n")
    return(base::summary(x@value))
})

# required core executions per oop_output.txt
make_LD(data) |> subject(10)
make_LD(data) |>subject(14) |> print()
make_LD(data) |> subject(54) |> summary()
make_LD(data) |> subject(14) |> summary()
make_LD(data) |> subject(44) |> visit(0) |> room("bedroom") |> print()
make_LD(data) |> subject(44) |> visit(0) |> room("bedroom") |> summary()
make_LD(data) |> subject(44) |> visit(1) |> room("living room") |> summary()
        

