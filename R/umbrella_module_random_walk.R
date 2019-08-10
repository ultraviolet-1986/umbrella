#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_walk.R
# File Author: William Whinn

##############
# References #
##############

# https://www.stat.auckland.ac.nz/~ihaka/downloads/Waikato-WRUG.pdf

#################
# Documentation #
#################

# NOTES:
# - Current implementation will be based on logic from 'igraph' 'random_walk()'
#   C++ code.
# - Code has been formatted to demonstrate a C-style development process.

# Function: RandomWalk
# Parameters:
# - dataset
# - start_node
# - steps
# - random_seed ('TRUE', 'FALSE')
# - mode ('in', 'out', 'all')
# - stuck ('stop_walk', 'raise_error')

#############
# Functions #
#############

RandomWalk <- function(
  dataset,
  start_node,
  number_of_steps,
  random_seed = c(TRUE, FALSE),
  walk_mode = c('in', 'out', 'all'),
  # stuck = c('stop_walk', 'raise_error')
  stuck_response = c('return', 'error')
){
  #############################
  # Argument Parsing: dataset #
  #############################

  if(missing(dataset))
  {
    print(paste("ERROR: Argument 'dataset' has not been defined. Terminating",
                "Random Walk."))
    return()
  }

  ################################
  # Argument Parsing: start_node #
  ################################

  # - This is a required parameter, failing to specify will terminate the
  #   program.

  if (missing(start_node))
  {
    print(paste("ERROR: Argument 'start_node' has not been defined.",
                "Terminating Random Walk."))
    return()
  }

  ###########################
  # Argument Parsing: steps #
  ###########################

  # - This is a required parameter, failing to specify will terminate the
  #   program.

  if(missing(number_of_steps))
  {
    print(paste("ERROR: Argument 'number_of_steps' has not been defined. ",
                "Terminating Random Walk."))
    return()
  }

  #################################
  # Argument Parsing: random_seed #
  #################################

  # - If argument is empty, the function will execute with default pseudo-random
  #   seed.
  # - If argument is incorrect, the function will terminate.

  if (isTRUE(random_seed))
  {
    print('NOTE: Applying a unique psuedo-random seed.')
    ApplyRandomSeed()
  }
  else if (isFALSE(random_seed))
  {
    print('NOTE: Proceeding with current pseudo-random seed.')
  }
  else if (missing(random_seed))
  {
    print(paste("NOTE: Argument 'random_seed' not specified. Proceeding with",
                "current pseudo-random seed."))
  }
  else
  {
    print(paste("ERROR: Argument 'random_seed' has not been defined.",
                "Terminating Random Walk."))
    return()
  }

  ##########################
  # Argument Parsing: mode #
  ##########################

  # - If this argument is not defined, 'RandomWalk' will execute using 'all'
  #   mode.
  # - If argument is incorrect, the function will terminate.

  if (missing(walk_mode))
  {
    print(paste("NOTE: Argument 'walk_mode' not specified. Proceeding under ",
                "'all' mode."))
    walk_mode <- 'all'
  }
  else if (walk_mode == 'in')
  {
    print("NOTE: Random Walk will be executed under 'in' mode.")
  }
  else if (walk_mode == 'out')
  {
    print("NOTE: Random Walk will be executed under 'out' mode.")
  }
  else if (walk_mode == 'all')
  {
    print("NOTE: Random Walk will be executed under 'all' mode.")
  }
  else
  {
    print(paste("ERROR: Argument 'walk_mode' has not been defined. Terminating",
                "Random Walk."))
    return()
  }

  ###########################
  # Argument Parsing: stuck #
  ###########################

  # - Depending on condition, the program will either attempt to return or hard
  #   terminate when a 'stuck' state is reached.
  # - This is a required parameter, failing to specify will terminate the
  #   program.

  if (missing(stuck_response))
  {
    print(paste("ERROR: Argument 'stuck' has not been defined. Terminating",
                "Random Walk."))
    return()
  }

  #########################
  # Kickstart Random Walk #
  #########################

  auto_number_of_steps <- ecount(dataset)

  # igrahph method.
  igraph::random_walk(
    dataset,
    start = start_node,
    # steps = number_of_steps,
    steps = auto_number_of_steps,
    mode = walk_mode)
}

# End of File.
