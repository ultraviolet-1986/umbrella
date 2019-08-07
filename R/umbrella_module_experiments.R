#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_experiments.R
# File Author: William Whinn

################
# Experiment 1 #
################

# NOTES:
# - This function was written to test 'umbrella' under Linux.
#   - MS Windows may not function correctly due to differing file structure.
# - No data will be exported to the current R session unless assigned by user.

# WARNING:
# - This function writes a file to the user's "$HOME" directory.

UmbrellaExperimentConversion <- function()
{
  print("########## EXPERIMEMT ##########")

  setwd("~/")
  umbrella::GenerateRandomNetworkFile(nodes = 10, rows = 10)
  test_data <- read.csv('umbrella_random_network.csv')
  umbrella::AnalyseData(test_data, draw_graph = TRUE)

  # Convert 'test_data' into a graph object.
  print("TEST: Convert comma-separated data into graph object.")
  test_data <- igraph::graph_from_adj_list(test_data, mode = 'all',
                                           duplicate = FALSE)

  # Convert 'test_data' into adjacency matrix.
  print("TEST: Convert data into adjacency matrix.")
  test_data <- igraph::as_adjacency_matrix(test_data, type = 'both')
  print("TEST: Outputting data as adjacency matrix.")
  print(test_data)

  # Convert 'test_data' back into original format.
  print("TEST: Convert data back into graph object.")
  test_data <- igraph::graph_from_adjacency_matrix(test_data)

  # Perform Random Walk on Random Network File.
  print("TEST: Performing random walk on testing data.")

  test_random_walk <- igraph::random_walk(test_data, start = 1, steps = 10,
                                          mode = 'all')
  print(test_random_walk)

  # Create and output an adjacency edge list of 'test_data'.
  print("TEST: Output an adjacency edge list of the network data.")
  print(as_adj_edge_list(test_data))

  print("TEST: Plotting random walk on testing data.")
  igraph::plot.igraph(igraph::graph_from_adj_list(test_random_walk),
                      main = 'Random Walk Graph / UmbrellaExperimentConversion()',
                      sub = paste("Umbrella", packageVersion("umbrella")))

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

# End of File.
