#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_journey.R
# File Author: William Whinn

RandomJourney <- function(data, start_node = 1)
{
  # Create empty objects within function scope.
  path <- ''
  previous_state <- start_node
  stuck <- FALSE

  loop_iteration <- 0

  while (isFALSE(stuck))
  {
    # Increment the number of loops performed.
    loop_iteration <- loop_iteration + 1

    ####################
    # Stage 1ᵢ: Step 1 #
    ####################

    # Take the values from the previous iteration and pass them to the first
    # step of this iteration of the journey.

    print(paste("NOTE: Performing initial step"))

    walk1 <- random_walk(data, previous_state, 2, stuck = 'return')
    next_step <- tail(walk1, n = 1)

    #################################
    # Stage 2ᵢ: Assess Surroundings #
    #################################

    # Guide the walker between steps.
    # TODO Write the code for this.

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    degrees <- degree(data, v = next_step, mode = "in", loops = FALSE,
                      normalized = TRUE)

    print(degrees)

    if (degrees <= 0.1)
    {
      # Walk complete or stuck, silently return 'path'.
      stuck <- TRUE
      invisible(path)
    }

    ####################
    # Stage 3ᵢ: Step 2 #
    ####################

    walk2 <- random_walk(data, next_step, 2, stuck = 'return')
    next_step <- next_step <- tail(walk2, n = 1)

    # Append the path taken during this iteration to the previous iteration.
    path <- union(path, c(walk1, walk2))
  }

  # Trim the initial (empty) step.
  path <- path[-1]

  # Output the number of loop iterations.
  print(paste("NOTE: Performed", loop_iteration, "loop(s)."))

  # Silently return the completed random journey path.
  invisible(path)
}

# End of File.
