#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_journey.R
# File Author: William Whinn

RandomJourney <- function(data, walk_mode = 'out')
{
  # Create empty objects within function scope.
  path <- ''
  stuck <- FALSE

  loop_iteration <- 0

  # Get list of Root Nodes.
  root_nodes <- which(sapply(sapply(V(data), function(x) neighbors(
    data,x, mode="in")), length) == 0)

  # Create numerical list of detected root node(s).
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

    walk1 <- random_walk(data, start = previous_state, steps = 2,
                         stuck = 'return', mode = walk_mode)

    next_step <- tail(as.integer(walk1), n = 1)

    ################################
    # Stage 2: Assess Surroundings #
    ################################

    # Guide the walker between steps.
    # TODO Write the code for this.

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    # nodes_available <- betweenness(data, loop_iteration) # By betweenness
    # nodes_available <- length(adjacent_vertices(data, next_step)) # Adjacent vertices
    nodes_available <- igraph::neighbors(data, next_step, mode = walk_mode) # By Neighbours

    number_of_nodes <- length(igraph::neighbors(data, next_step, mode = 'out'))

    # print(number_of_nodes)
    # print(nodes_available)

    biomass <- vertex_attr(foodwebs$gramwet, 'Biomass',
                           index = V(foodwebs$gramwet))[[next_step]]

    if (biomass == 0)
    {
      print("NOTE: Detected a creature with Biomass of '0'.")
    }
    else if (as.integer(biomass) > as.integer(next_step))
    {
      print("NOTE: Consumed a creature of a lower Biomass than itself.")
    }
    else if (as.integer(biomass) < as.integer(next_step))
    {
      print("NOTE: Consumed by a creature of a higher Biomass than itself.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
      invisible(path)
    }
    else if (loop_iteration >= igraph::vcount(data))
    {
      print("NOTE: Number of loops has reached the length of the network.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
      invisible(path)
    }
    else if (number_of_nodes <= 1)
    {
      print("NOTE: There are no nodes available for traversal.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
      invisible(path)
    }
    else
    {
      print("NOTE: RandomJourney() has encountered an unknown error.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
      invisible(path)
    }

    # if (nodes_available <= 1 || loop_iteration >= igraph::vcount(data))
    # if (number_of_nodes <= 1 || loop_iteration >= igraph::vcount(data))
    # if (biomass == 0 || number_of_nodes <= 1 || loop_iteration >= igraph::vcount(data))
    # {
    #   # Walk complete or stuck, silently return 'path'.
    #   print(paste("NOTE: No change in direction available. Terminating Random",
    #               "Journey."))
    #   stuck <- TRUE
    #   invisible(path)
    # }

    ######################################
    # Stage 3: Compile current walk path #
    ######################################

    path <- union(path, walk1)
  }

  # Convert the path to an integer vector list for processing.
  path <- as.vector(as.integer(path))

  # Trim the initial (empty) step.
  path <- path[-1]

  # Convert 'walk_data' to a graph object.
  path <- graph_from_adj_list(path)

  # path <- V(path)

  # Remove reciprocal relationships from 'walk_data'.
  path <- simplify(path)

  # Convert to data frame list.
  # path1 <- path[-1]
  # path1 <- as.integer(as.vector(path))
  # path2 <- c(path1[-1], tail(path1, n = 1))
  # path <- data.frame(path1, path2)
  # path <- graph_from_data_frame(path)

  # Output the number of loop iterations.
  print(paste("NOTE: Performed", loop_iteration, "loop(s)."))

  # Output the path taken.
  print(paste("NOTE: Printing path taken."))
  print(paste(path))

  # path <- graph_from_edgelist(path)

  # Silently return the completed random journey path.
  invisible(path)
}

# End of File.
