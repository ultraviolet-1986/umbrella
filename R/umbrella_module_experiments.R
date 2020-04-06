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

  test_random_walk <- igraph::graph_from_adj_list(test_random_walk)
  test_random_walk <- simplify(test_random_walk)

  print("TEST: Plotting random walk on testing data.")
  igraph::plot.igraph(
    test_random_walk,
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

# End of File.
