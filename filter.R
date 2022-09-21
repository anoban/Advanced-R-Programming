library(purrr)

# only the elements of the vector that satisfy the predicate function are returned 
# while all other elements are removed
purrr::keep(1:15, function(n){
    return(n %% 2 == 0)
})

purrr::keep(1:15, function(n){
    return(n %% 2 != 0)
})

# only returns elements that don’t satisfy the predicate function
purrr::discard(1:20, function(n){
    return(n^2 < 100)
})

purrr::discard(1:20, function(n){
    return(n < 10)
})

# returns TRUE only if every element in the vector satisfies the predicate function
purrr::every(1:10, function(n){
    return(n %% 2 == 0)
})

purrr::every(seq(0,10,2), function(n){
    return(n %% 2 == 0)
})

purrr::every(1:10, function(n){
    return(n > 9)
})

# returns TRUE if at least one element in the vector satisfies the predicate function
purrr::some(1:100, function(n){
    return(n > 99)
})

purrr::some(25:50, function(n){
    return(n >= 49)
})
