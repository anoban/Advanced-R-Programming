library(purrr)

# reduce family of functions
# iteratively combines the first element of a vector with the second element of a vector, then that
# combined result is combined with the third element of the vector, and so on until the end of the vector
# is reached

purrr::reduce(1:10, function(n,m){
    return(n+m)
})
# 55
sum(1:10) # 55

purrr::reduce(1:10, function(x,y){
    return(x*y)
})
# 3628800
factorial(10) # 3628800

# starts with the last element of a vector and then proceeds to the second to last element of a vector
# and so on
purrr::reduce(1:10, function(x,y){
    return(x-y)
}, .dir = "backward")   # -5

val <- 10
for (i in 9:1){
    val <- val - i
}
val #-35
