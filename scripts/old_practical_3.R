#
# PRACTICAL 9: Linear Regression
# ---------------------------------
#
#
# In this practical, we will use R to fit linear regression models by the method of ordinary least
# squares (OLS). We will make use of R's `lm` function simplify the process of model fitting and
# parameter estimation, and use information from its output to construct confidence intervals.
# Finally, we will assess the quality of the regression and use residual diagnostic plots to 
# assess the validity of the regression assumptions.  

# You will need the following skills from previous practicals:
#     * Basic R skills with arithmetic, functions, and vectors
#     * Calculating data summaries: mean, sd, var, sum
#     * Loading libraries and data sets with library and data
#     * Drawing scatterplots with plot and straight lines with abline
#     * Using additional graphical parameters to customise plots with colour (col), line 
#       type (lty), etc
#
# New R techniques:
#    *   Fitting a linear regression model with `lm`
#    *   Extracting key regression quantities such as coefficients (`coef`), residuals (`resid`),
#        and fitted values (`fitted`)
#    *   Obtaining a detailed summary of a linear regression fit with `summary`
#

# ==================================================================================
#
# 1. Simple linear regression
#
# 1.1 The simple linear regression model
#
# Regression analysis is a statistical area concerned with the estimation of the relationship
# between two or more variables. In the simple linear regression model we have a _dependent_ 
# or _response_ variable Y, and and _independent_ or _predictor_ variable X. Suppose we 
# have n pairs of observations {y_i,x_i}, i=1,...,n, we can then write the simple linear 
# regression model as
# 
#    y_i = β_0 + β_1 x_i + ε_i,   i=1,...,n
#
# where β_0, β_1 are the unknown regression parameters (i.e. the intercept and slope of the trend
# line), and ε_i are the unobserved random regression error around the trend line.
#
# In linear regression, we make the following assumptions about ε_i:
#
#    A. E[ε_i] = 0 for all i — our errors have mean zero and do not depend on x. In other words,
#       there is no systematic bias, such as would come from missing a key part of the trend in x. 
#       So, the model trend is assumed correct, and any errors are assumed to be scattered randomly
#       about it.
#    B. Var[ε_i] = σ^2 for all i — our errors have a constant spread or variance, which also does 
#       not depend on x; the errors are homoscedastic.
#    C. The regression errors are independent, so Cov[ε_i, ε_j]=0, and E[ε_i ε_j]=0 when i!=j
#    D. To make probability statements, we will further assume that the regression errors are all
#       i.i.d N(0,σ^2)
#

# We fit the regression model by _least squares_, which seeks the values of β_0 and β_1 which minimise the sum of the squared errors between our observed y and the regression line β_0+β_1x, i.e.
# 
#   Q(β_0, β_1) = \sum_{i=1}^n (y_i - β_0 - β_1 x_i)^2.
# 
# The minimising values are the OLS estimates βhat_0 and βhat_1, which can be written as follows (see lecture notes)
# 
#  βhat_0 = ybar - β_1 xbar,
#
#  βhat_1 = S_xy/S_xx
#

# ==================================================================================
#
# 2. The faithful data set
#
# The dataset we will be using in this practical concerns the behaviour of the Old Faithful geyser
# in Yellowstone National Park, Wyoming, USA. For a natural phenomenon, the Old Faithful geyser is
# highly predictable and has erupted every 44 to 125 minutes since 2000. There are two variables
# in the data set:
#
#   1. the waiting time between eruptions of the geyser, and
#   2. the duration of the eruptions.
#
# Before we start fitting any models, the first step should always be to perform some exploratory
# data analysis of the data to gain some insight into the behaviour of the variables and suggest
# any interesting relationships or hypotheses to explore further.
#


# Exercise 1.1:
# ~~~~~~~~~~~~~
#
# * Load the faithful dataset by typing data(faithful)
#
# * To save typing later, let’s extract the columns into two variables. Create a vector `w` that
#   contains the vector of waiting times, and a second vector `d` that contains the durations of
#   eruptions.
#
# * Plot the waiting times (y-axis) against the durations (x-axis).
#
# * Is there evidence of a linear relationship?
#













# The model we're interested in fitting to these data is a simple linear relationship between the waiting times and the eruption durations, namely
#
#  w = β_0 + β_1 d + ε
#


# Exercise 1.2:
# ~~~~~~~~~~~~~
#
# * Read the techniques page on changing axis limits, and then redraw your scatterplot so the
#   horizontal axis covers the interval [0, 5.5], and the vertical axis covers [0, 100].
#
# * Try guessing at some coefficients of the best-fitting straight line model. Use the `abline`
#   function to draw the lines on your plot using the arguments `a` and `b` to specify the 
#   intercept and slope. Save your best guess as `guess.b0` and `guess.b1`.
#
# * Have a couple of attempts, but don’t spend too long! We’ll see better ways to do this next.
#















# As mentioned above, the OLS method minimizes the square of the residuals which are the difference
# between the vector of observations, w_i, and the fitted values, what_i. Now let’s compute this
# least-squares value for your best guess at the coefficients.


#
# Exercise 1.5:
# ~~~~~~~~~~~~~ 
#
# * Using your best guesses as βhat_0 and βhat_1$, create a vector called `guess.what` containing
#   the fitted values what_i= βhat_0 + βhat_1 d_i  for your regression line. 
#
# * Create a vector `guess.resid` containing the residuals e_i = w_i - what_i.
#
# * Calculate the sum of squares of your residuals, Q(`guess.b0`, `guess.b1`). Save the value as
#   `guess.Q` - we'll compare it to the least-squares fit later.
#













# ==================================================================================
#
# 3. Fitting the regression model
# 
#
# ----------------------------------------------------------------------------------
# 3.1 Direct calculation

# We have access to all of the data and we know the formulae for the least squares estimates of 
# the coefficients, so we should be able to calculate the optimal values fairly easily.

#
# Exercise 3.1:
# ~~~~~~~~~~~~~ 
# 
# * First, calculate the regression summary statistics: use `mean` to find wbar (sample mean of
#   w) and dbar (sample mean of d) and save them as `wbar` and `dbar`.
#
# * Use the sample means with the original values of `d` and `w`` to calculate S_dd and S_dw, 
#   and store them as `sdd` and `sdw`. Hint: the `sum` function will be useful.
#
# * Use these summaries with the formulae in Section 1 to calculate the least-squares estimates
#   βhat_0, βhat_1 and save them as `beta0hat` and `beta1hat`.
#
# * How do the least-squares estimates compare to your guesses?
#
# * Use the `abline` function to add the least-squares regression as an additional line to your
#   plot. Use colour  (the `col` argument) to distinguish it from your previous guesses.
# 












# ----------------------------------------------------------------------------------
# 3.2  Linear regression with `lm`
# 
#
# It would be rather tiresome to have to do the calculations explicitly for every regression problem, and so R provides the `lm` function to compute the least-squares linear regression for us, and it returns an object which summarises all aspects of the regression fit.
#

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ 
# ^ TECHNIQUE: 
# ^ 
# ^ In R, We can fit linear models by the method of least squares using the function `lm`. Suppose
# ^ our response variable is $Y$, and we have a predictor variable $X$, with observations stored in
# ^ R vectors `y` and `x` respectively. To fit $y$ as a linear function of $x$, we use the following
# ^ `lm` command:
# ^   
# ^   `model <- lm(y ~ x)`
# ^ 
# ^ Alternatively, if we have a data frame called `dataset` with variables in columns `a` and `b`
# ^ then we could fit the linear regression of `a` on `b` without having to extract the columns 
# ^ into vectors by specifying the `data` argument
# ^ 
# ^ `model <- lm(a ~ b, data=dataset)`
# ^ 
# ^ The `~` (tilde) symbol in this expression should be read as "is modelled as". Note that _R_
# ^ always automatically include a constant term, so we only need to specify the $X$ and $Y$
# ^ variables.
# ^ 
# ^ We can inspect the fitted regression object returned from `lm` to get a simple summary of the
# ^ estimated model parameters. To do this, simply evaluate the variable which contains the 
# ^ information returned from `lm`:
# ^   
# ^   `model`
# ^ 
# ^ For more information, see  [Linear regression](r_10_statsmethods.html#lm).
# ^                                                
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#
# Exercise 3.2:
# ~~~~~~~~~~~~~
#
# * Use `lm` to fit waiting times `w` as a  linear function of eruption durations `d`. 
#
# * Save the result of the regression function to `model`.
#
# * Inspect the value of `model` to find the fitted least-squares coefficients. Check the values 
#   match those you computed in the previous exercise.
#












#
# Exercise 3.3:
# ~~~~~~~~~~~~~
#
# * Use the `coef` function to extract the coefficients of the fitted linear regression model as
#   a vector. 
#
# * Extract the vector of residuals from `model`, and use this to compute the sum of squares of
#   the residuals as `lsq.Q`.
#
# * Compare `lsq.Q` to `guess.Q` - was your best guess close to the minimum of the least-squares error function?
#














# ----------------------------------------------------------------------------------
#  3.3 The regression summary
# 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ 
# ^ TECHNIQUE: 
# ^ 
# ^ We can easily extract and inspect the coefficients and residuals of the linear model, but to
# ^ obtain a more complete statistical summary of the model we use the `summary` function:
# ^   
# ^   `summary(model)`
# ^ 
# ^ There is a lot of information in this output, but the key quantities to focus on are:
# ^   
# ^   * Residuals: simple summary statistics of the residuals from the regression.
# ^   * Coefficients: a table of information about the fitted coefficients. Its columns are:
# ^       + The label of the fitted coefficient: The first will usually be `(Intercept)`, and
# ^         subsequent rows will be named after the other predictor variables in the model.
# ^       + The `Estimate` column gives the least squares estimates of the coefficients. 
# ^       + The `Std. Error` column gives the corresponding standard error for each coefficient. 
# ^       + The `t value` column contains the t test statistics.
# ^       + The `Pr(>|t|)` column is then the p-value associated with each test, where a low 
# ^         p-value indicates that we have evidence to reject the null hypothesis. 
# ^   * Residual standard error: This gives s_e the square root of the unbiased estimate of
# ^     the residual variance.
# ^   * Multiple R-Squared: This is the R^2 value defined in lectures as the squared correlation
# ^     coefficient and is a measure of goodness of fit. 
# ^ 
# ^ We can also use the `summary` to access the individual elements of the regression summary 
# ^ output. If we save the results of a call to the summary function of a `lm` object as `summ`:
# ^   
# ^   * `summ$residuals` -- extracts the regression residuals as `resid` above
# ^   * `summ$coefficients` -- returns the (p x 4) coefficient summary table with columns 
# ^     for the estimated coefficient, its standard error, t-statistic and corresponding (two-sided)
# ^     p-value. 
# ^   * `summ$sigma` -- extracts the regression standard error
# ^   * `summ$r.squared` -- returns the regression R^2
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#
# Exercise 3.4:
# ~~~~~~~~~~~~~
#
# * Apply the `summary` function to `model` to produce the regression summary for our example.
# 
# * Make sure you are able to locate the following:
#   *  The coefficient estimates, and their standard errors,
#   *  The residual standard error, s_e^2;
#   *  The regression R^2.
#
# * Extract the regression standard error from the regression summary, and save it as `se`. (We'll
#   need this later!)
#
# * What do the entries in the `t value` column correspond to? What significance test (and what
#   hypotheses) do these statistics correspond to?
#
# * Are the coefficients significant or not? What does this suggest about the regression?
#
# * What is the R^2 value for the regression and what is its interpretation? Can you extract its
#   numerical value from the output as a new variable?















# ==================================================================================
#
# 4. Inference on the coefficicents
# 
#
# Given a fitted regression model, we can perform various hypothesis tests and construct 
# confidence intervals to perform the usual kinds of statistical inference. To do this, we 
# require the Normality assumption to hold for our inference to be valid.
#
# Theory tells us that the standard errors for the parameter estimates are defined as
#
#  s_{βhat_0} = s_e sqrt{1/n + (xbar^2)/S_xx},
#  s_{βhat_1} = s_e / sqrt{S_xx} 
#
# Given these standard errors and the assumption of normality, we can say for each coefficient 
# βhat_i, i=0,1 that:
#
#  (βhat_i - β_i)
#  --------------  ~  t_{n-2}
#    s_{βhat_i} 
#
# and hence an alpha level confidence interval for β_i can be written as
# 
#   βhat_i +/- t*_{n-2,alpha/2} s_{βhat_i} 
# 

#
# Exercise 4.1:
# ~~~~~~~~~~~~~
#
# * Consider the regression slope. Use the regression summary to  extract the standard error of
#   βhat_1. Assign its value to the variable `se.beta1`.
#
# * Compute the test statistic defined above using `beta1hat` and `se.beta1` for a test under the
#   null hypothesis H_0: β_1=0. Does it agree with the summary output from R?
#
# * Use the `pt` function to find the probability of observing a test statistic as extreme as this.
#
# * Referring to your t-test statistic and the `t value`s in the regression summary, what do you
#   conclude about the importance of the regression coefficients?
#
# * Find a 95% confidence interval for the slope β_1. You'll need the Use the `qt` function to find
#   the critical value of the t-distribution.
#
# * Does this interval contain your best guess for β_1.?

















# ==================================================================================
#
# 5. Estimation and prediction
# 
# Suppose now we are interested in some new point X=x*, and at this point we want to predict: (a) the location of the regression line, and (b) the value of Y.
# 
# In the first problem, we are interested in the value mu* = β_0 + β_1 x^*, i.e. the location of the regression line, at some new point X=x*. 
# 
# In the second problem, we are interested in the value of Y* = β_0 + β_1 x^* + ε, i.e. the actual observation value, at some new X=x*. 
# 
# The difference between the two is that the first simply concerns the location of the regression line, whereas the inference for the new observation Y* concerns both the position of the regression line and the regression error about that point.
# 
# Theory tells us that a 100(1-alpha)% confidence interval for mu*, the location of the regression line at X=x*, is
# 
#   yhat +/- t*_{n-2,alpha/2} s_{Yhat} = (βhat_0 + βhat_1 x*) +/- t^*_{n-2,alpha/2} s_e sqrt{ 1/n + (x*-xbar)^2/S_xx}
# 
# Similarly, a 100(1-alpha)% _prediction_ interval for the location of the observation Y* at X=x* is
# 
#   yhat +/- t*_{n-2,alpha/2} s_{Yhat} = (βhat_0 + βhat_1 x*) +/- t^*_{n-2,alpha/2} s_e sqrt{1 +  1/n + (x*-xbar)^2/S_xx}
# 

#
# Exercise 5.1:
# ~~~~~~~~~~~~~
#
# * Using the formulae above and the variables you have defined from previous questions, find a 95% confidence interval for the estimated waiting time when the eruption duration is 3 minutes.
#
# * Repeat the calculation to compute a 95\% prediction interval for the actual waiting time, W.
#
# * Compare the two intervals.
#

















