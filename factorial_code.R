# Factorial_loop: a version that computes the factorial of an integer using looping (such as a for loop)
# Factorial_reduce: a version that computes the factorial using the reduce() function in the purrr package.
# Alternatively, you can use the Reduce() function in the base package.
# Factorial_func: a version that uses recursion to compute the factorial.
# Factorial_mem: a version that uses memoization to compute the factorial.

Factorial_loop <- function(n){
    if(!is.numeric(n) || n < 0 || {n != as.integer(n)}){    # stop execution if the input is non-numeric or negative number or
        # a floating point value
        stop("Input value must be a non-negative integer!")
    }
    else if(n == 0 || n == 1) return(1) # 0! = 1, 1! = 1
    else{
        result <- 1
        for(i in 1:n){
            result <- result * i
        }
        return(result)
    }
}

Factorial_func <- function(n){
    if(!is.numeric(n) || n < 0 || {n != as.integer(n)}){
        stop("Input value must be a non-negative integer!")
    }
    else if(n == 0 || n == 1) return(1)
    else{
        return(n * Factorial_func(n-1))    # recursion
    }
}

Factorial_reduce <- function(n){
    if(!is.numeric(n) || n < 0 || {n != as.integer(n)}){
        stop("Input value must be a non-negative integer!")
    }else if(n == 0) return(1)
    else{
        return(Reduce(`*`, as.numeric(1:n)))
    }
}

memVec <- c(0,1)  # numeric vector that is to memorize factorial values, as computations happen
Factorial_mem <- function(n){
    if(!is.numeric(n) || n < 0 || {n != as.integer(n)}) stop("Input value must be a non-negative integer!")
    else if(n == 0) return(1)
    else if(n > 0 & n <= 2) return(n)
    else if(n > 2){
        if(all(is.na(memVec[3:length(memVec)]))){    # if all indices above 2 & below n are empty
            value <- factorial(n)  # compute the factorial using the base R's factorial() function
            memVec[n] <<- value  # append the result to the memoization vector
            return(value)
        }
        else if(!is.na(memVec[n])) return(memVec[n])    # if the required value exists in the memVec, just return it
        else if(!all(is.na(memVec[3:length(memVec)]))){ # if there are any indices with numeric values, after 2nd index
            closest_left_ind <- which.max(memVec[1:n])  # getting the index of the highest value at the left side of memoization vector
            closest_right_ind <- which.min(memVec[n:length(memVec)]) + n - 1  # get the index of the lowest value at the right of the memoization vector
            if(n - closest_left_ind <= closest_right_ind - n){  # evaluate which value is closer
                message("Factorial value for ", closest_left_ind, " was found in memory and used in computation!")
                value <- memVec[closest_left_ind] * Reduce(`*`, as.numeric(n:(closest_left_ind+1)))   # compute the factorial using
                # the memorized factorial value of the closest number
                memVec[n] <<- value # append the values to the memoization vector
                return(value)
            }
            else if(n - closest_left_ind > closest_right_ind - n){
                message("Factorial value for ", closest_right_ind, " was found in memory and used in computation!")
                value <- memVec[closest_right_ind] / Reduce(`*`, as.numeric(((n+1):(closest_right_ind-1))))
                memVec[n] <<- value
                return(value)
            }
        }
    }
}

library(microbenchmark)
memVec <- c(0,1)  # re-initialized memVec for benchmarking!
# benchmarking in ascending order of numbers!
microbenchmark(Factorial_func(1), Factorial_loop(1), Factorial_reduce(1), Factorial_mem(1), times = 1000)
microbenchmark(Factorial_func(6), Factorial_loop(6), Factorial_reduce(6), Factorial_mem(6), times = 1000)
microbenchmark(Factorial_func(11), Factorial_loop(11), Factorial_reduce(11), Factorial_mem(11), times = 1000)
microbenchmark(Factorial_func(16), Factorial_loop(16), Factorial_reduce(16), Factorial_mem(16), times = 1000)
microbenchmark(Factorial_func(21), Factorial_loop(21), Factorial_reduce(21), Factorial_mem(21), times = 1000)
microbenchmark(Factorial_func(26), Factorial_loop(26), Factorial_reduce(26), Factorial_mem(26), times = 1000)
microbenchmark(Factorial_func(31), Factorial_loop(31), Factorial_reduce(31), Factorial_mem(31), times = 1000)
microbenchmark(Factorial_func(36), Factorial_loop(36), Factorial_reduce(36), Factorial_mem(36), times = 1000)
microbenchmark(Factorial_func(41), Factorial_loop(41), Factorial_reduce(41), Factorial_mem(41), times = 1000)
microbenchmark(Factorial_func(46), Factorial_loop(46), Factorial_reduce(46), Factorial_mem(46), times = 1000)
microbenchmark(Factorial_func(51), Factorial_loop(51), Factorial_reduce(51), Factorial_mem(51), times = 1000)
microbenchmark(Factorial_func(56), Factorial_loop(56), Factorial_reduce(56), Factorial_mem(56), times = 1000)
microbenchmark(Factorial_func(61), Factorial_loop(61), Factorial_reduce(61), Factorial_mem(61), times = 1000)
microbenchmark(Factorial_func(66), Factorial_loop(66), Factorial_reduce(66), Factorial_mem(66), times = 1000)
microbenchmark(Factorial_func(71), Factorial_loop(71), Factorial_reduce(71), Factorial_mem(71), times = 1000)
microbenchmark(Factorial_func(76), Factorial_loop(76), Factorial_reduce(76), Factorial_mem(76), times = 1000)
microbenchmark(Factorial_func(81), Factorial_loop(81), Factorial_reduce(81), Factorial_mem(81), times = 1000)
microbenchmark(Factorial_func(86), Factorial_loop(86), Factorial_reduce(86), Factorial_mem(86), times = 1000)
microbenchmark(Factorial_func(91), Factorial_loop(91), Factorial_reduce(91), Factorial_mem(91), times = 1000)
microbenchmark(Factorial_func(96), Factorial_loop(96), Factorial_reduce(96), Factorial_mem(96), times = 1000)
microbenchmark(Factorial_func(101), Factorial_loop(101), Factorial_reduce(101), Factorial_mem(101), times = 1000)
microbenchmark(Factorial_func(106), Factorial_loop(106), Factorial_reduce(106), Factorial_mem(106), times = 1000)
microbenchmark(Factorial_func(111), Factorial_loop(111), Factorial_reduce(111), Factorial_mem(111), times = 1000)
microbenchmark(Factorial_func(116), Factorial_loop(116), Factorial_reduce(116), Factorial_mem(116), times = 1000)
microbenchmark(Factorial_func(121), Factorial_loop(121), Factorial_reduce(121), Factorial_mem(121), times = 1000)
microbenchmark(Factorial_func(126), Factorial_loop(126), Factorial_reduce(126), Factorial_mem(126), times = 1000)
microbenchmark(Factorial_func(131), Factorial_loop(131), Factorial_reduce(131), Factorial_mem(131), times = 1000)
microbenchmark(Factorial_func(136), Factorial_loop(136), Factorial_reduce(136), Factorial_mem(136), times = 1000)
microbenchmark(Factorial_func(141), Factorial_loop(141), Factorial_reduce(141), Factorial_mem(141), times = 1000)
microbenchmark(Factorial_func(146), Factorial_loop(146), Factorial_reduce(146), Factorial_mem(146), times = 1000)
microbenchmark(Factorial_func(151), Factorial_loop(151), Factorial_reduce(151), Factorial_mem(151), times = 1000)
microbenchmark(Factorial_func(156), Factorial_loop(156), Factorial_reduce(156), Factorial_mem(156), times = 1000)
microbenchmark(Factorial_func(161), Factorial_loop(161), Factorial_reduce(161), Factorial_mem(161), times = 1000)
microbenchmark(Factorial_func(166), Factorial_loop(166), Factorial_reduce(166), Factorial_mem(166), times = 1000)
microbenchmark(Factorial_func(170), Factorial_loop(170), Factorial_reduce(170), Factorial_mem(170), times = 1000)

# benchmarking in descending order of numbers!
memVec <- c(0,1)
microbenchmark(Factorial_func(170), Factorial_loop(170), Factorial_reduce(170), Factorial_mem(170), times = 1000)
microbenchmark(Factorial_func(165), Factorial_loop(165), Factorial_reduce(165), Factorial_mem(165), times = 1000)
microbenchmark(Factorial_func(160), Factorial_loop(160), Factorial_reduce(160), Factorial_mem(160), times = 1000)
microbenchmark(Factorial_func(155), Factorial_loop(155), Factorial_reduce(155), Factorial_mem(155), times = 1000)
microbenchmark(Factorial_func(150), Factorial_loop(150), Factorial_reduce(150), Factorial_mem(150), times = 1000)
microbenchmark(Factorial_func(145), Factorial_loop(145), Factorial_reduce(145), Factorial_mem(145), times = 1000)
microbenchmark(Factorial_func(140), Factorial_loop(140), Factorial_reduce(140), Factorial_mem(140), times = 1000)
microbenchmark(Factorial_func(135), Factorial_loop(135), Factorial_reduce(135), Factorial_mem(135), times = 1000)
microbenchmark(Factorial_func(130), Factorial_loop(130), Factorial_reduce(130), Factorial_mem(130), times = 1000)
microbenchmark(Factorial_func(125), Factorial_loop(125), Factorial_reduce(125), Factorial_mem(125), times = 1000)
microbenchmark(Factorial_func(120), Factorial_loop(120), Factorial_reduce(120), Factorial_mem(120), times = 1000)
microbenchmark(Factorial_func(115), Factorial_loop(115), Factorial_reduce(115), Factorial_mem(115), times = 1000)
microbenchmark(Factorial_func(110), Factorial_loop(110), Factorial_reduce(110), Factorial_mem(110), times = 1000)
microbenchmark(Factorial_func(105), Factorial_loop(105), Factorial_reduce(105), Factorial_mem(105), times = 1000)
microbenchmark(Factorial_func(100), Factorial_loop(100), Factorial_reduce(100), Factorial_mem(100), times = 1000)
microbenchmark(Factorial_func(95), Factorial_loop(95), Factorial_reduce(95), Factorial_mem(95), times = 1000)
microbenchmark(Factorial_func(90), Factorial_loop(90), Factorial_reduce(90), Factorial_mem(90), times = 1000)
microbenchmark(Factorial_func(85), Factorial_loop(85), Factorial_reduce(85), Factorial_mem(85), times = 1000)
microbenchmark(Factorial_func(80), Factorial_loop(80), Factorial_reduce(80), Factorial_mem(80), times = 1000)
microbenchmark(Factorial_func(75), Factorial_loop(75), Factorial_reduce(75), Factorial_mem(75), times = 1000)
microbenchmark(Factorial_func(70), Factorial_loop(70), Factorial_reduce(70), Factorial_mem(70), times = 1000)
microbenchmark(Factorial_func(65), Factorial_loop(65), Factorial_reduce(65), Factorial_mem(65), times = 1000)
microbenchmark(Factorial_func(60), Factorial_loop(60), Factorial_reduce(60), Factorial_mem(60), times = 1000)
microbenchmark(Factorial_func(55), Factorial_loop(55), Factorial_reduce(55), Factorial_mem(55), times = 1000)
microbenchmark(Factorial_func(50), Factorial_loop(50), Factorial_reduce(50), Factorial_mem(50), times = 1000)
microbenchmark(Factorial_func(45), Factorial_loop(45), Factorial_reduce(45), Factorial_mem(45), times = 1000)
microbenchmark(Factorial_func(40), Factorial_loop(40), Factorial_reduce(40), Factorial_mem(40), times = 1000)
microbenchmark(Factorial_func(35), Factorial_loop(35), Factorial_reduce(35), Factorial_mem(35), times = 1000)
microbenchmark(Factorial_func(30), Factorial_loop(30), Factorial_reduce(30), Factorial_mem(30), times = 1000)
microbenchmark(Factorial_func(25), Factorial_loop(25), Factorial_reduce(25), Factorial_mem(25), times = 1000)
microbenchmark(Factorial_func(20), Factorial_loop(20), Factorial_reduce(20), Factorial_mem(20), times = 1000)
microbenchmark(Factorial_func(15), Factorial_loop(15), Factorial_reduce(15), Factorial_mem(15), times = 1000)
microbenchmark(Factorial_func(10), Factorial_loop(10), Factorial_reduce(10), Factorial_mem(10), times = 1000)
microbenchmark(Factorial_func(5), Factorial_loop(5), Factorial_reduce(5), Factorial_mem(5), times = 1000)
