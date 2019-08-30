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

    print(paste("NOTE: Beginning loop #", loop_iteration, ".", sep = ''))

    ###################
    # Stage 1: Step 1 #
    ###################

    # Take the values from the previous iteration and pass them to the first
    # step of this iteration of the journey.

    print(paste("NOTE: Performing initial step of loop #", loop_iteration, ".",
                sep = ''))

    walk1 <- random_walk(data, previous_state, 2, stuck = 'return')
    next_step <- tail(walk1, n = 1)

    ################################
    # Stage 2: Assess Surroundings #
    ################################

    # Guide the walker between steps.
    # TODO Write the code for this.

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    # degrees <- degree(data, v = next_step, mode = "in", loops = FALSE,
    #                   normalized = TRUE)
    #
    # print(degrees)

    # nodes_available <- length(neighbors(graph_from_adj_list(walk1[loop_iteration]), 1, mode = 'out'))
    nodes_available <- betweenness(data, loop_iteration)

    print(nodes_available)

    #if (degrees <= 0.1)
    if (nodes_available <= 0.01 || loop_iteration >= length(data))
    {
      # Walk complete or stuck, silently return 'path'.
      print(paste("NOTE: No change in direction available. Terminating Random",
                  "Journey."))
      stuck <- TRUE
      invisible(path)
    }

    ###################
    # Stage 3: Step 2 #
    ###################

    print(paste("NOTE: Performing final step of loop #", loop_iteration, ".",
                sep = ''))

    walk2 <- random_walk(data, next_step, 2, stuck = 'return')
    next_step <- next_step <- tail(walk2, n = 1)

    # Append the path taken during this iteration to the previous iteration.
    path <- union(path, c(walk1, walk2))

    print(paste("NOTE: Ending loop #", loop_iteration, ".", sep = ''))
  }

  # Trim the initial (empty) step.
  path <- path[-1]

  # Output the number of loop iterations.
  print(paste("NOTE: Performed", loop_iteration, "loop(s)."))

  # Silently return the completed random journey path.
  invisible(path)
}

# End of File.
