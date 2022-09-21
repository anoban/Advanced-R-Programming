# R has a number of built-in functions for debugging

# browser() gives an interactive debugging environment that allows to step through code, one
# expression at a time

# debug() & debugonce() initiates the browser within a function

# trace() allows temporary insertion of code into functions to modify their behaviour

# recover() is a function to navigate the call stack, after a function has raised an error

# traceback() prints out the function call stack after an error has occurred

browser()

checkVal <- function(n){
    if(n < 5){
        stop("Value must be greater than 5!")
    }
}

checkFunc <- function(n){
    checkVal(n)
    return(n)
}

checkFunc(5)
checkFunc(3) # Error in checkVal(n) : Value must be greater than 5!

# to trace the error that occurred in the previous function call
traceback()
# 3: stop("Value must be greater than 5!") at #3
# 2: checkVal(n) at #2
# 1: checkFunc(3)

# browser() takes no arguments
# ideally placed just before stop() statement
# once an error occurs it will occur inside a browser env

checkVal <- function(n){
    if(n < 5){
        browser()
        stop("Value must be greater than 5!")
    }
}

callCheckVal <- function(n){
    checkVal(n)
    return(n)
}

callCheckVal(1)

# trace() can be called to see if any errors occur when a function is called by other functions

trace("checkVal") # tracing this function
# every time checkVal() is called by any other function; trace() will be executed when an error 
# occurs

callCheckVal(1)
# opens a browser session as the error occurs

# function body can be viewed in a list format
as.list(body(checkVal))
checkVal

as.list(body(checkVal)[[2]])

# tracking error is simply finding where the stop() got executed
# we know stop() is the 3rd expression inside checkVal() 
# so...
as.list(body(checkVal))
trace("checkVal", tracer =  browser, at = list(c(2,3)))

# The trace() function has a side effect of modifying the function and converting into a new object
# of class “functionWithTrace”

checkVal
# Object with tracing code, class "functionWithTrace"
# Original definition: 
#    function(n){
#        if(n < 5){
#            browser()
#            stop("Value must be greater than 5!")
#        }
#    }
## (to see the tracing code, look at body(object))

# to see the modified code
body(checkVal)

trace(what = checkVal, tracer = function(){
    if(n == 5){
        browser()
        message("Triggering the browser!")
    }
}, at = 2)

checkVal

# The debug() and debugonce() functions can be called on other functions to turn on the
# “debugging state” of a function. Callingdebug() on a function makes it such that when
# that function is called, you immediately enter a browser and can step through the code one
# expression at a time.

myvec <- c(1,"2",3,NA, 2.098, 76, 0.4569)
debug(mean) # now the mean() is in a permanent debug() state
mean(myvec) # browser is called automatically

# debugging state is persistent, so once a function is flagged for debugging, it will remain 
# flagged. Because it is easy to forget about the debugging state of a function, the 
# debugonce() function turns on the debugging state the next time the function is called, 
# but then turns it off after the browser is exited.

debugonce(mean)
mean(myvec)


# recover() function is very useful if an error is deep inside a nested series of function calls
# and it is difficult to pinpoint exactly where an error is occurring
# when an error occurs in code, the code stops execution and you are brought back to the usual R
# console prompt. However, whenrecover() is in use and an error occurs, you are given the function
# call stack and a menu

# every time stop() executes, recover() will be called!
options(error = recover)
mean(myvec)
