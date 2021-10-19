#
# PRACTICAL 1-5:  Likelihood
# ---------------------------------
# 
# We have seen in lectures that the MLEs for the parameters of several common distributions
# can be found in closed form. However, in general, the problem is not guaranteed to be so
# easy with a simple closed-form result. Therefore, in these situations, we will have to find
# and maximise the likelihood numerically.
# 
# For this practical, we will focus on the Poisson distribution, which is particularly appropriate
# for counts of events occuring randomly in time or space. Suppose we have a simple problem with 
# one piece of data, $X$, and we know that $X\sim\text{Po}(lambda)$ for some unknown parameter 
# value lambda. 
# 
# You will need the following skills from previous practicals:
#     *   Basic R skills with arithmetic, functions, etc
#     *   Manipulating and creating vectors: `c`, `seq`,
#     *   Calculating data summaries: `mean`, `sum`, `length`
#     *   Plotting with `plot` and `hist`, and adding lines to plots with `lines` and `abline`
#     *   Repeatedly applying a function to a vector using `sapply`
# New R techniques:
#     *   Optimising a function with `optim`
#     *   Extracting named elements of a list using the `$` operator


# 1. The Poisson Likelihood
# ==================================================================================
# 

# 
# Our likelihood calculations begin with writing down the likelihood function of our data.
# For a single observation X=x from a Poisson distribution, the likelihood is the the probability
# of observing X=x written as a function of the parameter lambda:
# 
#                                 e^{-lambda} lambda^x
# l(lambda) = P[X=x | lambda] =   --------------------
#                                          x!
# 
# To begin with, suppose we observe a count of X=5.



# Exercise:
# ~~~~~~~~~~~~~
# * Write a simple function called `poisson` that takes arguments `lambda` which evaluates the
#   Poisson probability P[X=5 | lambda].
#   _Hint_: You will need the `exp` and `factorial` functions.
# * Evaluate the Poisson probability for X=5 when lambda=7 - you should get a value of `0.1277167`.

   
















 
# What we have just created is the likelihood function, l(lambda), for the Poisson parameter 
# lambda given a single observation of X=5. 
# 
# Before we consider a larger data problem, let's briefly explore this simplest case of a Poisson
# likelihood.

# Exercise:
# ~~~~~~~~~~~~~
# * Create a `seq`uence of `length` 200 from `0.1` to `20`. Save this as `lambdavals`. 
# * Use `sapply` to evaluate the Poisson likelihood function for every value of lambda in
#   `lambdavals`. Save this as `like5`.
# * Draw a `plot` of the Poisson likelihood as a function of lambda. Use `ty='l'` to draw a
#   line graph.
# * By eye, what is the value lambdaHat of lambda which maximises the likelihood?
 



















# Typically, we usually work with the log-likelihood L(lambda)=log l(lambda), rather than 
# the likelihood itself. This can often make the mathematical maximisation simpler, the numerical
# computations more stable, and it is also intrinsically connected to the idea of *information*
# (which we will consider later).

# Exercise:
# ~~~~~~~~~~~~~
# * Modify your `poisson` function to compute the logarithm of the Poisson probability, and
#   call this `logPoisson`. You will need to use the `log` function.
# * Evaluate the log likelihood function for all lambda in `lambdavals` and plot the log-likelihood
#   against lambda. Do you find the same maximum value lambdaHat?


















# 
# 2. Likelihood methods for real data
# ==================================================================================
# 
# The Poisson distribution has been used by traffic engineers as a model for light traffic.
# This assumption is based on the rationale that if the rate is approximately constant and
# the traffic is light (so the individual cars move independently of each other), then the
# distribution of counts of cars in a given time interval or space area should be nearly 
# Poisson (Gerlough and Schuhl 1955). 
# 
# The following table shows the number of right turns during 300 3-minute intervals at a 
# specific junction.
# 
# N            0    1    2    3    4    5    6    7    8     9    10    11    12
# Frequency   14   30   36   68   43   43   30   14   10     6     4     1     1


traffic <- rep(0:12, c(14,30,36,68,43,43,30,14,10,6,4,1,1))




# Exercise:
# ~~~~~~~~~~~~~
# * Evaluate the piece of code above to create the vector `traffic` corresponding to the above data set.
# * Plot a `hist`ogram of the data. Does an assumption of a Poisson distribution appear reasonable?

















# If we suppose a Poisson distribution might be a good choice of distribution for this
# dataset, we still need to find out which particular Poisson distribution is best by 
# estimating the parameter lambda. 
# 
# Let's begin by constructing the likelihood and log-likelihood functions for this data set 
# of 300 observations. Assuming that the observations $x_1, \dots, x_{300}$ can be treated as
# 300 i.i.d. values from $\text{Po}(lambda)$, the log-likelihood function for the entire sample is:
# 
# 
# L(lambda) = -n lambda + (sum_{i=1}^n x_i ) log(lambda),
# 
# 
# up to an additive constant from the factorial terms (which we can ignore).


# Exercise:
# ~~~~~~~~~~~~~
# 
#  * Write a new functions `logLike` with a single parameter `lambda`, which evaluates the 
#    log-likelihood expression above for the `traffic` data and the supplied values of `lambda`.
#   _Hint_: Use `length` and `sum` to compute the summary statistics.
#  * Evaluate the data log-likelihood for all lambda in `lambdavals` and plot the log-likelihood
#    against lambda. Without further calculations, use the plot to have a guess at the maximum 
#    likelihood estimate $lambdaHat$ -- we'll check this later!



















# 2.1 Maximising the likelihood
# ----------------------------------------------------------------------------------
# 
# The maximum likelihood estimate (MLE), lambdaHat, for the lambda parameter of the Poisson
# distribution is the value of lambda which maximises the likelihood
# 
# lambdaHat = argmax_{lambda in Omega} l(lambda) = argmax_{lambda in Omega} L(lambda).
# 
# Therefore to find the MLE, we must maximise l or L. We know we can do this analytically for
# certain common distributions, but in general we'll have to optimise the function numerically
# instead. For such problems, `R` provides various functions to perform a numerical optimisation
# of a give function (even one we define ourself). The function we will focus on is `optim`:


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ `R` offers several optimisation functions, however the one we shall be using today is 
# ^ `optim` which is one of the most general optimisation functions. This generality comes at
# ^ the price of having a lot of optional parameters that need to be specified.
# ^ 
# ^ For our purposes, we're doing a 1-dimensional optimisation of a given function named `logLike`.
# ^ So the syntax we will use to maximise this function is as follows
# ^ 
# ^ `optim(start, logLike, lower=lwr, upper=upr, method='Brent', control=list(fnscale=-1))`
# ^ 
# ^ The arguments are:
# ^ 
# ^ * `start` : an initial value for lambda at which to start the optimisation. 
# ^       *Replace this with a sensible value.*
# ^ * `logLike` : this is the function we're optimising. In general, we can replace this with
# ^       any other function.
# ^ * `lower=lwr, upper=upr` : lower and upper bounds to our search for $\est{lambda}$. 
# ^       *Replace `lwr` and `upr` should be replaced with appropriate numerical values*; an obvious
# ^       choice for this problem is the min and max of our data.
# ^ * `method='Brent'` : this selects an appropriate optimisation algorithm for a 1-D optimisation.
# ^ * `control=list(fnscale=-1)` : this looks rather strange, but is simply telling `optim` to 
# ^       *max*imise the given function, rather than *min*imise (which is the default).
# ^ 
# ^ `optim` returns a number of values in the form of a list. The relevant components are:
# ^  
# ^    * `par` : the optimal value of the parameter
# ^    * `value` : the optimum of the function being optimised.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


# Exercise:
# ~~~~~~~~~~~~~
# * Use `optim` to maximise the `logLike` function. You should choose an appropriate initial
#   value for lambda, as well as sensible `upper` and `lower` bounds.
# * What value of lambdaHat do you obtain? How does this compare to your guess at the MLE?
# * We know from lectures that the lambdaHat=Xbar -- evaluate the sample mean of the `traffic`
#   data. Does this agree with your results from directly maximising the log-likelihood?


















# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ The output of `optim` is in the form of a `list`. Unlike vectors, `list`s can combine many 
# ^ different variables together (numbers, strings, matrices, etc) and each element of a list
# ^ can be given a name to make it easier to access.
# ^ 
# ^ For example, we can create our own lists using the `list` function:
# ^ 
# ^ ` test <- list(Name='Donald', IQ=-10, Vegetable='Potato')`
# ^ 
# ^ Once created, we can access the named elements of the list using the `$` operator. For example,
# ^ 
# ^ ` test$IQ`
# ^ 
# ^ will return the value saved to `IQ` in the list, i.e. -10. RStudio will show auto-complete
# ^ suggestions for the elements of the list after you press `$`, which can help make life easier.
# ^ 
# ^ We can use this to extract the MLE value from `optim` by first saving the results to a variable,
# ^ called `results` say, and then extracting the list element named `par`.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



# Exercise:
# ~~~~~~~~~~~~~
# * Extract the optimal value of lambda from the output of `optim` and save it to a new variable 
#   called `mle`.
# * Re-draw your plot of the log-likelihood function, and use `abline` to:
#    * Add a red solid vertical line at lambda=lambdaHat
#    * Add a blue dashed vertical line at lambda=xbar.
# * Do the results agree with each other, and with your guess at lambdaHat?



















# Let's return to the original distribution of the data. The results of our log-likelihood analysis
# suggest that a Poisson distribution with parameter $lambdaHat$ is the best choice of Poisson 
# distributions for this data set.


# Exercise:
# ~~~~~~~~~~~~~
# * Re-draw the `hist`ogram of the `traffic` data.
# * For x=0, 1, ..., 16 evaluate the Poisson probability P[X=x] when X ~ Po(lambdaHat).
#   Save these probabilities as `probs`.
# * Multiply `probs` by the sample size to obtain the expected Poisson counts under this 
#   Po(lambdaHat) distribution.
# * Use the `lines` function to overlay the expected Po(lambdaHat) counts as a curve on top 
#   of your histogram. Does this look like a good fit to the data?


















# We will return to the question of fitting distributions to data and the "goodness of fit" later
# next term.


# 2.2 Information and inference
# ----------------------------------------------------------------------------------
#
# For an iid sample X1, ..., Xn from a sufficiently nicely-behaved density function f(xi | theta)
# with unknown parameter theta, the sampling distribution of the MLE thetaHat is such that 
# 
# thetaHat ~~> N(theta, 1/I_n(theta) ),
# 
# as n -> infinity. Whilst we may be used to finding Normal distributions in unusual places, this
# result is noteworthy as we never assumed any any particular distribution of our data here. This 
# result therefore provides us with a general method for making inferences about parameters of 
# distributions and their MLEs for problems involving large samples!
# 
# In particular, we can apply this to our Poisson data problem above to construct a large-sample 
# approximate 100(1-alpha)% confidence interval for lambda in the form:
# 
# lambdaHat +/- z*_{alpha/2} 1 /[sqrt(-L''(lambdaHat))],
# 
# where z*_{alpha/2} is the alpha/2 critical value of a standard Normal distribution and we have 
# estimated the expected Fisher information I_n(theta) by the observed information 
# I(lambdaHat) = -L''(lambdaHat).
# 

# Exercise:
# ~~~~~~~~~~~~~
#
# * We can request that `R` computes -1 times the the second derivative at the maximum, 
#     -L''(lambdaHat), as part of the optimisation process. To do this, re-run your optimisation,
#     but add the additional argument `hessian=TRUE`.
# * The output from `optim` will now contain an additional element named `hessian`. Extract this
#   element, and save it as `obsInfo`.
# * Irritatingly, `obsInfo` will be in the form of a (1x1) matrix rather than a scalar. Run the 
#   following code to flatten it into a scalar so we can use it in our confidence interval:
#
#   obsInfo <- c(obsInfo)




















# Exercise:
# ~~~~~~~~~~~~~
#
# * Use `qnorm` or your standard Normal tables to find the critical z*_{alpha/2} value for
#   a 95% confidence interval. Save this as `zcrit`.
# * Combine `mle`, `zcrit`, and `obsInfo` to evaluate an approximate 95% confidence interval
#   for lambda.
# * Return (and possibly re-draw) the plot of your log-likelihood function, with the MLE 
#   indicated as a vertical line. Add the limits of the confidence interval to your plot as
#   vertical green lines.
#  * Comment on the reliability of your estimate.


















