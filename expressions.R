# Expressions are encapsulated operations that can be executed by R. 
# This may sound complicated, but using expressions allows you manipulate code with code! 
# You can create an expression using the quote() function. 
# For that function’s argument, just type whatever you would normally type into the R console

exp_add <- quote(4+8)
exp_add

# You can execute this expressions using the eval() function
eval(exp_add) # 12

mul <- quote(34 * 32.6478645)
eval(mul)

str_exp <- "34 ^ 2.3454"
# parse() always returns an expression
parse(text = str_exp)
eval(parse(text = str_exp))

eval(str2expression("48/5.4164"))

# transform an expression into a string 
deparse(quote(34 + 657 ^ 2.4576 / 34))

dummy <- quote(6.7657^(3.90/2.767%%0.3234))
eval(dummy)


# you can access and modify their contents like you a list().
# This means that you can change the values in an expression, or even the function being executed
# in the expression before it is evaluated

dummy_exp <- quote(sum(12, 56, 23.765))
dummy_exp[1] # sum()
dummy_exp[[1]] # sum
dummy_exp[2] # 12()
dummy_exp[[2]] # 12

dummy_exp[[1]] <- max
dummy_exp[[2]] <- 0.1352
dummy_exp[[3]] <- 10.1453
eval(dummy_exp)


# call() function.
# The first argument is a string containing the name of a function, followed by the 
# arguments that will be provided to that function

call("max", 78:193)
eval(call("max", 78:193))
eval(call("median", 78:193))
eval(call("mean", 78:193))
