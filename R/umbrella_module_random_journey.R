#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_journey.R
# File Author: William Whinn

RandomJourney <- function(
  data,
  attribute,
  walk_mode = 'out'
  )
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
  else if (length(root_nodes) == 1)
  {
    root_nodes <- as.integer(root_nodes)
  }
  else
  {
    print("NOTE: No 'root node' has been detected. Selecting at random.")
    root_nodes <- sample(length(data), 1, replace = FALSE)
  }

  # Assign the chosen root node as the starting position for the random journey.
  previous_state <- as.vector(as.integer(root_nodes))

  print(paste("NOTE: Beginning Random Journey from the selected node: ",
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

    walk <- random_walk(data, start = previous_state, steps = 2,
                         stuck = 'return', mode = walk_mode)

    next_step <- tail(as.integer(walk), n = 1)

    ################################
    # Stage 2: Assess Surroundings #
    ################################

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    # Detect neigbouring nodes for the journey.
    nodes_available <- igraph::neighbors(data, next_step, mode = walk_mode)

    number_of_nodes <- length(igraph::neighbors(data, next_step, mode = 'out'))

    attribute_mod <- vertex_attr(data, attribute,
                           index = V(data))[[next_step]]
    attribute_mod_next <-vertex_attr(data, attribute,
                                     index = V(data))[[(as.integer(next_step) + 1)]]

    # Decide next step based on prefering to eat a smaller creature.
    next_step_loop <- 0
    while (number_of_nodes >= next_step_loop)
    {
      #if (as.integer(attribute_mod) >= as.integer(next_step))
      if (as.integer(attribute_mod) > as.integer(attribute_mod_next))
      {
        print(paste("NOTE: Targeting a node containing a lower value of ",
                    "attribute '", attribute, "',", sep = ""))
        next_step <- sample(number_of_nodes, size = 1)
        break
      }
      else
      {
        print("NOTE: Reject current target. Choosing another target.")
      }

      # Increment the loop by 1.
      next_step_loop <- next_step_loop + 1
    }

    # Check next step conditions.
    if (attribute_mod == 0)
    {
      print(paste("NOTE: Detected a target with attribute '", attribute,
                  "' value of '0'.", sep = ""))
      print("NOTE: Searching for nearest alternative.")
    }
    else if (as.integer(attribute_mod) > as.integer(next_step))
    {
      print(paste("NOTE: Selected a target of a lower value of attribute '",
                  attribute, "' than itself.", sep = ""))
      # - Uncomment to move forward after interacting with single vertex.
      # - If left commented, walker will interact with every vertex available
      #   until resources are exhausted.
      # break
    }
    else if (as.integer(attribute_mod) < as.integer(next_step))
    {
      print(paste("NOTE: A target of a lower value of attribute '",
                  attribute, "' is not available.", sep = ""))
      print("NOTE: No logical path forward available.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
      invisible(path)
    }
    else if (loop_iteration >= igraph::vcount(data))
    {
      print(paste("NOTE: Number of loops performed has reached the length of",
                  "the network."))
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

    ######################################
    # Stage 3: Compile current walk path #
    ######################################

    path <- union(path, walk)
  }

  # Convert the path to an integer vector list for processing.
  path <- as.vector(as.integer(path))

  # Trim the initial (empty) step.
  path <- path[-1]

  # Convert 'walk_data' to a graph object.
  path <- graph_from_adj_list(path)

  # Remove reciprocal relationships from 'walk_data'.
  path <- simplify(path)

  # Output the number of loop iterations.
  print(paste("NOTE: Performed", loop_iteration, "loop(s)."))

  # Output the path taken.
  print(paste("NOTE: Printing path taken."))
  print(path)

  # Silently return the completed random journey path.
  invisible(path)
}

# End of File.
