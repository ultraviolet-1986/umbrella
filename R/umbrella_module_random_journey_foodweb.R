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
  #################
  # Prerequisites #
  #################

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

  # Create an empty list to hold list of nodes visited during RandomJourney().
  node_name_list <- ''

  ##########################
  # Random Journey Section #
  ##########################

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

  # Select walk mode: 'in', 'out', or 'all'. Default: 'all'.
  walk_mode <- 'all'

  while (isFALSE(stuck))
  {
    # Increment the number of loops performed.
    loop_iteration <- loop_iteration + 1

    ############################################################################
    # Stage 1: Walk from one node to another ###################################
    ############################################################################

    # Take the values from the previous iteration and pass them to the first
    # step of this iteration of the journey.
    walk <- random_walk(gramwet, start = previous_state, steps = 2,
                        stuck = 'return', mode = walk_mode)

    # Choose the previously-visited node as the starting position for next step.
    next_step <- tail(as.integer(walk), n = 1)

    ############################################################################
    # Stage 2: Assess surroundings / Decision-making ###########################
    ############################################################################

    # Check if possible to continue, break if number of nodes connected to this
    # iteration is equal to, or less than 1.

    # Detect neigbouring nodes for the journey.
    nodes_available <- igraph::neighbors(gramwet, next_step, mode = walk_mode)

    number_of_nodes <- length(igraph::neighbors(gramwet,
                                                next_step,
                                                mode = walk_mode))

    #############################################
    # Access 'Biomass' attribute for comparison #
    #############################################

    # Get attribute value for current position.
    biomass_current <- vertex_attr(gramwet, attribute, index = V(
      gramwet))[[next_step]]

    # Get attribute value for next position.
    biomass_next <-vertex_attr(gramwet, attribute, index = V(
      gramwet))[[(as.integer(next_step) + 1)]]

    ############################################
    # Access 'weight' attribute for comparison #
    ############################################

    # Get 'weight' value for current position and cast as double.
    weight_current <- edge_attr(gramwet, 'weight', index = V(
      gramwet))[[next_step]]
    weight_current <- as.double(weight_current)

    # Get 'weight' value for next position and cast as double.
    weight_next <- edge_attr(gramwet, 'weight', index = V(
      gramwet))[[(as.integer(next_step) + 1)]]
    weight_next <- as.double(weight_next)

    ##########################################
    # Create difference value for comparison #
    ##########################################

    difference_current <- as.double(biomass_current) -
      as.double(weight_current)

    difference_next <- as.double(biomass_next) -
      as.double(weight_next)

    ##############################
    # Access node names for list #
    ##############################

    # Get the node name for the current vertex.
    node_name_current <- vertex_attr(gramwet, 'name',
                                     index = V(gramwet))[[
                                       as.double(next_step)]]

    # Get the node name for the next vertex.
    node_name_next <- vertex_attr(gramwet, 'name',
                                  index = V(gramwet))[[(
                                    as.double(next_step) + 1)]]

    # Compile list of node names.
    node_name_list_current <- union(node_name_current, node_name_next)
    node_name_list <- union(node_name_list, node_name_list_current)

    #############################
    # Print current information #
    #############################

    # Current node data.
    print(paste(node_name_current))
    print(paste("Biomass:", biomass_current))
    print(paste("Weight:", weight_current))
    print(paste("Difference:", difference_current))

    # Next node data.
    print(paste(node_name_next))
    print(paste("Biomass:", biomass_next))
    print(paste("Weight:", weight_next))
    print(paste("Difference:", difference_next))

    ##############################
    # Decision-making logic tree #
    ##############################

    # Decide next step based on prefering to eat a smaller creature.
    next_step_loop <- 0
    while (number_of_nodes >= next_step_loop)
    {
      if (as.double(biomass_current) > as.double(biomass_next))
      {
        # print("NOTE: Targeting a creature of lower biomass.")
        print(paste(node_name_current, "is being targeted by", node_name_next))
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
    if (biomass_current == 0)
    {
      print("NOTE: Detected a creature with biomass of 0.")
      print("NOTE: Searching for nearest alternative.")
    }

    ##########################
    # Target selection logic #
    ##########################

    else if (weight_current > weight_next)
    {
      print("NOTE: Current weight greater than next.")
    }
    else if(weight_current < weight_next)
    {
      print("NOTE: Current weight less than next.")
    }

    # Current node's Biomass is greater than the next.
    else if (as.double(biomass_current) >
             as.double(biomass_next))
    {
      print(paste(node_name_current, "has been consumed by", node_name_next))
    }

    # Current node's Biomass is smaller than the next.
    else if (as.double(biomass_current) <
             as.double(biomass_next))
    {
      print("NOTE: A creature of a lower biomass is not available.")
      print("NOTE: No logical path forward available.")
      print("NOTE: Terminating Random Journey.")
      stuck <- TRUE
    }

    #####################
    # Loop-ending logic #
    #####################

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

    ############################################################################
    # Stage 3: Append current Journey path to previous path ####################
    ############################################################################

    path <- union(path, walk)
  }

  ##############################################################################
  # Stage 4: Compile complete Journey path #####################################
  ##############################################################################

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

  # Trim the initial (empty) step.
  node_name_list <- node_name_list[-1]

  # Print names of nodes visited.
  print(paste("NOTE: Printing list of nodes visited during RandomJourney()."))
  print(cat(node_name_list, sep = '\n'))

  ################
  # Plot results #
  ################

  print("TEST: Plotting random walk on 'foodwebs' data. Please Wait.")

  # Create graphical plot using 'ggnet2'.
  walk_plot <- GGally::ggnet2(path,
                              label = TRUE,
                              node.size = 9,
                              node.color = "pink",
                              edge.size = 1,
                              edge.color = "grey",
                              arrow.size = 8,
                              arrow.gap = 0.022,
                              mode = 'kamadakawai')

  # Output the new plot graphically ('ggnet2' will not do this automatically).
  print(walk_plot)

  ###############
  # Return Data #
  ###############

  # Silently return the completed random journey path.
  invisible(path)

}

# End of File.
