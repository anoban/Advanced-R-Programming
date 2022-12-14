library(purrr)

# Side effects of functions occur whenever a function interacts with the “outside world”
# – reading or writing data, printing to the console, and displaying a graph are all side effects. 
# The results of side effects are one of the main motivations for writing code in the first place! 
# Side effects can be tricky to handle though, since the order in which functions with side effects 
# are executed often matters and there are variables that are external to the program
# (the relative location of some data). 
# If you want to evaluate a function across a data structure you should use the walk() function from purrr.

purrr::walk(c(2,4,65,45,674567, 867.564), mean)
purrr::walk(c(2,4,65,45,674567, 867.564), message)
purrr::walk(c(2,4,65,45,674567, 867.564), print)
purrr::walk(c(2,4,65,45,674567, 867.564), sd)
