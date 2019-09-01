#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_journey.R
# File Author: William Whinn

RandomJourney <- function(data)
{
  # Create empty objects within function scope.
  path <- ''
  stuck <- FALSE

  loop_iteration <- 0

  # Get list of Root Nodes.
  root_nodes <- which(sapply(sapply(V(data), function(x) neighbors(
    foodwebs$gramwet,x, mode="in")), length) == 0)

  root_nodes <- as.vector(as.integer(root_nodes))

  # Print the name and location of each of the root nodes detected.
  print(paste("NOTE: Detected root nodes:"))
  print(root_nodes)

  print(paste("Number of Root Nodes: ", length(root_nodes), ".", sep = ''))

  # If there are multiple root nodes, randomly select one and use it as the
  # starting point for the Random Journey.
  if(length(root_nodes) > 1)
  {
    root_nodes <- sample(root_nodes, 1, replace = FALSE)
  }

  # Assign the chosen root node as the starting position for the random journey.
  previous_state <- as.vector(as.integer(root_nodes))

  print(paste("NOTE: Beginning Random Journey from the selected root node: ",
              root_nodes, ".", sep = ''))

  print(root_nodes)

  while (isFALSE(stuck))
  {
    # Increment the number of loops performed.
    loop_iteration <- loop_iteration + 1

    ###################
    # Stage 1: Step 1 #
    ###################

    # Take the values from the previous iteration and pass them to the first
    # step of this iteration of the journey.

    walk1 <- random_walk(data, previous_state, 2, stuck = 'return')
    next_step <- tail(walk1, n = 1)

    ################################
    # Stage 2: Assess Surroundings #
    ################################

    # Guide the walker between steps.
    # TODO Write the code for this.

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    #nodes_available <- betweenness(data, loop_iteration) # By betweenness

    nodes_available <- length(adjacent_vertices(data, next_step)) # Adjacent vertices

    print(nodes_available)

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
