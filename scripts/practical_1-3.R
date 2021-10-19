#
# PRACTICAL 1-3: Inference for the Sample Mean
# ---------------------------------
#
#
# In this practical, we will investigate the behaviour and distributions of summary statistics
# calculated from samples of normally-distributed data. To do this, we will use R to simulate large
# numbers of Normal random samples, and from each of which we will compute the sample mean and
# variance. By repeating this experiment for a large number of such samples, we will accumulate a
# large number of sample means and variances which we will investigate and compare to the results
# we would expect to find from the theory in lectures.
  
# You will need the following skills from previous practicals:
#   *   Basic R skills with arithmetic, functions, etc
#   *   Manipulating and creating vectors: `c`, `seq`, 
#   *   Calculating data summaries: `mean`, `sd`, `var`, `min`, `max`
#   *   Plotting a scatterplot with `plot`, and a histogram with `hist`
# New R techniques:
#   *   Random number generation with `rnorm`, `runif`, etc
#   *   Evaluation of standard density functions via `dnorm`, `dunif`, etc
#   *   Creating a matrix with `matrix`
#   *   Applying a function to every row/column of a matrix with `apply`
#   *   Drawing a curve on an existing plot using `lines`

#
#
# 1. Normal Sampling Theory
# ==================================================================================
#
# -----------------------------------------------------------------------------------------
# 1.1 The Theory
# -----------------------------------------------------------------------------------------
# First, let's recap (or introduce) a little theory. If you haven't seen this yet in lectures, you
# will soon (Lecture 4). Consider a sample of n Normally-distributed data points: X_1, ... ,X_n 
# i.i.d random variables from N(μ, σ^2/n). We can say:
#
# * The sample mean Xbar has distribution:
#
#          n
#  Xbar =  ∑ X_i ∼ N(μ,σ^2/n).
#         i=1
#
# * The sample variance S^2 is independent of Xbar, and is such that
#
#  (n−1) 
#  ----- S^2 ∼ χ^2_{n−1}.
#   σ^2
#
# * If we standardise Xbar using the sample sd, S, instead of the population sd, σ, we don't get a
# Normal distribution -  we get the following t distribution instead: 
#
#     (Xbar − μ)  
# T = ----------  ∼ t_{n−1}
#        S/√n


# ========================================================================================
#
# 2. Generating the samples
#
#
# In order to illustrate this theory, we require a large number of samples from normal distributions that will act as our data in the following calculations. To generate the random numbers from a normal distribution, we will use the `rnorm` function.
#
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ We can use the `rnorm` function to generate random numbers from a normal distribution. To 
# ^ generate `n` random normal variates from a Normal distribution with mean `m` and standard 
# ^ deviation `s`, we use the command:
# ^  
# ^  rnorm(n, mean=m, sd=s)
# ^
# ^ The `mean` and `sd` arguments are optional, and default to 0 and 1 respectively if missing.
# ^
# ^ For more details, see the section on random number generation in "R Help 5: Basic Stats".
# ^
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                                 
#
# Exercise 2.1:
# ~~~~~~~~~~~~~
#  * Use the `rnorm` function to try generating:
#
#    a. 5 random standard Normal numbers
#
#    b. 20 random numbers from N(5, 5^2)
#
#  * Check the mean and standard deviation of your sample using the `mean` and `sd` functions - are the values what you expected?
















# Exercise 2.2:
# ~~~~~~~~~~~~~
#
#  * Now we're ready to construct our data set. Using `rnorm`, generate a vector of 500 random
#    standard normal values, and save it to a variable `zs`. Check the mean and standard 
#    deviation are consistent with the population distribution.














# Exercise 2.3:
# ~~~~~~~~~~~~~
#
# Let’s change the mean and variance of our sample to make things (fractionally) more interesting.
# Lets suppose we want our data to come from a normal population with mean 17 and standard 
# deviation 5.
#
#  * Recall that if Z ~ N(0,1), then (a+bZ) ~ N(a,b^2) - use this result to apply the appropriate
#    transformation to `zs` to correspond with the new population mean and variance, and save the
#    result to a new variable `xs`.
#
#  * Check the mean and standard deviation of xs to ensure your transformation worked as intended.
#
#  * Hint: you can apply standard arithmetic to vectors in R.













# Next, we want to treat our 500 X values as if they were 100 different random samples, each of
# size 5. To do this, we will transform our vector of length 500 into a `matrix` with 100 rows 
# and 5 columns. This way, each of the rows in the matrix corresponds to a different random 
# sample of size 5.

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ A matrix is created using the `matrix` function, which takes three arguments: the values of 
# ^ the matrix (`data`), the number of rows (`nrow`), and the number of columns (`ncol`).
# ^ 
# ^ To produce a 3 x 3 matrix containing the integers 1 to 9, we would write:
# ^ 
# ^   matrix(1:9, nrow = 3, ncol=3)
# ^ 
# ^ For more details, see "R Help 6: Matrices".
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Exercise 2.4:
# ~~~~~~~~~~~~~
#
#
# * Use the `matrix` function to create a  100 x 5 matrix from the values in `xs`. 
# * Save the result as `xMatrix`.














# ========================================================================================
#
# 3. Investigating Xbar
#
#
# To investigate the behaviour of Xbar, we need some data. From the previous step, we have 
# effectively generated 100 Normal samples each of size 5, each represented by a row in 
# `xMatrix`. What we want to do now to calculate the sample mean for each of these samples 
# (i.e every row). This will give us a collection of 100 observed sample mean values, xbar, 
# drawn from the distribution of Xbar which we can investigate more closely.

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ We can use the `apply` function to evaluate the same function for either every row or every
# ^ column of a given matrix (or data frame). This is particularly useful for computing summary
# ^ statistics (means, standard deviations, etc) for all variables in a data set.
# ^ 
# ^ The `apply` function takes three arguments: 
# ^  *  `X` - the matrix or data frame to use for calculations
# ^  *  `MARGIN` - which indicates whether to evaluate over the rows (`MARGIN=1`) or 
# ^                columns (`MARGIN=2`) of the matrix
# ^  *  `FUN` - the name of the function we wish to evaluate.
# ^ 
# ^ For example, to calculate the minimum value in each column of a matrix `A`, we could write
# ^ 
# ^   apply(A, MARGIN=2, FUN=min)
# ^ 
# ^ For more details, read the entry in "R Help 9: Programming" on `apply`.
# ^                                          
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#
# Exercise 3.1:
# ~~~~~~~~~~~~~
#
#  * Use the `apply` function to compute the sample `mean` for every row of `xMatrix`. 
#    Save the results as `xbar`.
#
#  * Calculate the mean and variance of `xbar` - do they agree with the values that we would 
#    expect from the theoretical distribution of Xbar given in section 1.1 above?













# Now we'll use the `hist` function to plot a histogram of the `xbar` values from our sample, 
# and we'll overlay the Normal density curve we'd expect from the theory on top of the 
# histogram using `lines`.

#
# Exercise 3.2:
# ~~~~~~~~~~~~~
#  * If you're unfamiliar with plotting histograms with `hist`, quickly read up  on the `hist`
#    function in "R Help 7: Plots".
#
#  * Use `hist` to draw a histogram of `xbar` setting `breaks=15` to ensure we show enough detail
#    in the bars in the plot, and set `freq=FALSE` to plot the vertical axis as frequency density
#    instead of frequency.














# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ 
# ^ TECHNIQUE: 
# ^ 
# ^ R provides a range of functions to support calculations with standard probability distributions.
# ^ To save creating our own functions to evaluate the pdfs and cdfs, we can use these standard 
# ^ functions instead. 
# ^ 
# ^ For every distribution there are four functions. The functions for each distribution begin
# ^ with a particular letter to indicate the functionality (see table below) followed by the name
# ^ of the distribution:
# ^ 
# ^ | Letter | e.g.    | Function                                                          |
# ^ |--------|---------|-------------------------------------------------------------------|
# ^ | "d"    | `dnorm` | evaluates the probability density (or mass) function, f(x)        |
# ^ | "p"    | `pnorm` | evaluates the cumulative density function, F(x)=P[X <= x], hence  |
# ^ |        |         | finds the probability the specified random variable is less than  |
# ^ |        |         | the given argument.                                               |
# ^ | "q"    | `qnorm` | evaluates the inverse cumulative density function (quantiles),    |
# ^ |        |         | F^{-1}(q) i.e. given a probability q it returns the value x such  |
# ^ |        |         | that P[X <= x] = q. Used to obtain critical values associated     |
# ^ |        |         | with particular probabilities q.                                  |
# ^ | "r"    | `rnorm` | generates random numbers                                          |
# ^   
# ^   We've already seen one example with `rnorm` to generate random Normal values. The appropriate
# ^ functions for Normal, t and chi^2 distributions are given below, along with the optional
# ^ l parameter arguments.
# ^ 
# ^     + Normal distribution: `dnorm`, `pnorm`, `qnorm`, `rnorm`.
# ^                            Parameters: `mean` (mu) and `sd` (sigma).
# ^     + t distribution: `dt`, `pt`, `qt`, `rt`. 
# ^                       Parameter: `df`.
# ^     + chi^2 distribution: `dchisq`, `pchisq`, `qchisq`, `rchisq`. 
# ^                       Parameter: `df`.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#
# Exercise 3.3:
# ~~~~~~~~~~~~~
#
# To produce the Normal density curve, we need to evaluate the pdf of N(μ, σ^2/n) over the 
# plotting range of the histogram:
#
# * First, construct a sequence of values (using `seq`) which starts at the minimum of `xbar` 
#   and goes up to the maximum value of `xbar` and has length `100`. 
#   Save this vector as `seqx`.
#   Hint: You'll need the `seq`, `min`, and `max` functions - see "R Help 4 Vectors" for help
#         if needed.
# * We can use `dnorm` to evaluate the normal density function at the values `seqx` and save
#   these values as `ndens`. Try this now.
#   Make sure you supply the correct value of μ to the `mean` argument, and σ/√n to the `sd`
#   argument, otherwise your pdf won't match the histogram. 



# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ We can use R's line drawing function `lines` to add an (approximate) curve to a plot. 
# ^ To draw a function f(x) on an existing plot, we evaluate the function f at a sequence of x 
# ^ points and then use `lines` to draw connected line segments between each (x,f(x)) pair to 
# ^ form the curve.
# ^ 
# ^ For example, if we save the x values in a vector `xs` and the f(x) values in a vector `fs`
# ^ then the command to add the curve to the plot is:
# ^ 
# ^   lines(x=xs, y=fs)
# ^ 
# ^ Like other plotting functions, `lines` can be modified by adding argumets to specify 
# ^ different line types, widths, and colours. See the "R Help 8: Advanced plots" page for 
# ^ detail on how to customise your curve.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



#
# Exercise 3.4:
# ~~~~~~~~~~~~~
#  * Use the `lines` function to add a solid blue curve between the points `x=seqx` and 
#    `y=ndens` to your histogram. 
#
#  * _Note:_ if your density curve goes off the top of your plot, then try redrawing the 
#    histogram but set the limits of the vertical axis by passing the `ylim=c(a,b)` argument 
#    to the `hist` function where `a` and `b` are your desired upper and lower limits of the
#    y axis. Use a lower limit of `0` and choose the upper limit to be large enough to see the
#    entire curve.
#
#  * How does the distribution of our sample of xbar values compare (in terms of shape, location,
#    and spread) with the theoretical distribution of Xbar? Does it agree with the theory?
#
















# ========================================================================================
#
# 4. Investigating S^2 and T
#
#
# Now lets look move on to investigate the sample variances and standardised values. If our data
# are normal, then a multiple of the sample variance (n−1) S^2 / σ^2 should follow a χ2 
# distribution with n−1 degrees of freedom. Let’s compute the sample variances for our 100 
# samples and investigate this using the techniques above.
#
#
#
# Exercise 4.1:
# ~~~~~~~~~~~~~~
#
# * Apply the `var` function to each of the samples in `xMatrix` to create a vector of 100
#   sample variances, s^2. 
#   Call these `svar`.
# * The theory says that the random quantity (n−1)S^2/σ^2 has a χ2_(n-1) distribution. Re-scale
#   the sample variances by multiplying `svar` by (n−1)/σ^2, and call this `svarScl` (for 'scaled
#   sample variance').
# * Calculate the mean and variance of `svarScl` - do they agree with the mean and variance
#   of the appropriate χ2_(n-1) distribution? 













#
# Exercise 4.2:
# ~~~~~~~~~~~~~~
#
# * Go back to your code from Exercises 3.2-3.4 to plot the histogram of $\bar{x}$ with a 
#   normal density curve on top. 
#   Adjust the code to instead plot a histogram of s^2 and overlay the density function for
#   a χ2_n−1 distribution using the `dchisq` function.
# * Do the samples appear consistent with the theoretical distribution?













#
# Exercise 4.3:
# ~~~~~~~~~~~~~~
#
# * According to the theory, Xbar and S^2 should be independent. Use `plot` to produce a 
#   scatterplot of xbar against s^2.
#   Do they appear to be independent? What features of the plot support this conclusion?













# The final theoretical result concerns the distribution of the sample means when standardised 
# by the sample variance, 
#
# T = (Xbar−μ)/(s/√n).
#
# We know that if we use the population variance, σ^2, in this calculation instead of s^2, then
# the standardised values are N(0,1). However, as this expression uses the sample variance the
# distribution is no longer normal, and is t-distributed instead to account for the extra 
# uncetainty we have introduced by using an estimate of σ^2.


#
# Exercise 4.4:
# ~~~~~~~~~~~~~~
# 
# * Using your values of `xbar` and `svar`, create a new vector `tvals` with elements equal to
#   (xbar−μ)/(s/√n) for each sample of size 5.
# * Using the techniques above, investigate the behaviour and distribution of `tvals` (inspect
#   the mean and variance, construct a histogram, overlay the appropriate density curve).











# ========================================================================================
#
# 5. Probability Integral Transform
#
# All of the calculations we performed in the preceding section required us to be able to
# generate random numbers from a particular distribuion, in this case the Normal. We will 
# see (or have seen) in Lecture 2 that we can generate random numbers from (almost) any 
# distribution by simply applying an appropriate transformation to simple standard uniform 
# random numbers.
#
# The theory we require is known as the probability integral transform, and goes as follows. 
# Let X be a continuous random quantity with cdf F_X(x), and let U be a standard uniform 
# random quantity, U ∼ U[0,1]. Then 
#
#  1. the random quantity Y=F_X(X) has a standard uniform distribution U[0,1];
#
#  2. the random quantity W=F^{−1}_X(U) has cdf equal to F_X, and thus W has the same 
#     distribution as X.
#
# It is the second part of this theorem that is of relevance to generating random numbers from
# specific distributions. So long as we can find F^{−1}_X for the distribution we want, we can
# generate uniform random numbers, u, and apply the transformation F^{−1}_X(u) to produce random
# numbers from another distribution which have the distribution of X. This process is known as
# inverse sampling:
#  
# For example, let’s consider the exponential distribution with ‘rate’ λ>0 which has c.d.f.
#
#  F(y) = 1 − exp(−λy)
#
# for y ≥ 0 and 0 elsewhere. 
#
# If we set U=F(y), then we can find the inverse CDF as (check this result!)
#
#  Y = −log(1−U)/λ.
#
# Then by the theorem above, if U ~ U[0,1] the random quantity Y must have an exponential 
# distribution  with rate λ.
#
# Let’s investigate this further by verifing the result numerically:

#
# Exercise 5.1:
# ~~~~~~~~~~~~~
# 
# * Generate a sample of 1000 random numbers from the uniform distribution on [0,1] as the
#   vector `us`. You'll need the `runif` function.
#
# * Use the result above to transform the uniform sample into an exponential distribution with
#   rate λ (pick your own value of λ>0). Call these `ys`.
#
# * Plot a histogram of `ys`` and overlay the density function for the exponential distribution
#   using your value of λ - you’ll need to use the `dexp`` function to evaluate the exponential
#   density.
#













#
# Exercise 5.2:
# ~~~~~~~~~~~~~
# 
# * R has defined the inverse CDF functions for most standard distributions, these are the 
#   ‘quantile’ functions that  begin with `q` for each standarad distribution, e.g. `qnorm`,
#    `qchisq`, etc. 
#
# * Generate a random sample of size 1000 from a Normal distribution with zero mean and unit
#   variance using only the two functions `runif` and `qnorm`. Check the distribution of your 
#   random numbers in the same way as above.















# =========================================================================================
#
# 6. Further exercises
#
# If you finish the exercises above, have a look at the online worksheet for additional problems
# on these topics.
#
#
