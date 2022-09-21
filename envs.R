# Environments are data structures in R that have special properties with regard to their role in how R
# code is executed and how memory in R is organized

# initializing a new environment
dummy_env <- new.env()

# creating variables inside the new environment
dummy_env$dummy_var <- 23.656
dummy_var # Error: object 'dummy_var' not found
# this variable belongs to the scope of the dummy_env so, not available in the global scope

dummy_env$dummy_var
# here we go.... :))

# assign() can also be used to create variables inside local environments
assign("mySeq", seq(1,10,0.5), envir = dummy_env)
dummy_env$mySeq

# get all variables in an environment by ls()
ls()
ls(envir = dummy_env)

# delete variables in environments using rm()
a
rm(a)
a # Error: object 'a' not found
dummy_env$mySeq
rm(mySeq, envir = dummy_env)
dummy_env$mySeq # NULL

# check the existence of variables in environments
exists("str_exp")
exists("dummy_var", envir = dummy_env)


# Environments are organized in parent/child relationships such that every environment keeps track
# of its parent, but parents are unaware of which environments are their children. 
# Usually the relationships between environments is not something you should try to directly control.
# You can see the parents of the global environment using the search() function

search()

# in general the parent of .GlobalEnv is always the last package that was loaded using library()
library(lattice)
search()


# An execution environment is an environment that exists temporarily within the scope of a function
# that is being executed

x <- 10 # global

dummy <- function(){
    x <- 9.00 # execution env
    return(x)
}

dummy() # 9
x  # 10

dummy <- function(){
    return(x)
}

dummy() # 10

# when the given variable is not available in the execution env, R looks for that variable in the 
# parent env of the exec env!!

# complex assignment operator which looks like <<- can re-assign or even create name-value bindings in
# the global environment from within an execution environment

assign_glob <- function(var_name, var_val){
    var_name <<-  var_val
}

assign_glob(dummy, 20)
# does not work
dummy

assign_smthn <- function(){
    myVar <<- seq(3,3.5, length.out = 25)
}

assign_smthn()
myVar
exists("myVar")
