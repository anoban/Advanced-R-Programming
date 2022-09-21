# one can pass functions as arguments to functions
# similar to the apply family of functions!

compute <- function(fn, data){
	return(fn(data))
}
# above is a function that takes other functions as arguments
eg:
compute(mean, c(1,2,3,4,5,6,7,8,9))
compute(sd, c(1,2,3,4,5,6,7,8,9))
compute(median, c(1,2,3,4,5,6,7,8,9))
compute(min, c(1,2,3,4,5,6,7,8,9))

# to get the arguments a function expects
args(function)

# R allows arguments of functions to be disorderly passed when the arguments are explicitly included
# eg: a function 
determine(data, function, params) 
# takes three arguments

# when passing values without explicitly stating the arguments they must be passed in the expected order!!
determine(mydata, myfunc, pivot_wider)
# such order is not necessary when passed along the argument specifiers!
determine(function = myfunc, params = pivot_wider, data = mydata) 


# like JavaScript R also accepts anonymous functions
compute(function(x){sum(x)}, data)
# first argument passed for the compute function is an anonymous function!

# find the first element
compute(function(x){return(x[1])}, c(8, 4, 0))
# find the last element
compute(function(x){return(x[length(x)])}, c(8, 4, 0))

# R functions accept ellipsis "..." as an argument which allows to pass infinite number of arguments!
report <- function(name, ...){
	text <- paste(name, "said that", ..., sep = " ")
	return(text)
}

report("Julie", "Hi", "there", "dumbass", "......", "yes", "you", "dumbass", "you!")


# unpacking the values passed inplace of ellipsis for a R function!
reportedSpeech <- function(person, ...){
	arguments <- list(...)	# capturing the values passed in place of the ellipsis!
}

# we can pass named arguments inplace of the ellipsis
reportedSpeech(person = "Natalie", noun = "She", adjective = "famous", verb = "sung", adverb = "melancholically")

# these arguments can be captured & unpacked
reportedSpeech <- function(...){
	arguments <- list(...)	# capturing
	# unpacking!
	name <- arguments[["person"]]
	noun <- arguments[["noun"]]
	adj <- arguments[["adjective"]]
	action <- arguments[["verb"]]
	adv <- arguments[["adverb"]]
}


# another example
mad_libs <- function(...){
  # Do your argument unpacking here!
  comps <- list(...)
  place <- comps[["place"]]
  adjective <- comps[["adjective"]]
  noun <- comps[["noun"]]
  # Don't modify any code below this comment.
  # Notice the variables you'll need to create in order for the code below to
  # be functional!
  return(paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.", sep = " "))
}

# defining binary operators like +, -, /, *, ^ etc!
# User-defined binary operators have the following syntax:
#      %[whatever]% 
# where [whatever] represents any valid variable name.

"%mult_add_one%" <- function(left, right){ # Notice the quotation marks!
   left * right + 1
}

"%**%" <- function(left, right){	# Python inspired power operator!
	return(left ^ right)
}

23 ^ 2 == 23 %**% 2

