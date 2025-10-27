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
This function creates the width between points according to the difference between the upper and lower bound, and adjusted to the number of cutpoints (is k cutpoints, the width is divided by k-1).
Then I specified for the heights of our boxes to be generated in the sequences from points a to b in intervals decided by our calculated width.

After having all of these elements, I created an if loop that would apply a method of estimation depending on the method inputted in the function ("rectangle", "trapezoid", or "simpson")

The rectangle rule estimates the values of the integral using the following formula:

$$width * sum(heights[1:k-1])$$
