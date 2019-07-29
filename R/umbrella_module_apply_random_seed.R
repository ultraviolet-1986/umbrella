#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_apply_random_seed.R
# File Author: William Whinn

#############
# Functions #
#############

ApplyRandomSeed <- function() {
  if (exists('.Random.seed')) {
    # Delete the current seed (if exists).
    rm(.Random.seed, envir = globalenv())
  }

  # Choose a random number and use it as a random seed.
  random_seed <- sample(1:1e6, 1, replace = FALSE)
  set.seed(random_seed)

  # Print chosen seed
  print(paste('NOTE: Random seed', random_seed, "has been applied."))
}

# End of File.
