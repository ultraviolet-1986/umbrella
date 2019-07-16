#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_apply_random_seed.R
# File Author: William Whinn

ApplyRandomSeed <- function() {
  if (exists('.Random.seed')) {
    # Delete the current seed (if exists).
    rm(.Random.seed, envir = globalenv()) 
  }
  
  # Choose a random number and use it as a random seed.
  random_seed <- c(sample(1:1e6, 1, replace = FALSE))
  set.seed(random_seed)
  
  # Vector should contain different numbers every time.
  print('NOTE: Verify Random Seed with Sample Vector')
  print(c(sample(1:100, 10, replace = FALSE)))
}

# End of File.
