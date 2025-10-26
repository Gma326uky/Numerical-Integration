# Function to estimate an the value of the integral of function 'f' from
# points a to b using one of the 3 estimation methods.

# Number of cutpoints 'k' and 'method' must be specified.
integral_estimate <- function(f, a, b, k, method){
  # Stop if the number of 'k' cutpoints specified is less than 2
  if (k < 2){
    stop("Number of points 'k' must be at least 2")
  }
  # Width of boxes
  width <- (b - a) / (k - 1)
  # All cutpoints
  points <- seq(a, b, by = width)
  # Heights at each cutpoint
  heights <- f(points)
  # Estimate using the rectangle method
  if(method == "rectangle"){
    estimate <- width * sum(heights[1:k-1])
    # Estimate using the trapezoid method
  } else if(method == "trapezoid"){
    estimate <- (width / 2) * (heights[1] + heights[k] + 2*sum(heights[-c(1, k)]))
    # Estimate using the Simpson's rule method
  } else if(method == "simpson"){
    # If the number of cutpoints is odd, estimate using Simpson's rule
    if (k %% 2 != 0) {
      # Simpson's rule estimate if the number of cutpoints is 3
      if(k == 3){
        estimate <- (width / 3) * (heights[1] + heights[k] + 4*heights[k-1])
        # Simpson's rule estimate if the number of cutpoints is 5
      } else if(k == 5){
        estimate <- (width / 3) * (heights[1] + heights[k] + 4*sum(heights[seq(2, k-1, by = 2)]) + 2*heights[k-2])
        # Simpson's rule estimate if the number of cutpoints is greater than 5
      } else if(k > 5){
        estimate <- (width / 3) * (heights[1] + heights[k] + 4*sum(heights[seq(2, k-1, by = 2)]) + 2*sum(heights[seq(3, k-2, by = 2)]))
      }
      # If the number of cutpoints is even, can't use Simpson's rule
    } else if (k %% 2 == 0) {
      stop("Number of points 'k' must be odd to use Simpson's rule")
    }
    # Stop if the 'method' specified is not valid, and list valid methods.
  } else {
    stop('Please specify method "rectangle", "trapezoid", or "simpson"')
  }  
  # Show the value of the estimate
  print(estimate)
}