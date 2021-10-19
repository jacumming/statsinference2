#
# PRACTICAL 1-2: Sampling Distributions
# ---------------------------------
#
#
# In this session we perform simple simulation exercises in order to investigate the properties
# of the sample mean introduced in the lectures.
# 
# Today we will learn R techniques beyond those seen in the first year (if you were a Statistics I
# student), including the use of loops and writing your own functions. 
  

# You will need the following skills from previous practicals:
#   *   Basic R skills with arithmetic, functions, etc
#   *   Manipulating and creating vectors: `c`, `seq`, 
#   *   Calculating data summaries: `mean`, `sd`, `var`, `min`, `max`
#   *   Plotting a scatterplot with `plot`, and a histogram with `hist`
#
# New R techniques:
#   *   Sampling with and without replacement from a vector using `sample`
#   *   Creating new functions with `function`
#   *   Creating traditional `for` loops to iterate calculations
#   *   Using `sapply` to repeat calculations over a vector of values
#   *   Using `par(mfrow=c(a,b))` to setup a grid of plots
#   *   Adding straight lines to plots with `abline`

#
#
# 1. Sampling without replacement
# ==================================================================================
#
# We'll be using the `hospital` data set from the `durham` library in our sampling
# experiments. So, before we begin you'll need to load the data:


#
# Exercise:
# ~~~~~~~~~~~~~
# * Refer to the worksheet from last time and either:
#    * Load the `durham` library and the `hospital` data set.
#    * If you have problems loading the library, follow the link on the webpage to create
#      the data set without the library
# * Create a new vector called `disch` (or similar) containing the data for the number of 
#   discharges in the `hospital` data.












# Recall that our general approach to sampling is to sample without replacement, so we don't
# repeatedly observe the same individual from the population. We can use `R`'s `sample` function
# to take random samples from a specified population vector, and we can do so either with or 
# without replacement.

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ The `sample` function allows us to take a sample of a specified size from a vector of values
# ^ which is treated as the population. 
# ^ 
# ^ If we have a population vector `pop` and we want to take a sample of size `n` without replacement,
# ^ then we use the following command:
# ^   
# ^ `sample(pop, n)`
# ^ 
# ^ If we want to sample _with_ replacement, then we can add the additional optional argument
# ^ `replace=TRUE`.
# ^ 
# ^ Finally, the default is for all of the elements of the population to have equal probability. This
# ^ can be changed to specified probability weights using the `prob` argument, but we won't be looking
# ^ into that any further. See the help file (by running `?sample`) for more details on the `sample`
# ^ function.
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



#
# Exercise:
# ~~~~~~~~~~~~~
# * Draw a sample (without replacement) of size n=4 from the discharges data.
# * Draw another sample of size n=4  - do you get the same sample values?
# * Let's experiment with changing the sample size. For sample sizes n_1=4, n_2=16, and n_3=64
#   generate a random sample, and compute its sample `mean`. Do this in three lines, one for each
#   sample size.
# * Compare the three means - what would you expect to see?
















# We will be performing a repeated sampling experiment where we repeat the sampling many times
# to generate different samples each time. Then we can use the many samples to produce many 
# different sample means, which we can explore to check their behaviour against what we would
# expect from the theory seen in lectures.

#
#
# 2. Functions and Loops
# ==================================================================================
#
#
# To simplify the repeated sampling calculation, we will use a loop to repeat the calculations
# and we will write our own function to take care of the calculations we wish to perform during 
# each iteration.


#
# 2.1 Functions
# ----------------------------------------------------------------------------------
# 
# As with other programming languages (such as Python), we can combine multiple commands in `R` 
# into our own custom functions that perform more complicated tasks or calculations. Throughout
# the year, we will be writing our own functions to solve specific problems and today we will learn
# the basic syntax of how to create a function.


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ When creating a new function, it needs to have a name, probably at least one argument 
# ^ (although it doesn’t have to), and a body of code that does something. At the end it usually
# ^ should (although doesn’t have to) return a value or object out of the function. 
# ^ 
# ^ The general syntax for writing your own function is
# ^ 
# ^    name.of.function <- function(arg1, arg2, arg3=2) {
# ^       # function code to do some useful stuff
# ^       return(something) # return value 
# ^    }
# ^ 
# ^  + `name.of.function`: is the function’s name. This can be any valid variable name, but you 
# ^     should avoid using names that are used elsewhere in R, such as `mean`, `function`, 
# ^     `plot`, etc.
# ^  + `arg1`, `arg2`, `arg3`: these are the arguments of the function. You can write a 
# ^     function with any number of arguments, or none at all. These can be any _R_ object: numbers,
# ^     strings, arrays, data frames, or even other functions. Essentially, this is the list of 
# ^     everything that is needed for the `name.of.function` function to run.
# ^     Some arguments have default values specified, such as `arg3` in our example, which is set to
# ^     `2` unless otherwise specified. Arguments without a default must have a value supplied for 
# ^     the function to run. You do not need to provide a value for those arguments with a default 
# ^     as they are considered as optional, and when omitted the function will simply use the default
# ^     value in its definition.
# ^  + Function body: The function code between the within the `{}` brackets is run every time the
# ^    function is called. Note that unlike Python where the code _inside_ the function is _indented_,
# ^    with `R` the code inside the function must be enclosed in curly braces `{}`. This code might
# ^    be very long or very short. Ideally functions are short and do just one thing – problems are 
# ^    rarely too small to benefit from some abstraction. Sometimes a large function is unavoidable,
# ^    but usually these can be in turn constructed from a number of small functions. 
# ^  + Return value: The last line of the code is the value that will be returned by the function. 
# ^    It is not necessary that a function return anything, for example a function that makes a plot
# ^    might not return anything (and so either state `return()` or omitting the `return` statement
# ^    entirely), whereas a function that does a mathematical operation might return a number, or a 
# ^    vector.
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


# For example, we can write a function to compute the sum of squares of two numbers as

sum.of.squares <- function(x,y) {
  return(x^2 + y^2)
}

# and we can then evaluate

sum.of.squares(3,4)





#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Create a function called `MyFun` that takes a single argument `x` and returns the 
#   value of 1 + x + 0.1 x^2.
# * Use your function to evaluate 1+x+0.1x^2 when x=0.
# * Create a vector of the integers from 0 to 100, and evaluate 1+x+0.1x^2 for x=0,...,100. 
#   You should do this in one line without resorting to any loops or iterative methods, or 
#   temporary variables.
#   _Hint:_ See the previous practical for how to create vectors of integer sequences, and how
#           to do arithmetic with vectors.
# * Create another function called `MyFunPlotter`, which takes a single argument `x`, and which
#   draws a scatter`plot` of the points `(x, MyFun(x))`. Evalate your function for x=0,...,100.
#   _Hint:_ See the previous practical for how to draw scatterplots, and use your function from 
#           the previous part of the question.














#
# 2.2 Simple Loops
# ----------------------------------------------------------------------------------
# 
# 
# A "loop"" is a way to repeat a sequence of instructions under certain conditions. They allow
# you to automate parts of your code that are in need of repetition. We will look at two ways 
# of creating loops in our code: 
# 
# * Traditional loops which execute for a prescribed number of times, as controlled by a counter
#   or an index, incremented at each iteration cycle are represented as `for` loops in _R_. You will
#   probably have seen these before with Python.
# * Loops that take a function and apply that function to every element of a vector (or other array)
#   are represented by the various `apply` functions in _R_.


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ In _R_ a "for"  loop takes the following general form:
# ^ 
# ^    for (variable in sequence) { 
# ^      ## code to repeat goes here
# ^    }
# ^ 
# ^ where `variable` is a name given to the iteration variable and which takes each possible value
# ^ in the vector `sequence` at each pass through the loop.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Here is a quick trivial example, printing the square root of the integers one to ten:

for (x in 1:10) {
  print(sqrt(x))
}

#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Sometimes big loops aren't necessary! Write a single line of code that computes the square root 
#   of the integers 1 to 10 without using `for`. 
# * Use a `for` loop to:
#    * Print the values of the integers $1$ to $5$.
#    * Print the squares of the integers from $10$ to $3$.
#    * Print your first name 10 times.















# While `for` loops are helpful when we need to explictly repeat a block of code, sometimes we
# just want to apply the same function (or calculations) to all of the elements of a vector. We
# can use `for` to do this, but _R_ provides a function which does exactly that - `sapply`. 


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ `sapply` applies a specified function to every element of a vector and returns a vector formed
# ^ from the results.
# ^ 
# ^ sapply(X, FUN)
# ^ 
# ^ applies the function `FUN` to every element of the vector `X` it then returns a vector containing
# ^ the values of `FUN(X[1])`, `FUN(X[2])`, and so on. 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# So, to replicate the square-root example above using `sapply`, we would write

sapply(1:10, FUN=sqrt)

# or alternatively

sapply(1:10, FUN=function(i){sqrt(i)})

# which applies the square root function to each of the integers 1 to 10. Unlike a loop, `sapply`
# automatically returns its results as a vector without us having to write code for that (our 
# `for` loop above only printed the values). 

# There are other variations of `apply` which work with matrices and other data structures, and we 
# will see those later.

# If we combine this technique of looping with the ability to write our own functions, then we have
# a very flexible way of re-writing a standard loop in a vectorised way. In general, using the 
# `sapply` function is to be preferred to a `for` loop particularly when we want to keep the results
# of the calculations from each iteration. However, `for` loops are still useful and more natural in
# certain cases (where we do not want the output values, or where each iteration has a dependency on
# the calculations at the previous step).



#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Use `sapply` to re-write your for-loops. You should write your answers in one line of code for
#   each part:
#    * Return the values of the integers 1 to 5.
#    * Return the squares of the integers from 10 to 3.
#    * Return a vector of your first name 10 times.















#
#
# 3. The Sampling Experiment
# ==================================================================================
#

#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Make a vector of the means of 30 different samples of size 4 from the hospital discharges
#   vector using a combination of `sapply` and the functions `sample` and `mean`.
# * Create a new function with argument `n` that returns a vector of the means of 1000 samples,
#   each of size `n`, from the discharges data. 
#   _Hint:_ This is a one line function that places a version of the command used in the previous
#   question within the function.
# * Using your new function, create three vectors containing the means for 1000 samples of sizes
#   n_1=4, n_2=16 and n_3=64 from the discharges data (giving each a name).














# We now have samples of size 1000 from each of three sampling distributions of Xbar, for
# when n=4, n=16, n=64. As our samples of Xbar values are quite large in size, we might
# expect that each of these distributions is quite similar to the distribution of the underlying 
# theoretical population of sample means.

#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Find the mean and standard deviation for each collection of sample means. Do the results
#   agree with what you would expect?
# * Draw a `boxplot` comparing each of the three samples on the same scale. (_Hint_: see the 
#   previous practical for how to draw a boxplot.)


















# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ _R_ makes it easy to combine multiple plots into one overall graph, using either the `par` or
# ^ `layout` functions.
# ^ 
# ^ With the `par` function, we specify the argument `mfrow=c(nr, nc)` to split the plot window 
# ^ into a grid of nr x nc plots that are filled in by row. For example, to divide the plot window 
# ^ into a 2x2 grid we call
# ^ 
# ^ par(mfrow=c(2,2))
# ^ 
# ^ This has no immediate effect, but the next four plots drawn (using `plot`, `hist`, `boxplot`, etc)
# ^ will be drawn in the 2x2 grid.
# ^ 
# ^ To revert to a single plot layout, we ask for a 1x1 grid via `par(mfrow=c(1,1))`.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Use the `par` function with the `mfrow` argument to configure to plot window for a column of
#   three vertical plots.
#   _Note:_ this function will have no effect until you start drawing new plots.
# * Plot the samples of $\bar{X}$ as separate histograms, one on top of the other. Make sure the
#   horizontal axes are the same. 
#   _Hint:_ use the `xlim` argument to specify the horizontal axis limits, and `range` will determine
#   the min and max of a vector.




















# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ It is often useful to add simple straight lines to lines to plots, which can be achieved
# ^ using the `abline` function. `abline` can be used in three different ways:
# ^   
# ^ + Draw a horizontal line: pass a value to the `h` argument, `abline(h=3)` draws a horizontal
# ^   line at y=3
# ^ 
# ^ + Draw a vertical line: pass a value to the `v` argument, `abline(v=5)` draws a vertical 
# ^   line at x=5
# ^ 
# ^ + Draw a line with given intercept and slope: pass value to the `a` and `b` arguments
# ^   representing the intercept and slope respectively; `abline(a=1,b=2)` draws the line y=1+2x
# ^   
# ^ `abline` can be customised using any of the usual colour and line modifications using colour
# ^ (`col`), and line types and widths (`lty`, and `lwd`) - refer to the Advanced Plots help page
# ^ http://www.maths.dur.ac.uk/stats/people/jac/sc2-practicals/r_8_advplots.htm
# ^   
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Redraw your histograms, this time adding a vertical line showing the population mean.















# According to theory seen in lectures, the sample mean is an unbiased estimator of the 
# population mean, mu, and has variance denoted sigma_Xbar. For Normal data or large 
# sample sizes, the sampling distribution is either exactly or approximately Normal with the above
# mean and variance.


#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * What do you observe about the three distributions? Does the picture correspond to the theory?
# * What do you notice about the mean and standard deviation of your samples relative to the 
#   population for the three different sample sizes.














#
#
# 3. The variance of the sample mean
# ==================================================================================
#

# We can use `R` to investigate the properties of the distribution of the sample mean more
# closely. The theory tells us that the variance of the sample mean, Xbar, for a sample
# of size n from a _finite_ population of size N is given by:
# 
#                                  (N − n)   sigma^2
#       Var[Xbar] = sigma^2_Xbar = -------   -------  .
#                                  (N - 1)      n
#
#  where sigma^2 is the population variance of the original data, X. An unbiased estimator 
# of this standard error is the estimated standard error, given by
#
#                  (     n )  s^2
#       S^2_Xbar = ( 1 - - )  ---   .
#                  (     N )   n
#
# where $s^2$ is the sample variance.

#
# Exercise:
# ~~~~~~~~~~~~~
# 
# * Calculate the true variance of the sample mean, sigma^2_Xbar for the samples of 
#   size 4, 16 and 64.
# * Write a new function with argument `n` that returns a vector of 1000 realisations 
#   of S^2_Xbar for samples of `n` from the discharges data. 
# * Evaluate your function for n=4, n=16, and n=64 and store the result to three variables.
# * Display each of these three samples as histograms, one on top of the other in the same
#   plot. Make sure the horizontal axes are the same.
# * Draw a vertical line on each one showing the location of the true variance of the 
#   sample mean in each case.
# * Is the result of this experiment consistent with the theory? Why?






























