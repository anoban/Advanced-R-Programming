# errors occur when code is used in a way it was not intended to be used

"James" + "Martin"
# Error in "James" + "Martin" : non-numeric argument to binary operator
# this is acceptable in Python but not in R

paste("James", "Martin")
paste("James", "Martin", sep = "_")
paste("James", "Martin", sep = "-")

cat("Remmy", "Martin")
paste0("Jennifer", "Lawrence")
paste0("Jennifer ", "Lawrence")

# besides errors, R has warnings
# warnings indicate something has gone wrong in the execution that needs inspection
as.numeric(c("2", "3", "879.765", "nine"))
# Warning message:
# NAs introduced by coercion 

# messages simply print something to the console

saySmthn <- function(){
    message("Here's something dumbass!")
    print("Here's something dumbass!")
}

saySmthn()
# note the colour difference between the text from message() and print()

# error raising
factRec <- function(n){
    if (!is.numeric(n)){
        stop("factRec only takes numeric inputs!")
    }else if (is.nan(n)){
        message("Cannot compute fatorial of a non-numeric value!")
    }else if (n > 1){
        return(n * factRec(n-1))    
    }else if (n == 1 || n == 0){
        return(1)
    }
}

factRec("12")
factRec(as.numeric("12"))
factorial(12)

factRec(NA)
factRec(NaN)
factRec(1)
factRec(0)

checkScore <- function(s){
    stopifnot(s > 50)
    message("Scores below 51 are not accepted!")
}

checkScore(22)
checkScore(92)

# message() & warning() do not stop programme execution!
warning("You've been warned!")
message("You've been warned!")
stop("You've been warned!")


# try catch in R

evalErr <- function(expr){
    tryCatch(expr = expr,
    error = function(error){
        message("An error has occurred!\n", error)
    },
    warning = function(warn){
        message("Warning!\n", warn)
    },
    finally = {
        message("Execution finished finally!")
    })
}

evalErr(3^t)
evalErr(as.numeric(c(2,"two")))

is.even <- function(n){
    tryCatch(n %% 2 == 0,
             error = function(err){
                 stop(err)
             },
             warning = function(warn){
                 warning(warn)
             },
             finally = {
                 message("Execution finished")
             })
}

is.even(10)
is.even(11)
is.even("11")
is.even(NaN)
is.even(1:5)

is.odd <- function(n){
    tryCatch(n %% 2 ==1,
             error = function(error){
                 return(FALSE)
             },
             warning = function(warn){
                 message(warn)
                 return(FALSE)
             },
             finally = {
                 message("Execution finished!")
             })
}

is.odd(11)
is.odd(10)
is.odd("seven")
is.odd(11.098)

# this works but can slow down execution for large data

is.odd <- function(n){
    return(is.numeric(n) && n %% 2 == 1)
    # here, if the first condition before the and is FALSE, second conditionn won't be evaluated
    # this will speed up execution
    # a phenomenon called short-circuiting
}

is.odd("11")
is.odd(19)
is.odd(20)
