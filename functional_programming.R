# Functional programming concentrates on four constructs:
# 1) Data (numbers, strings, etc)
# 2) Variables (function arguments)
# 3) Functions
# 4) Function Applications (evaluating functions given arguments and/or data)

# By now you’re used to treating variables inside of functions as data, 
# whether they’re values like numbers and strings, or they’re data structures like lists and vectors.
# With functional programming you can also consider the possibility that you can provide a function
# as an argument to another function, and a function can return another function as its result.

# example of a function that takes another function as argument
args(mean)
apply(data, MARGIN = 0, FUN = as.numeric)

# functions that return a function
generateMultiples <- function(start){
    return(function(end){
        result <- 1
        for (i in start:end){
            result <- result * i
        }
        return(result)
    })
}

fact <- generateMultiples(3)
fact(6) # 360 = 6*5*4*3

fact <- generateMultiples(10)
fact(19)  # 335221286400
factorial(19) / factorial(9) == fact(19)

fact <- generateMultiples(67)
fact(88)
factorial(88) / factorial(66)

fact <- generateMultiples(7)
fact(15)
factorial(15) / factorial(6) == fact(15)

