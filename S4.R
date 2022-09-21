# S4 system is slightly more restrictive than the S3, but similar to S3 in some ways
# classes are declared using the setClass() function
# setClass() takes three arguments:
# a string that names the class
# slots that contain the attributes of the class
# and a 'contains' argument that specifies a parent class, if there is any.

setClass(Class = "Employee", slots = list(name = "character",
                                          experience_in_yrs = "numeric",
                                           age = "numeric",
                                           marital_status = "logical",
                                           qualifications = "character",
                                           salary = "numeric",
                                           expertise = "character"))

setClass(Class = "NewEmployee", slots = list(Trainee = "logical",
                                             supervisor = "character",
                                             work_period = "numeric",
                                             alma_matter = "character",
                                             recommendations = "character"),
         contains = "Employee") # meaning that this is a subclass of the Employee class!

# new() function helps create new instances of S4 class objects
# it takes the S4 class slots as arguments

Jhonathan <- new(Class = "Employee",
                 name = "Jhonathan Spencer",
                 experience_in_yrs =  12,
                 age = 36,
                 marital_status = TRUE, 
                 qualifications = "Masters in CompSci",
                 salary = 12000, 
                 expertise = "Server administration")

Natalie <- new(Class = "NewEmployee",
               Trainee = TRUE,
               name = "Natalie Martinez Palvova",
               supervisor = "Jhonathan",
               work_period = 10,
               alma_matter = "UCL, Santa Barbara",
               recommendations = "Clint Estwood",
               experience_in_yrs = 0,
               age = 22,  # here starts the inherited attributes
               marital_status = FALSE,
               qualifications = "BSc Data Science",
               salary = 9000,
               expertise = "High dimensional data analytics")

Natalie
class(Natalie)

# to access a certain attribute of a S4 class object
Natalie@Trainee
Natalie@supervisor
Jhonathan@experience_in_yrs

Natalie@experience_in_yrs  < Jhonathan@experience_in_yrs
Natalie@salary < Jhonathan@salary

# similar to S3 classes, S4 classes use generic methods to define methods
setGeneric(name = "isTrainee", function(x){
    standardGeneric("isTrainee")
})

# defining the method isTrainee
setMethod("isTrainee", c(x = "Employee"), function(x){
    if(x@Trainee == TRUE) return("Yes")
    else return("No")
})

isTrainee(Natalie)
Natalie@Trainee <- FALSE
isTrainee(Natalie)

# add a polymorphic method to the S4 class object
# extend the function of a preexisting function, in a way specific to the S4 class object

# the generic function we want to extend
setGeneric("print")
# definition
setMethod("print", c(x = "Employee"), function(x){
    if(!is(x, "NewEmployee") && x@Trainee == TRUE) print(paste(x@name, " is a trainee working under the supervision of ", x@supervisor))
    else if(!is(x, "NewEmployee")) return(paste(x@name, " is a permanent employee"))
})

print(Natalie)
print(Jhonathan)
# sucks somewhere
