#
# PRACTICAL 2: Comparing Two Samples
# ---------------------------------
#
#
# In this practical, we illustrate both parametric and non-parametric techniques for comparing 
# two samples. Our objective will be to assess whether or not two samples can be regarded as 
# being from the same population. We perform the parametric version first, which requires 
# normality assumptions of the data, and then move on to the non-parametric form which requires
# no normality assumptions.
# 
# You will need the following skills from previous practicals:
#    *   Basic R skills with arithmetic, functions, etc
#    *   Manipulating and creating vectors: `c`, `seq`, `length`
#    *   Calculating data summaries: `mean`, `sd`, `var`, `min`, `max`
#    *   Plotting a scatterplot with `plot`, a histogram with `hist`, and a boxpot with `boxplot`
# 
# New R techniques:
#    *   Normal quantile plots for assessing normality using `qqnorm`
#    *   Quantile and inverse-quantile functions for standard distributions, e.g. `qnorm` and `pnorm`
#    *   Ranking a data vector using `rank`

# ==================================================================================
#
# 1. The data
# 
#
# Eriksen, Björnstad an Götestam (1986) studied a social skills training program for alcoholics.
# Twenty-three alcohol-dependent male inpatients at an alcohol treatment centre were randomly
# assigned to two groups. The 12 control group patients were given a traditional treatment 
# programme. The 11 treatment group patients were given the traditional treatment, plus a class
# in social skills training ("SST"). The patients were monitored for one year at 2-week intervals,
# and their total alcohol intake over the year was recorded (in cl pure alcohol).
#
# A: Control	1042	1617	1180	973	1552	1251	1151	1511	 728	1079	951	1391
# B: SST	    874	   389	 612	798	1152	 893	 541	 741	1064	 862	213	
#


#
# Exercise 1.1:
# ~~~~~~~~~~~~~
#
#  * Use the `c` function to enter these data into R as two vectors called `A` for the control 
#    group, and `B` for the treatment group. 
#
#  * Check your summary statistics match mine below to ensure the data are correct.

## summary(A)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     728    1025    1166    1202    1421    1617
## summary(B)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   213.0   576.5   798.0   739.9   883.5  1152.0


A <- c(1042, 1617, 1180,  973, 1552, 1251, 1151, 1511,  728, 1079,  951, 1391)
B <- c(874,  389,  612,  798, 1152,  893,  541,  741, 1064,  862,  213)
summary(A)
summary(B)



#
# Exercise 1.2:
# ~~~~~~~~~~~~~
#
# * Compare the distributions of  `A` and `B` using a side-by-side `boxplot`. What conclusions 
#   can you draw about the two groups?
# * Draw histograms (`hist`) and Normal quantile plots (`qqnorm`) of both samples. On the basis 
#   of these plots, do the samples look approximately symmetric and Normally distributed?



boxplot(A,B)

par(mfrow=c(1,2))
hist(A)
qqnorm(A)

par(mfrow=c(1,2))
hist(B)
qqnorm(B)


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ TECHNIQUE: 
# ^ 
# ^ A better graphical way to assess whether the data is distributed normally is to draw a "normal
# ^ quantile plot" (or quantile-quantile, or QQ plot). We can do this in _R_ using the `qqnorm`
# ^ function, where to draw the Normal quantile plot for a vector of data `x` we use the command
# ^ 
# ^ qqnorm(x)
# ^ 
# ^ With this technique, the quantiles of the data (i.e. the ordered data values) are plotted
# ^ against the quantiles which would be expected of a matching normal distribution. If the data
# ^ are normally distributed, then the points of the quantile plot will should lie on an 
# ^ approximately straight line. Deviations from a straight line suggest departures from the
# ^ normal distribution. 
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#
# Exercise 1.3:
# ~~~~~~~~~~~~~
#
# * Draw Normal quantile plots of both samples using `qqnorm`. Do the samples look approximately
#   Normally distributed? Do your conclusions agree with those made on the basis of the histograms?
#

qqnorm(A)
qqnorm(B)




# ==================================================================================
#
# 2. Theory: The independent sample t-test
#
#
# We assume that we have two random quantities X ∼ N(μ_X,σ^2) and Y ∼ N(μ_Y,σ^2). We obtain an 
# i.i.d. sample of n observations of X, X_1,...,X_n, and a sample of size m from Y, Y_1,...,Y_m.
# We assume that the samples are independent, so each X_i is independent of each Y_j. Note that
# we have assumed *different means* for X and Y, but the same variances. 
#
# The question we are asking is: are the means of the two populations are equal, is μ_X=μ_Y, 
# given the evidence we see in our samples?

# Under the above assumptions, we have the following definitions and results:
#
#  *  The *independent sample t-statistic* is:
#
#          (xbar−ybar) − (μ_X−μ_Y)
#      t = ----------------------- ,
#             s_p √(1/n + 1/m)
#
# *  s_p^2 is the *pooled sample variance* which is used to estimate the common variance σ^2 by
#    using data from both samples:
#
#                (n−1) s_X^2 + (m−1) s_Y^2
#       s_p^2 = --------------------------- .
#                        n + m − 2
#
# *  Under the null hypothesis H_0: μ_X = μ_Y, the t statistic has a t-distribution with m+n−2 
#    degrees of freedom. 
# *  The t-test would then reject the null hypothesis that the mean of the two underlying
#    populations is the same at level α in favour of an alternative H_1: μ_X ≠ μ_Y if
#
#       |t| > t∗_(m+n−2),α/2.
# * The corresponding 100(1-α)% confidence interval for μ_X - μ_Y is then
#
#        (xbar−ybar) ± t∗_{(m+n−2),α/2} s_p √(1/n + 1/m)
#





# ==================================================================================
#
# 3. Applying the independent sample t-test
#
# 
# To compute the t-test statistic, we're going to need to begin by finding some simple summaries of our two samples.

#
# Exercise 3.1:
# ~~~~~~~~~~~~~
# 
# * Use the `mean`, `var`, and `length` functions to find the sample mean, sample variance, and
#   sample size for the Treatmeant A group. Save these as `abar`, `sa2`, and `n`. 
#
# * Repeat the process for the Treatmeant B group, creating variables `bbar`, `sb2`, and `m`.
#


abar <- mean(A)
sa2 <- var(A)
n <- length(A)
bbar <- mean(B)
sb2 <- var(B)
m <- length(B)





#
# Exercise 3.2:
# ~~~~~~~~~~~~~
# 
# * Use the formula given above and the variables you have just created to calculate the 
#   pooled sample variance; save this to `sp2`.
#



sp2 <- ((n-1)*sa2+(m-1)*sb2)/(n+m-2)
sp2






#
# Exercise 3.3:
# ~~~~~~~~~~~~~
# 
# * Under the null hypothesis of no difference in population means, calculate the value of the 
#   test statistic, t, as defined in the theory section above and save it as `t`. Check you
#   get the same value as shown below.
#
## [1] 4.00757
#
# * How many degrees of freedom do we associate with the distribution of t? Save this value to
#   a variable `df`.
#


t <- (abar-bbar)/(sqrt(sp2*(1/n+1/m)))
t
df <- n+m-2
df






# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ 
# ^ TECHNIQUE: 
# ^ 
# ^ R provides a range of functions to support calculations with standard probability 
# ^ distributions. In the previous practical, we encountered the normal density function `dnorm`,
# ^ as well as the random number generation functions for the uniform (`runif`) and normal 
# ^ (`rnorm`) distributions.
# ^ 
# ^ For every distribution there are four functions. The functions for each distribution begin 
# ^ with a particular letter to indicate the functionality (see table below) followed by the 
# ^ name of the distribution:
# ^ 
# ^ | Letter | e.g. | Function                                                             |
# ^ |-----|---------|----------------------------------------------------------------------|
# ^ | "d" | `dnorm` | evaluates the probability density (or mass) function, $f(x)$         |
# ^ | "p" | `pnorm` | evaluates the cumulative density function, $F(x)=P[X \leq x]$, hence |
# ^ |     |         | finds the probability the specified random variable is less than the |
# ^ |     |         | given argument.                                                      |
# ^ | "q" | `qnorm` | evaluates the inverse cumulative density function (quantiles),       |
# ^ |     |         | $F^{-1}(q)$ i.e. the value $x$ such that $P[X \leq x] = q$. Used to  |
# ^ |     |         | obtain critical values associated with particular probabilities $q$. |
# ^ | "r" | `rnorm` | generates random numbers                                             |
# ^ 
# ^ The appropriate functions for Normal, $t$ and $\chi^2$ distributions are given below, 
# ^ along with the optional parameter arguments.
# ^ 
# ^   + Normal distribution: `dnorm`, `pnorm`, `qnorm`, `rnorm`. 
# ^        Parameters: `mean` (μ) and `sd` (σ).
# ^   + $t$ distribution: `dt`, `pt`, `qt`, `rt`. 
# ^        Parameter: `df`.
# ^   + $\chi^2$ distribution: `dchisq`, `pchisq`, `qchisq`, `rchisq`. 
# ^        Parameter: `df`.
# ^ 
# ^ For a list of all the supported distributions, run the command `help(Distributions)`
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^




#
# Exercise 3.4:
# ~~~~~~~~~~~~~
# 
# * How would you use the `qt`` function function to find the appropriate critical value for
#   a test of H_0: μ_X=μ_Y against H_1: μ_X≠μ_Y at the 5% level of significance. 
#   Check you get the same value as below.
#
## [1] 2.079614
#

tcrit <- qt(0.975, df=df)
tcrit

#
# Exercise 3.5:
# ~~~~~~~~~~~~~
# 
# *  Compare this to your value of `t`, and hence perform the significance test. 
# *  Use this information to construct a 95% confidence interval for the difference in means
#    between the two populations.
# *  What is the probability of observing a value of the test statistic whose absolute value is
#    at least as large as the one observed under the null hypothesis? i.e. what is 
#    P[T_{df} >= t]?
# *  On the basis of your calculations above, what would you conclude about the population 
#    means for the two groups A and B?
# *  Do you think the assumption of equal variances holds here? If not, would this affect your
#    conclusions?

ci <- (abar-bbar) + c(-1,1) * tcrit *sqrt(sp2*(1/n+1/m))
ci
pvalue <- 2*(1-pt(t,df))
pvalue

## Strong evidence here to reject H_0 at 5% level, sample sizes are rather small
##
## From the boxplots in Ex 1.2, this assumption does not look unreasonable though perhaps B is slightly less spread than A.





# ==================================================================================
#
# 4. Theory: Nonparametric rank-sum test
#
# Nonparametric methods do not assume any distribution, and try to make only the weakest possible
# assumptions about the distributions that describe our data and are often used in such 
# situations. The nonparametric version of the independent sample t-test is the (Wilcoxon) 
# rank-sum test. Nonparametric tests do not assume knowledge of the distributions of X and Y,
# and are often based on the data ranks with tests comparing the data ranks of the two groups.
#
# Given two samples X1,...,Xn, and Y1,...,Ym, the rank-sum test procedure is as follows:
# 
# 1. Combine the two samples X1,...,Xn and Y1,...,Ym, and rank each data point in the combined
#    sample from 1 (smallest) to N=n+m (largest)
# 2. Let the ranks of the Xs in the combined group be r_1,...,r_n which are all integers from 
#    the set {1,...,N}.
# 3. The *rank-sum test statistic* is then
#       n
#  W =  ∑  r_i.
#      i=1 
#     
# 4. Under H0: "no difference between the distributions of the two groups", we expect the rank-sum 
# for each group to be similar in size. Particularly large (or small) values of the rank sum
# statistics are evidence to reject the H0 and conclude the populations are different
#
# Note: our choice to base the test on the Xs was entirely arbitrary; we could have used the Ys instead.


# ==================================================================================
#
# 5. Applying the rank-sum test
#
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# ^ 
# ^ TECHNIQUE: 
# ^ 
# ^ To find the *ranks* of a vector of data points, we can use the `rank` function, e.g.
# ^ 
# ^ rank(x)
# ^ 
# ^ will return the sample ranks of the values in the vector x. The rank function will 
# ^ automatically handle any ties by assigning the appropriate midrank value to all tied 
# ^ observations. See the R help on `rank`` for more details.
# ^ 
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#
# Exercise 5.1:
# ~~~~~~~~~~~~~
# 
# * Use the `c` function to combine the two samples together into a larger vector composed of
#   the elements of the A group followed by the B group. Use the `rank` function on the combined
#   sample to rank all the observations; call this `rks`.
#
# * The first n elements of `rks` should now be the ranks r_i for the A group in the combined 
#   sample (why is this so?).
#   Extract these from the larger vector and save them as `Aranks`.
#
# * Find the rank-sum test statistic for the A group.
#



AB <- c(A,B)
rks <- rank(AB)
## statistic for group A
Aranks <- rks[1:n]
W <- sum(Aranks)
W






# ------------------------------------------------------------------------------------------
# 5.1 The exact signed-rank test
# ------------------------------------------------------------------------------------------
#
# The exact critical value for the rank-sum test is a function of the sample sizes, n and m,
# and the significance level, α. For a two-sided test at level α, we denote T_L and T_U as 
# the lower and upper critical values, and reject H_0: `Group 1 = Group 2’ at level α in favour
# of H_1: `Group 1 ≠ Group 2’ if W ∉ [T_L, T_U]. 
# 
# For particular values of n, m, and α, the standard tables  give values of the lower critical 
# value T_U. To find the lower critical value, we use the result that
#
# T_U = n(n+m+1) − T_L.
#
# Alternatively, we can use R to find the values for us, which is particularly useful as 
# the ranges of n,m,α on standard tables are quite limited. Run the following lines of code
# to create a function to return the rank-sum critical value for a given value of (n,m,α):
#
#  'qranksum' <- function(p,n,m){
#   return(qwilcox(p, n, m) + n*(n+1)/2)
#  }
#
# We can now find the critical value T such that P[W≤T]=p by using this new function as follows
#  
#  T <- qranksum(p, n, m)
#
# For a two-sided test at level `alpha` with sample sizes `n` and `m`, we would evaluate the
# above code at p=alpha/2 to find T_L, and at p=1-alpha/2 for T_U (or we could apply the formula
# given above to find T_U from T_L).


#
# Exercise 5.2:
# ~~~~~~~~~~~~~
# 
# * Use the qranksum function defined above to find the exact critical values T_L and T_U for
#   this problem.
#
# * Given the value of W calculated above, what do you conclude about these data? 
#   Do your results agree with the t-test?
#


'qranksum' <- function(p,n,m){
 return(qwilcox(p, n, m) + n*(n+1)/2)
}
## get the critical values
TL <- qranksum(0.025,n,m) ## use the function
TU <- n*(n+m+1)-TL ## use the formula
c(TL,TU)
TL < W
TU > W

## W is clearly >TU and outside the CI, so we again reject H_0





#
# Exercise 5.3:
# ~~~~~~~~~~~~~
# 
# * Repeat the analysis using the ranks of the B group. Compare what you find with your results
#   from testing A.
#
# * Note: You will need different critical values for the test on the B group, as n and m are
#   reversed.
#


Branks <- rks[-(1:n)]
W.B <- sum(Branks)
W.B
TL.B <- qwilcox(0.025,m,n)+m*(m+1)/2
TU.B <- m*(m+n+1)-TL.B
c(TL.B,TU.B)
TL.B < W.B
TU.B > W.B
## same conclusion though this time we're extreme in the other direction and below TL (unsurprising as W and W.B must sum to a constant)








# ------------------------------------------------------------------------------------------
# 5.2 The Normal approximation
# ------------------------------------------------------------------------------------------
#
#
# When the samples are both large, the distribution of the rank-sum statistic is approximately
# Normal. For large n and m, under the null hypothesis of no group differences we have: 
#   
# 1. E[W] = μ_W = n(n+m+1)/2
# 
# 2. Var[W]=σ_W^2 = nm(n+m+1)/12
# 
# 3. Approximately W ∼ N(μ_W,σ_W^2)
# 
# So for large samples, we can use these values to standardised W and use standard Normal tables
# to construct confidence intervals and test hypotheses.

#
# Exercise 3.4:
# ~~~~~~~~~~~~~
# 
# * Focussing on the A group, calculate the expectation and variance of the rank-sum test 
#   statistic W.
#
# * What is the approximating Normal distribution for W? Would you expect this to be a good 
#   approximation to make for this problem?
#
# * Use the Normal approximation to test for evidence of a difference between the groups at 
#   the 5% level. How do your results compare to the exact test?
#

mu.W <- n*(n+m-1)/2
mu.W
sig2.W <- n*m*(n+m-1)/12
sig2.W
## Approximating distribution is N(mu.W,sig2.W), but n,m are not very large so the approximation would not really be appropriate here.
## standardised test statistic -- about 4, which is large for a standard normal
Z <- (W-mu.W)/sqrt(sig2.W)
Z
## p-value -- 5e-5, so very strong evidence to reject though the normality approximation is shaky
pval <- 2*(1-pnorm(Z))
pval




# ------------------------------------------------------------------------------------------
# 5.3 Robustness to outliers
# ------------------------------------------------------------------------------------------
#
#
# One of the advantages of nonparametric tests is their robustness to outliers, which means the
# presence of surprisingly large or small values have little (if any) impact on the test or its
# conclusions. Conversely, parametric methods such as the t-test use summary statistics whose 
# values can be substantially distorted by extreme values resulting in substantial implications
# for inference.
#  

#
# Exercise 5.5:
# ~~~~~~~~~~~~~
# 
#  * Consider the second data point in group A. Suppose that its value was mis-recorded and the
#    true value was actually twice the value given. Create a new vector `A2`` that reflects this
#    updated information. 
#
#  * How does this change affect the rank of this data point in the combined sample? What is the
#    impact on the mean and variance of the group A sample?
#
#  * What do you think the implications will be for the rank-sum test and the independent sample
#    t-test?
#
#  * Re-run both the t-test and the rank-sum test. What, if anything, has changed? Would you 
#   change your conclusions?
#
#  * What do you conclude about the sensitivity of the conclusions of the rank-sum test and the
#    t-test to outliers?
#



## new data vector
A2 <- A
A2[2] <- 2*A2[2]
## new ranks and summaries
rks2 <- rank(c(A2,B))
rks2[2] ## rank is unchanged
## ranks unchanged => rank-sum test will be same

abar.2 <- mean(A2)
abar.2 ## mean increases 1200 --> 1330
sa2.2 <- var(A2)
sa2.2 ## variance increases 7.3e4 --> 41.4e4
## mean and var changed, so t-test statistic will be different.


## new pooled variance
sp2.2 <- ((n-1)*sa2.2+(m-1)*sb2)/(n+m-2)
sp2.2
## new t-test statistic
t.2 <- (abar.2-bbar)/(sqrt(sp2.2*(1/n+1/m)))
t.2 
## increased to 4.4

## new rank-sum statistic
W.2 <- sum(rks2[1:n])
## same as before, so nothing changes
W.2




# =========================================================================================
#
# 6. Further exercises
#
# If you finish the exercises above, have a look at the online worksheet for additional problems
# on these topics.
#
#







