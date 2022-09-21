library(purrr)

grepl("A", letters, ignore.case = FALSE)
grepl("a", letters, ignore.case = FALSE)
grepl("A", letters, ignore.case = TRUE)
grepl("A", LETTERS, ignore.case = FALSE)

# returns the first element of the vector for which the predicate function returns TRUE
purrr::detect(23:56, function(n){
    return(n > 30 && n <= 35)
})

# returns the index of the provided vector which contains the 
# first element that satisfies the predicate function
purrr::detect_index(100:199, function(n){
    return(n > 179 && n %% 4 != 0)
})

