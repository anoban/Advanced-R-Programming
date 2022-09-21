# The map family of functions applies a function to the elements of a data structure, 
# usually a list or a vector. The function is evaluated once for each element of the vector
# with the vector element as the first argument to the function. 
# The return value is the same kind of data structure (a list or vector) but with every element replaced
# by the result of the function 

library(purrr)

# map characters function
# 1,2,3,4,5 will be replaced by one, two, three .....
purrr::map_chr(seq(1,5,1), function(ind){
    return(c("one", "two", "three","four","five")[ind])
})
# "one"   "two"   "three" "four"  "five" 

purrr::map_chr(seq(5,1,-1), function(ind){
    return(c("one", "two", "three","four","five")[ind])
})
# "five"  "four"  "three" "two"   "one"  

# map logical values (booleans)
purrr::map_lgl(seq(23,32,1), function(n){
    return(n <= 26)
})
# TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE

purrr::map_chr(seq(10,19,1), function(n){
    return(n <= 15)
})
# "TRUE"  "TRUE"  "TRUE"  "TRUE"  "TRUE"  "TRUE"  "FALSE" "FALSE" "FALSE" "FALSE"

# using a condition to map functions to container elements
purrr::map_if(1:10, function(n){ # if conditional evaluation
    return(n <= 5)
}, function(n){ # function to be applied to elements that evaluate TRUE
    return(n^2)
})

# map functions at given indices
purrr::map_at(45:52, 3:5, function(n){
    return(n ^ 3)
})
# will return the cubes of elements at indices 3,4 & 5

# map a function over two data structures with the map2() family of functions.
# The first two arguments should be two vectors of the same length, followed by a function which
# will be evaluated with an element of the first vector as the first argument and an element of the
# second vector as the second argument
purrr::map2_chr(letters, 1:26, paste)


