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

# Function: random_walk
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

random_walk <- function(dataset = 'placeholder',  # To be removed for production.
                       start_node,
                       steps,
                       random_seed = c(TRUE, FALSE),
                       mode = c('in', 'out', 'all'),
                       stuck = c('stop_walk', 'raise_error')
){
  #############################
  # Argument Parsing: dataset #
  #############################

  # - This will fail in production if data are not applied.
  # - A placeholder is currently present to allow execution of other logic.

  # if(missing(dataset))
  # {
  #   print(paste("ERROR: Argument 'dataset' has not been defined. Terminating",
  #               "Random Walk."))
  #   return()
  # }

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

  if(missing(steps))
  {
    print(paste("ERROR: Argument 'steps' has not been defined. Terminating",
                "Random Walk."))
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

  # - If this argument is not defined, 'random_walk' will execute using 'all'
  #   mode.
  # - If argument is incorrect, the function will terminate.

  if (missing(mode))
  {
    print("NOTE: Argument 'mode' not specified. Proceeding under 'all' mode.")
    mode <- 'all'
  }
  else if (mode == 'in')
  {
    print("NOTE: Random Walk will be executed under 'in' mode.")
  }
  else if (mode == 'out')
  {
    print("NOTE: Random Walk will be executed under 'out' mode.")
  }
  else if (mode == 'all')
  {
    print("NOTE: Random Walk will be executed under 'all' mode.")
  }
  else
  {
    print(paste("ERROR: Argument 'mode' has not been defined. Terminating",
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

  if (missing(stuck))
  {
    print(paste("ERROR: Argument 'stuck' has not been defined. Terminating",
                "Random Walk."))
    return()
  }

  #########################
  # Kickstart Random Walk #
  #########################
}

# End of File.
