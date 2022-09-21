library(purrr)

# combines any number of functions into one function
sum_of_unique <- purrr::compose(sum, unique)
sum_of_unique(rep(1:10, c(3:12))) # 55
sum(1:10) # 55


