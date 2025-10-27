# Numerical Integration

For this project, I developed a function that estimates the value of an integral using three different quadrature methods: rectangle, trapezoid, and Simpson’s. These methods are usually used to estimate integrals that are too complex to evaluate directly. 
I tested my function to see if it was working as intended, and then I used it to estimate the integrals for the Gamma and exp(x) functions at different bounds, utilizing a varied number of boxes for each method of estimation.
My goal was to see which method of estimation was the most accurate at each instance, and determine why a method might lose effectiveness when estimating the same integral at different bounds.


## How It's Made:

**Tech used:** R, Rstudio (tidyverse, ggplot2)

I first developed my function to estimate the value of the integral using three different quadrature methods: rectangle, trapezoid, and Simpson’s.
This function can be found on the "N_Integration" R file.

The input this function requires are the function whose integral we want to estimate, the bounds of the integral (a and b), the number of cutpoints we will use (k cutpoints required to estimate k-1 number of boxes using the rectangle and trapezoid methods, and (k-1)/2 number of boxes using Simpson's rule), and the method that will be used ("rectangle", "trapezoid", "simpson").
I had to specify that the function won't work if the number of cutpoints was less than 2, since we need at least 2 points to generate 1 box estimation with the rectangle and trapezoid methods.
This function creates the width between points according to the difference between the upper and lower bound, and adjusted to the number of cutpoints (if k cutpoints, the width is divided by k-1).
Then I specified for the heights of our boxes to be generated in the sequences from points a to b in intervals decided by our calculated width.

After having all of these elements, I added an if loop that would apply a method of estimation depending on the method inputted in the function ("rectangle", "trapezoid", or "simpson")

The rectangle rule estimates the values of the integral using the following formula:

$$width * sum(heights[1:k-1])$$

The trapezoid rule estimates the values of the integral using the following formula:

$$(width / 2) * (heights[1] + heights[k] + 2*sum(heights[-c(1, k)]))$$

Finally, Simpson's method requires for the number of cutpoints to be odd in order to be used, otherwise the process will be stopped and an error message indicating this will appear.
This method uses different formulas according to the number of cutpoints specified.

For k = 3 cutpoints:

$$(width / 3) * (heights[1] + heights[k] + 4*heights[k-1])$$

For k = 5 cutpoints:

$$(width / 3) * (heights[1] + heights[k] + 4*sum(heights[seq(2, k-1, by = 2)]) + 2*heights[k-2])$$

For k > 5 cutpoints:

$$(width / 3) * (heights[1] + heights[k] + 4*sum(heights[seq(2, k-1, by = 2)]) + 2*sum(heights[seq(3, k-2, by = 2)]))$$

Finally, the function will print the specified estimate.

After developing my Numerical Estimate function, I tested it to make sure it was working as intended using the three methods to estimate integral of the exp(x) function with bounds 0 to 1 using 1 box, 2 boxes, and 11 cutpoints.I also determined that Simpson's method was the most accurate in estimating this integral.

This testing, as well as the following estimation of the Gamma function, can be found in the "Numerical Integration - The Gamma Function" files.

After determining my function was working as intended, I moved on to use it on the gamma function, which I specified to be the following:

$$(x^(alpha-1))*exp(-x)$$


The first thing I did was plot a curve of this function at alpha = 1 and alpha = 2 to see its behavior from 0 to infinity (approximating the behavior to infinity by specifying 10,000 as the upper bound).
I also calculated the true value of the integral using the integrate() function to compare it with my results from the Numerical estimation.

I decided to use only the trapezoid method to estimate the value from 0 to infinity of the gamma function. I had to slightly adjust my Numerical Estimation function to include an argument for the alpha values.

I estimated the function wit alpha = 1 at using different cutpoints, the less cutpoiints I used, the more the value of the integral would be overestimated in this case (which makes sense when you look at the curve of the function).

Using 50,000,000 cutpoints, I estimated the value of this integral from integer values of alpha from 1 to 6, and compare the results.

Then I moved on to estimations of the exp(x) function, which can be found in the "Numerical Integration - Exp function" files.

For this function, I created an empty data frame, and using a for loop and my function for numerical integration, I calculated the integral with bounds 1 to 5 using all 3 methods of estimation using n = 5, 10, ...., 50 number of boxes, and recording the number of boxes for the estimate, and method used in the data frame.

Using ggplot, I graphed the data frame to see how the estimate for each method changed as the number of boxes increased. I added a horizontal line with the true value of the estimation for reference, and analyzed my results.

I repeated the same process for the exp(x) function, but this time using bounds from -Inf to 0. To approximate -Inf, I used 3 different values: -100, -10,000, and -1,000,000, so that I could see how the numerical estimation changed the more the lower bound approached -Inf.
Having plots for each different lower bound value, I analyzed how the behavior differed in this case.


## Optimizations

In order to make sure that the Simpson's rule was only used when the number of cutpoints was odd, I added an if loop that specified that the remainder of the division of k by 2 couldn't be 0 for the integral to be estimated, otherwise the function would stop and an error message would apper.

Since I wanted to generate estimates for the integral of the gamma function at different values of alpha, I didn't want to create separate gamma function with different values of alpha each. Instead, I modified my numerical integration function to include an argument for alpha that was set to "None" by default.
If the value of this argument was changed, then the heights of the different cutpoints would be calculated with a function that had the specified value for alpha.

When using the trapezoid method to estimate the integral of the gamma function from o to Infinity at alpha = 1, I found by trial and error that the required number of cutpoints I needed to accurately estimate this integral was 50,000,000 cutpoints. This is why I used this number of cutpoints to estimate the same integral at different values of alpha.

After having my data frame with the results from the estimates of the integrals for exp(x) function I wanted to analyze, I transformed the data using the pivot_longer() function from the tidyverse, so that my data frame would have only 3 columns, one with the number of boxes, another wit the method of estimation, and another one with the value of the estimate. This made the date a lot easier to plot together.

I made sure to add descriptive labels to my plots to make them easy to read.


## Lessons Learned:

One challenge I encountered was coding the formula for Simpson's method. At first I tried using one single formula for all k cutpoints which was the following:

$$(width / 3) * (heights[1] + heights[k] + 4*sum(heights[seq(2, k-1, by = 2)]) + 2*sum(heights[seq(3, k-2, by = 2)]))$$

The issue here was that since the heights of some of my points were generated with the seq() formula, then in some instances, there wouldn't be enough points to generate a sequence, or some heights would be added more times than they should.
Since this was only an issue at k = 3 and k = 5 for Simpson's method, I added separate formulas for those numbers of cutpoints, and then used my formula mentioned before for all cutpoints greater than 5.

When testing if my function worked using integral of the exp(x) function with bounds 0 to 1, I found the Simpson's method to be the most effective at estimating the value of this integral given the same number of cutpoints.

After looking at the integral from 0 to Infinity of the gamma function at different integer values of gamma, I found that the result of each subsequent value of alpha could be expressed with the following formula:

$$Integral of gamma (alpha = a + 1) = a*[Integral of gamma (alpha = a)]$$

This can be also expressed by saying:

$$Gamma(n) = (n - 1)!$$

When estimating integral of the exp(x) function with bounds from 1 to 5, I found that the Simpson's method was the most accurate in estimating the value of this integral, estimating the value accurately even at a low number of boxes. 
The Trapezoid method overestimated the value of the integral at a lower number of boxes, but approached the value more as the boxes increased to 50.
The rectangle method underestimated the value of the integral, and struggled to approach the true value even as the number of boxes approached 50.

When estimating integral of the exp(x) function with bounds from -100, -10,000, and -1,000,000 (to approximate -Inf) to 0, then it was a different story.
Here, The true value of the integral was 1. As the lower bound became smaller, the Trapezoid and Simpson's method would start overestimating the value of the integral more, and become less accurate.
Since the rectangle method would underestimate the value of the integral, it was less susceptible to the decrease in the lower bound, given that its estimate would always be a value equal or greater than 0.
Therefore, as the lower bound approached -Inf, the rectangle method became the most accurate estimator.

