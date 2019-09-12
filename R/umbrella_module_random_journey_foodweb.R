#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_journey_foodweb.R
# File Author: William Whinn

#########
# Notes #
#########

# - This function uses the principles of looping a Random Walk, performing a
#   step from node-to-node based on decision-making criteria specific to the
#   dataset and its domain.
# - This approach is tied to the 'foodwebs' dataset as part of R package
#   'igraphdata'. Specifically, the 'gramwet' subset network.
# - It is possible to replace the 'gramwet' subset with any other foodweb
#   provided by the 'igraphdata/foodweb' dataset.
# - The domain knowledge utilised to 'guide' the Random Journey (dynamic random
#   walk) in this case is the fact that a larger creature will typically
#   consume another.
# - The walker as part of this Random Journey will typically consume creatures
#   of a lower biomass than itself before taking another step, meaning that a
#   walker can consume multiple creatures per step. In this sense, the walker
#   is organically exhausting the resources of its current location before
#   moving toward another.

#############
# Functions #
#############

RandomJourneyFoodweb <- function()
{
  ##############################################################################
  # PREREQUISITES ##############################################################
  ##############################################################################

  library(GGally)

  # Set random seed for experiment.
  umbrella::ApplyRandomSeed()

  print("########## BEGIN EXPERIMEMT ##########")

  print(paste("TEST: Loading the 'foodwebs' dataset from package",
              "'igraphdata'."))

  # Select data set.
  data("foodwebs")

  # Select attribute of focus (for decision-making).
  attribute <- 'Biomass'

  # Assign chosen foodweb network to variable.
  gramwet <- foodwebs$gramwet

  # Purge self-loops.
  gramwet <- simplify(gramwet)

  ##############################################################################
  # RANDOM JOURNEY SECTION #####################################################
  ##############################################################################

  # Create empty objects within function scope.
  path <- ''
  stuck <- FALSE

  loop_iteration <- 0

  # Get list of Root Nodes.
  root_nodes <- which(sapply(sapply(V(gramwet), function(x) neighbors(
    gramwet, x, mode = "in")), length) == 0)

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
    root_nodes <- sample(length(gramwet), 1, replace = FALSE)
  }

  # Uncomment to override starting position.
  # root_nodes <- 66

  # Assign the chosen root node as the starting position for the random journey.
  previous_state <- as.vector(as.integer(root_nodes))

  print(paste("NOTE: Beginning Random Journey from the selected node: ",
              root_nodes, ".", sep = ''))

  print(root_nodes)

  while (isFALSE(stuck))
  {
    # Increment the number of loops performed.
    loop_iteration <- loop_iteration + 1

    ##########################################
    # STAGE 1: WALK FROM ONE NODE TO ANOTHER #
    ##########################################

    # Take the values from the previous iteration and pass them to the first
    # step of this iteration of the journey.
    walk <- random_walk(gramwet, start = previous_state, steps = 2,
                        stuck = 'return', mode = 'out')

    # Choose the previously-visited node as the starting position for next step.
    next_step <- tail(as.integer(walk), n = 1)

    ##################################################
    # STAGE 2: ASSESS SURROUNDINGS / DECISION-MAKING #
    ##################################################

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    # Select walk mode: 'in', 'out', or 'all'. Default: 'all'.
    walk_mode <- 'all'

    # Detect neigbouring nodes for the journey.
    nodes_available <- igraph::neighbors(gramwet, next_step, mode = walk_mode)

    number_of_nodes <- length(igraph::neighbors(gramwet,
                                                next_step,
                                                mode = walk_mode))

    # Get attribute value for current position.
    attribute_value <- vertex_attr(gramwet, attribute,
                                   index = V(gramwet))[[next_step]]

    # Get attribute value for next position.
    attribute_value_next <-vertex_attr(gramwet,
                                       attribute,
                                       index = V(gramwet))[[(as.integer(
                                         next_step) + 1)]]

    # Decide next step based on prefering to eat a smaller creature.
    next_step_loop <- 0
    while (number_of_nodes >= next_step_loop)
    {
      # if (as.integer(attribute_value) >= as.integer(next_step))
      if (as.integer(attribute_value) > as.integer(attribute_value_next))
      {
        print("NOTE: Targeting a creature of lower biomass.")
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
    if (attribute_value == 0)
    {
      print("NOTE: Detected a creature with biomass of 0.")
      print("NOTE: Searching for nearest alternative.")
    }
    else if (as.integer(attribute_value) > as.integer(next_step))
    {
      print("NOTE: Consumed a creature of lower biomass.")
    }
    else if (as.integer(attribute_value) < as.integer(next_step))
    {
      print("NOTE: A creature of a lower biomass is not available.")
      print("NOTE: No logical path forward available.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
    }
    else if (loop_iteration >= igraph::vcount(gramwet))
    {
      print(paste("NOTE: Number of loops performed has reached the maximum",
                  "length of the network."))
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
    }
    else if (number_of_nodes <= 1)
    {
      print("NOTE: There are no creatures available for consumption.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
    }
    else
    {
      print(paste("NOTE: 'Umbrella::RandomJourneyFoodWeb()' has encountered",
                  "an unknown error."))
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
    }

    if (isFALSE(stuck))
    {
      print("NOTE: Taking another step through foodweb network.")
    }

    #########################################################
    # STAGE 3: APPEND CURRENT JOURNEY PATH TO PREVIOUS PATH #
    #########################################################

    path <- union(path, walk)
  }

  ##########################################
  # STAGE 4: COMPILE COMPLETE JOURNEY PATH #
  ##########################################

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

  ##############################################################################
  # PLOT RESULTS SECTION #######################################################
  ##############################################################################

  # Create graphical plot (old)
  print("TEST: Plotting random walk on 'foodwebs' data.")
  igraph::plot.igraph(
    path,
    main = 'Random Walk Graph / UmbrellaExperimentRandomJourney()',
    sub = paste("Umbrella", packageVersion("umbrella"))
  )

  # Create graphical plot (new)
  walk_plot <- GGally::ggnet2(path,
                              label = TRUE,
                              node.size = 9,
                              node.color = "pink",
                              edge.size = 1,
                              edge.color = "grey",
                              arrow.size = 8,
                              arrow.gap = 0.022,
                              mode = 'kamadakawai')
  print(walk_plot)

  ##############################################################################
  # RETURN DATA SECTION ########################################################
  ##############################################################################

  # Silently return the completed random journey path.
  invisible(path)

}

# End of File.