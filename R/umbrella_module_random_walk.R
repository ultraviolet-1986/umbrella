#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_walk.R
# File Author: William Whinn

##############
# References #
##############

# https://www.stat.auckland.ac.nz/~ihaka/downloads/Waikato-WRUG.pdf
# https://stackoverflow.com/questions/49095518/more-efficient-way-to-run-a-random-walk-on-a-transition-matrix-than-the-igraph

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

  #####################################
  # Argument Parsing: number_of_steps #
  #####################################

  # - If this parameter has not been set, this value will be automatically set
  #   to the number of edges within the data set.

  if(missing(number_of_steps))
  {
    number_of_steps <- ecount(dataset)

    print("NOTE: Argument 'number_of_steps' has not been defined.")
    print(paste("NOTE: Automatically setting 'number_of_steps' to: '",
                number_of_steps, "'.", sep = ''))
  }

  #################################
  # Argument Parsing: random_seed #
  #################################

  # - If argument is empty, the function will execute with default pseudo-random
  #   seed.
  # - If argument is incorrect, the function will terminate.

  if (isTRUE(random_seed))
  {
    umbrella::ApplyRandomSeed()
  }
  else if (isFALSE(random_seed))
  {
    print(paste("NOTE: Argument 'random_seed' set to 'FALSE'. Proceeding with",
                "current pseudo-random seed."))
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

  # umbrella::AnalyseData(dataset)

  # igrahph method.
  # walk <- igraph::random_walk(
  #   dataset,
  #   start = start_node,
  #   steps = number_of_steps,
  #   mode = walk_mode,
  #   stuck = stuck_response)

  ####################
  # Random Walk Code #
  ####################

  n <- ecount(dataset)

  tm <- matrix(sample(0:1, n^2, prob = c(0.95, 0.05), replace = TRUE), n, n)
  tm <- (tm == 1 | t(tm) == 1) * 1
  diag(tm) <- 0

  # start <- 23
  start <- start_node # Random walk starting vertex
  # len <- 10 # Walk length
  # len <- ecount(karate)
  len <- number_of_steps

  path <- c(start, rep(NA, len))

  for(i in 2:(len + 1))
  {
    idx <- tm[path[i - 1], ] != 0

    if(any(idx))
    {
      path[i] <- resample(which(idx), 1, prob = tm[path[i - 1], idx])
    }
    else
    {
      break # Stopping if we get stuck
    }
  }

  path
  path <- igraph::graph_from_adj_list(path, mode = 'all', duplicate = FALSE)
  print(path)

  ###################
  # Additional Code #
  ###################

  # Plot results
  print("NOTE: Plotting random walk on data set.")
  plot(
    path,
    main = 'Random Walk Graph / RandomWalk()',
    sub = paste("Umbrella", packageVersion("umbrella")))
}

resample <- function(x, ...)
{
  x[sample.int(length(x), ...)]
}

# End of File.
