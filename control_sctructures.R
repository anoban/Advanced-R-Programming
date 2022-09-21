library(swirl)

# installing the swirl course materials
swirl::install_course("Advanced R Programming")

# conditional clauses
x <- 190

if (x <= 500){
    x <- x^2
    print(x)
}

# works fine
x == 190^2  # TRUE

if (x == 190){
    print("X is equal to 190")
}else if (x == 190^2){
    print("X is equal to 190^2")
}else{
    print("Whatever")
}

# random uniform number generator
runif(n = 100, min = 10, max = 11)

# dangling ifs are also valid in R
# these are two separate if conditions!!!!
if (19 < 76){
    print("19 is less than 76")
}
if (19 > 16){
    print("19 is greater than 16")
}


# for loops
nums <- runif(1000, min = 198, max = 200)
lessthan_or_eq_199 <- 0
greater_than_199 <- 0
for (i in nums){
    if (i <= 199){
        lessthan_or_eq_199 <- lessthan_or_eq_199 + i
    }else if (i > 199){
        greater_than_199 <- greater_than_199 + i
    }
}
lessthan_or_eq_199
greater_than_199

sum(nums[nums <= 199]) == lessthan_or_eq_199  # TRUE
sum(nums[nums > 199]) == greater_than_199  # TRUE

class(nums)
typeof(nums)

floats <- seq(1,1000,0.5)
length(floats)  # 1999

total <- 0
for (i in 1:1999){
    total <- total + floats[i]
}

total
total == sum(floats)  # TRUE

# unlike Python, R includes upper limit also!!!
1:10

# seq along function generates a range based on the length of the iterable passed as the argument

seq(1,10,1)
1:10 == seq(1,10,1)
mean(1:10 == seq(1,10,1))  # 1

seq_along(1:10)
seq(10)
seq(1,10)
x <- 1:100

# sum of even numbers between 100 & 1000
sum_even <- 0
sum_odd <- 0
for (i in 1:1000){
    if (i %% 2 == 0){
        sum_even <- sum_even + i
    }else if (i %% 2 != 0){
        sum_odd <- sum_odd + i
    }
}

sum_even
sum_odd
myrange <- seq(1,1000,1)
sum_even == sum(myrange[myrange %% 2 == 0])
sum_odd == sum(myrange[myrange %% 2 != 0])

# curly braces are not necessary in one line loops
for (i in 100:115) print(i)

# nested for loop
for (i in 1:10){
    for (j in 10:20){
        print(sum(i,j))
    }
}


# a dummy square matrix
dummy_mat <- matrix(seq(1,100,1), 10, 10)

for (i in 1:10){
    for (j in 1:10){
        print(dummy_mat[i,j])
    }
}


for (i in 1:10){
    for (j in 1:10){
        print(dummy_mat[j,i])
    }
}

# next will jump to the next iteration
dummy_vector <- c()
for (i in 1:100){
    if (i != 49){
        dummy_vector <- c(dummy_vector, i)
    }else if (i == 49){
        next
    }
}

# resulting vector must have all integers between the 1 & 100 except for 49
dummy_vector  # perfecto

# break breaks out of the loop when the specified condition is satisfied
new_vector <- c()
for (i in seq(1,1.5, length.out = 1000)){
    if(i < 1.25){
        new_vector <- c(new_vector, i)
    }else if (i > 1.25){
        new_vector <- c(new_vector, -i)  # this line will never be executed since the loop will break
        # when i == 1.25 :((
    }else if (i == 1.25){
        break
    }
}

new_vector
sum(new_vector == 1.25)  # 0 :))





