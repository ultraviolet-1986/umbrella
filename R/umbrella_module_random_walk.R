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
# - Current implementation will be based on logic from 'igraph' 'random_walk()' C++ code.
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

RandomWalk <- function(dataset = 'placeholder',  # This will be removed for production.
                       start_node,
                       steps,
                       random_seed = c(TRUE, FALSE),
                       mode = c('in', 'out', 'all'),
                       stuck = c('stop_walk', 'raise_error')
){
  # Argument Parsing: dataset
  # - This will fail in production if data are not applied.
  # - A placeholder is currently present to allow execution of other logic.

  # Argument Parsing: random_seed
  # - If argument is empty, the function will execute with default pseudo-random seed.
  # - If argument is incorrect, the function will terminate.
  if (isTRUE(random_seed))
  {
    print('NOTE: Applying a unique psuedo-random seed.')
    ApplyRandomSeed()
  }
  else if (isFALSE(random_seed))
  {
    print('NOTE: Proceeding with default pseudo-random seed.')
  }
  else if (missing(random_seed))
  {
    print("NOTE: Argument 'random_seed' not specified. Proceeding with default pseudo-random seed.")
  }
  else
  {
    print("ERROR: Argument 'random_seed' has not been defined correctly. Terminating Random Walk.")
    return()
  }

  # Argument Parsing: mode
  # - If this argument is not defined, 'RandomWalk' will execute using 'all' mode.
  # - If argument is incorrect, the function will terminate.
  if (missing(mode))
  {
    print("NOTE: Argument 'mode' not specified. Proceeding under 'all' mode.")
    mode <- 'all'
  }
  else if (mode == 'in')
  {
    print("NOTE: Random Walk will be executed using 'in' mode.")
  }
  else if (mode == 'out')
  {
    print("NOTE: Random Walk will be executed using 'out' mode.")
  }
  else if (mode == 'all')
  {
    print("NOTE: Random Walk will be executed using 'all' mode.")
  }
  else
  {
    print("ERROR: Argument 'mode' has not been defined correctly. Terminating Random Walk.")
    return()
  }
}

# End of File.
