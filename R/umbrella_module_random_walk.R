#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_walk..R
# File Author: William Whinn

##############
# References #
##############

# https://www.stat.auckland.ac.nz/~ihaka/downloads/Waikato-WRUG.pdf

#################
# Documentation #
#################

# NOTE: Current implementation will be based on logic from 'igraph' 'random_walk()' C++ code.

# Function: RandomWalk
# Parameters:
# - data
# - start_node
# - steps
# - random_seed ('TRUE', 'FALSE')
# - mode ('in', 'out', 'all')
# - stuck ('stop_walk', 'raise_error')

#############
# Variables #
#############

#############
# Functions #
#############

RandomWalk <- function(
  dataset,
  start_node,
  steps,
  random_seed = c(TRUE, FALSE),
  mode = c('in', 'out', 'all'),
  stuck = c('stop_walk', 'raise_error')
) {
  print('') # Placeholder
}

#############
# Kickstart #
#############

# End of File.
