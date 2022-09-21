# everything in R is an object
class(2)
class("What class is this?")
class(mean)

# S3 classes can be assigned to variables
# this undermines one of the basic principles of OOP, objects belong to classes
# so how can a class be an object? i.e variable


# S3 classes can be created using the structure() function or
# using the class() <- function

John <- structure(27, class = "User age")
class(John) # "User age"

Jennifer <- "Widdowed"
class(Jennifer) <- "MaritalStatus"
class(Jennifer)

# defining a constructor for S3 class objects
ConstructUserS3 <- function(name, age, profession, maritalStat, children){
    return(structure(list("Name" = name, "Age" = age, "Profession" = profession,
                          "MaritalStatus" = maritalStat, "Children" = children), class = "User"))
}

Jenny <- ConstructUserS3("Jenna", 32, "Accountant", "Single", 0)
Jenny
class(Jenny) # User

# R's generic methods can be used to define methods for classes
# these generic methods are not class specific but they can return different results based on the class of the input
# similar to polymorphism

# eg
mean(1:34)
mean(as.Date(c("11-10-2011", "13-12-2022"), format = "%d-%m-%Y"))
mean(as.Date(c("11-10-2011", "13-12-2011"), format = "%d-%m-%Y"))
mean(as.Date(c("11-10-2021", "13-12-2022"), format = "%d-%m-%Y"))

ConstructShapeS3 <- function(dimensions){
    return(structure(list("Dimensions" = dimensions), class = "S3Shape"))
}

Line <- ConstructShapeS3(34.23)
Triangle <- ConstructShapeS3(c(10,10,10))
Rectangle <- ConstructShapeS3(c(10,10,7,7))
Square <- ConstructShapeS3(c(10,10,10,10))

# define a method that would return TRUE if the shape is a square and FALSE if anything else
# to define any methods for a S3 class the UseMethod() function is used

isSquare <- function(S3Obj){
    UseMethod("isSquare")
}

isSquare.S3Shape <- function(S3Obj){
    return(length(S3Obj$Dimensions) == 4 && all(S3Obj$Dimensions[1] == S3Obj$Dimensions))
}

isSquare(Triangle)
isSquare(Rectangle)
isSquare(Square)
isSquare(Line)

# modify isSquare() to return NA when the argument is not a S3 object
isSquare.default <- function(S3Obj){
    return(NA)
}

isSquare("dummy")
isSquare(c(2,45,53,989))
isSquare(-34.3453)

Square

print.S3Shape <- function(S3Obj){
    if(length(S3Obj$Dimensions) == 4 && all(S3Obj$Dimensions[1] == S3Obj$Dimensions)){
        paste("A square with length ", S3Obj$Dimensions[1])
    }else if(length(S3Obj$Dimensions) == 3){
        paste("A triangle with edges of length ", S3Obj$Dimensions[1], S3Obj$Dimensions[2]," and ",  S3Obj$Dimensions[3])
    }else if(length(S3Obj$Dimensions) == 4){
        paste("A rectangle with dimensions ", S3Obj$Dimensions[1], S3Obj$Dimensions[2], S3Obj$Dimensions[3]," and ", S3Obj$Dimensions[4])
    }else if(length(S3Obj$Dimensions) == 1){
        paste("A straight line with length ", S3Obj$Dimensions[1])
    }
}

print(Triangle)
print(Rectangle)
print(Square)
print(Line)

# conclusion:
# S3 classes are ASS!
