# Recursive functions have two main parts: a few easy to solve problems called “base cases,” 
# and then a case for more complicated problems where the function is called inside of itself.

# a function that sums up all numbers in a numeric vector
sum_vec <- function(iterable){
    val <- 0
    for (i in iterable){
        if (!is.nan(i)){
            val <- val + i    
        }
    }
    return(val)
}

sum_vec(1:100) # 5050
sum_vec(1:100) == sum(1:100)

# same functions using recursion
recSum <- function(iterable){
    if (length(iterable) == 1 && !is.nan(iterable[1])){ # base case when the vector has just one numeric
        # element
        return(iterable[1])
    }else { # complex case when the vector has multiple elements
        return(iterable[1] + recSum(iterable[-1]))  # recursion
        # takes first element of the iterable and calls the recursive sum function on the remaining
        # elements
    }
}

recSum(1:100)
recSum(seq(1,-1000,-15))
# recursions are poor practice compared to loops
# best avoided in professional settings
# can cause stack overflow!!! in compiled languages!!

# factorial function

fact <- function(n){
    options(digits = 22)
    if(n == 0){
        return(1)
    }else{
        f <- 1
        for (i in n:1){
            f <- f * i
        }
    }
    return(f)
}

fact(1)
fact(0)
fact(100)
factorial(100)

fact(15) == factorial(15)

# recursive factorial
recFac <- function(n){
    if (n >= 1){
        return(n * recFac(n-1))    # recursion
    }else{
        return(1)
    }
}

recFac(10)
factorial(10)
recFac(15) == factorial(15)
recFac(0)

# Another useful exercise for thinking about applications for recursion is computing the Fibonacci
# sequence. The Fibonacci sequence is a sequence of integers that starts: 0, 1, 1, 2, 3, 5, 8 
# where each proceeding integer is the sum of the previous two integers

fibgen <- function(end){
    fib <- c(0,1)   # initializing the Fibonacci vector
    i <- 0  # initializing the sum of last two elements
    while(i < end){    # while the sum of last 2 elements is less than end 
        # this evaluation is unaware of the update for i below!!
        i <- fib[length(fib)] + fib[length(fib) - 1]
        if (i <= end){  # re-evaluation not to push i if it is greater than end
            fib <- append(fib, i)        
        }
    }
    return(fib)
}

fibgen(10)
fibgen(15)
fibgen(20)
fibgen(25)
fibgen(50)

fibo <- function(len){
    fib <- c(0,1)
    while(length(fib) < len){
        fib <- append(fib, sum(fib[length(fib)], fib[length(fib) - 1]))
    }
    return(fib)
}

fibo(10)
length(fibo(10))
fibo(15)
fibo(20)

# recursive fibonacci sequence
fibgenRec <- function(begin = c(0,1), end){
    if(begin[length(begin)] < end){
        begin <- append(begin, sum(begin[c(length(begin)-1, length(begin))]))
    }
    return(fibgenRec(begin, end))
}

fibgenRec(, 15) # Error: C stack usage  15928464 is too close to the limit

# a function to compute the nth digit of the Fibonacci sequence such that the first number in the
# sequence is 0, the second number is 1,

fibFind <- function(n){
    fibSeq <- c(0,1)
    if(n > 2){
        for (i in 3:n){ # we already have the first two numbers, so start with three
            fibSeq <- c(fibSeq[length(fibSeq)], sum(fibSeq[c(length(fibSeq)-1, length(fibSeq))]))
        }
        return(fibSeq[2])
    }else if(n == 1){
        return(0)
    }else if(n == 2){
        return(1)
    }
    
}

fibFind(5)
fibFind(6)
fibFind(7)
fibFind(1)
fibFind(2)
fibFind(100)
fibFind(20)

fibo(20)

# great :))

