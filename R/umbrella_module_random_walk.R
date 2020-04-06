#!/usr/bin/env Rscript

##########
# Notice #
##########

# Umbrella: A Biased Generic Random Walk Algorithm for Community Detection
# Copyright (C) 2020 William Willis Whinn

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

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
# - ontology
# - start_node
# - walk_length
# - random_seed (TRUE, FALSE)
# - walk_mode ('in', 'out', 'all')
# - stuck_response ('return', 'error')

#############
# Functions #
#############

RandomWalk <- function(
  dataset,
  ontology,
  start_node,
  walk_length,
  random_seed = c(TRUE, FALSE),
  walk_mode = c('in', 'out', 'all'),
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

  ##############################
  # Argument Parsing: ontology #
  ##############################

  # - An 'ontology' can be passed to this function, and if so, Umbrella will
  #   perform a 'biased' random walk on the data.
  # - Umbrella will call the 'AnalyseData()' function twice: once on the
  #   'dataset' and once for the 'ontology'. The result of this 'biasing' will
  #   be walked.

  # if (exists(ontology))
  # {
  #   print(paste("NOTE: An ontology has been passed. The random walk will be",
  #               "biased."))
  #
  #   dataset <- umbrella::AnalyseData(dataset)
  #
  #   # TODO: Use ontology here, the random walk will account for this when it is
  #   #       implemented.
  # }
  # else if (missing(ontology))
  # {
  #   print(paste("NOTE: An ontology has not been passed. The random walk will",
  #               "not be biased."))
  # }
  # else
  # {
  #   print(paste("ERROR: An unknown error occurred."))
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

  #####################################
  # Argument Parsing: walk_length #
  #####################################

  # - If this parameter has not been set, this value will be automatically set
  #   to approximately 50% of the number of vertices (nodes) within the data
  #   set.

  if(missing(walk_length))
  {
    walk_length <- round(vcount(dataset) / 2)

    print("NOTE: Argument 'walk_length' has not been defined.")
    print(paste("NOTE: Automatically setting number of steps to ", walk_length,
                ".", sep = ''))
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

  # igrahph method.
  # walk <- igraph::random_walk(
  #   dataset,
  #   start = start_node,
  #   steps = walk_length,
  #   mode = walk_mode,
  #   stuck = stuck_response)

  ####################
  # Random Walk Code #
  ####################

  n <- vcount(dataset)

  tm <- matrix(sample(0:1, n^2, prob = c(0.95, 0.05), replace = TRUE), n, n)
  tm <- (tm == 1 | t(tm) == 1) * 1
  diag(tm) <- 0

  # start <- 23
  start <- start_node
  len <- walk_length

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

  invisible(path)
}

resample <- function(x, ...)
{
  x[sample.int(length(x), ...)]
}

# End of File.
