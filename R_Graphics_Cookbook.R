plot(mtcars$wt, mtcars$mpg)

library(ggplot2)
qplot(mtcars$wt, mtcars$mpg)
# if the two vectors are already in the same data frame, you can use the following syntax:
qplot(wt,mpg,data=mtcars)
# this is equivalent to:
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()

# 2.2
# in basic R
plot(pressure$temperature, pressure$pressure, type = "l")
points(pressure$temperature, pressure$pressure)

lines(pressure$temperature, pressure$pressure/2,col="red")
points(pressure$temperature, pressure$pressure/2,col="red")

# whit ggplot2 
qplot(pressure$temperature, pressure$pressure,geom = "line")
# If the two vectors are already in the same data frame, you can use the following syntax:
qplot(temperature, pressure, data = pressure, geom="line")
# this is equivalent to :
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line()

# lines and points togther
qplot(temperature, pressure, data=pressure, geom=c("line","point"))
# equivalent to:
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()

# 2.3 Creating a bar graph
barplot(BOD$demand, names.arg = BOD$Time)
# sometimes "bar graph" refers to a graph where the bars represent the count of cases in each category.
# This is similar to a histogram, but with a discrete instead of continuous x-axis. To generate the 
# count of each unique value in a vector, use the table() function:
table(mtcars$cyl)
# There are 11 cases of the value 4, 7 cases of 6, and 14 cases of 8
# Simply pass the table to barplot() to generate the graph of counts:
barplot(table(mtcars$cyl))

# with the ggplot2:
qplot(BOD$time, BOD$demand, geom="bar", stat="identity") # wrong
qplot(BOD$Time, BOD$demand, geom="bar", stat="identity") # wrong
qplot(factor(BOD$Time), BOD$demand, geom="bar", stat="identity") # wrong
# convert the x

# If the vector is in a data frame, you can use the following syntax:
qplot(Time, demand, data=BOD, geom="bar", stat="identity") # wrong

ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")
ggplot(BOD, aes(x=factor(Time), y=demand)) + geom_bar(stat="identity")

# yes
ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()

# 2.4
hist(mtcars$mpg)
# specify approximate number of bins with breaks
hist(mtcars$mpg, breaks=10)

# with ggplot2
qplot(mtcars$mpg)
#If the vector is in a data frame, you can use the following syntax:
qplot(mpg, data=mtcars, binwidth=4)
# this is equivalent to :
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 4)

# 2.5 Creating a Box Plot
plot(ToothGrowth$supp, ToothGrowth$len)










