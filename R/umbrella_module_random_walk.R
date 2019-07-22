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
    print('NOTE: Proceeding with default pseudo-random seed.')
  }
  else
  {
    print('ERROR: An unknown error occurred.')
    return()
  }
}

# End of File.
