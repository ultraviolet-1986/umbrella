#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_experiments.R
# File Author: William Whinn

##############
# References #
##############

# https://cran.r-project.org/web/packages/diffusr/vignettes/diffusr.html
# https://stats.stackexchange.com/questions/26722/calculate-transition-matrix-markov-in-r

###################################
# Experiment 1: Probe Random Data #
###################################

# NOTES:
# - This function was written to test 'umbrella' under Linux.
#   - MS Windows may not function correctly due to differing file structure.
# - No data will be exported to the current R session unless assigned by user.

# WARNING:
# - This function writes a file to the user's "$HOME" directory.

UmbrellaExperimentProbeRandomData <- function()
{
  print("########## EXPERIMEMT ##########")

  setwd("~/")
  test_data <- umbrella::GenerateRandomNetwork(to_file = TRUE)

  # Analyse dataset and create analysis payload.
  test_data <- umbrella::AnalyseData(test_data, draw_graph = TRUE)

  # Perform Random Walk on data from Random Network File.
  print("TEST: Performing random walk on testing data.")

  test_random_walk <-
    igraph::random_walk(
      test_data$dataset,
      start = 1,
      steps = 10,
      mode = 'all'
    )

  print(test_random_walk)

  # Create and output an adjacency edge list of 'test_data'.
  print("TEST: Output an adjacency edge list of the network data.")
  print(igraph::as_adj_edge_list(test_data$dataset))

  print("TEST: Plotting random walk on testing data.")
  igraph::plot.igraph(
    igraph::graph_from_adj_list(test_random_walk),
    main = 'Random Walk Graph / UmbrellaExperimentProbeRandomData()',
    sub = paste("Umbrella", packageVersion("umbrella"))
  )

  ###############
  # Return Data #
  ###############

  # NOTES:
  # - Return data quietly.
  # - This allows assignment to variable.

  print("TEST: Return data as graph object.")
  print(test_data)
  invisible(test_data)
}

########################################
# Experiment 2: Random Journey Example #
########################################

UmbrellaExperimentRandomJourney <- function ()
{
  print("########## EXPERIMEMT ##########")

  print(paste("TEST: Loading the 'foodwebs' dataset from package ",
              "'igraphdata'."))
  data("foodwebs")

  # Perform the Random Journey on the 'foodwebs' dataset.
  walk_data <- umbrella::RandomJourney(foodwebs[['ChesMiddle']])

  print(walk_data)

  print("TEST: Plotting random walk on 'foodwebs' data.")
  igraph::plot.igraph(
    igraph::graph_from_adj_list(walk_data),
    main = 'Random Walk Graph / UmbrellaExperimentRandomJourney()',
    sub = paste("Umbrella", packageVersion("umbrella"))
  )

  # Silently return the path.
  invisible(walk_data)
}

# End of File.
