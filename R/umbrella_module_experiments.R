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

########################################
# Experiment 2: Random Journey Example #
########################################

UmbrellaExperimentRandomJourney <- function ()
{
  print("########## EXPERIMEMT ##########")

  print(paste("TEST: Loading the 'foodwebs' dataset from package ",
              "'igraphdata'."))
  data("foodwebs")

  # Assign network to variable.
  gramwet <- foodwebs$gramwet

  # Purge self-loops.
  gramwet <- simplify(gramwet)

  print(paste("TEST: Perform the Random Journey on the 'foodweb' data."))
  walk_data <- umbrella::RandomJourney(gramwet)

  # Convert path to numerical vector for processing.
  # walk_data <- as.integer(as.vector(walk_data))

  # print(paste("TEST: Printing the Random Journey's path."))
  # print(walk_data)

  # print(paste("TEST: Printing name list of Random Journey's path."))
  # for (i in walk_data)
  # {
  #   # print(names(gramwet[[i]]))
  #   print(vertex_attr(foodwebs$gramwet, 'name', index = V(foodwebs$gramwet))[[i]])
  # }

  print("TEST: Plotting random walk on 'foodwebs' data.")
  igraph::plot.igraph(
    walk_data,
    main = 'Random Walk Graph / UmbrellaExperimentRandomJourney()',
    sub = paste("Umbrella", packageVersion("umbrella"))
  )

  # Requires package 'GGally' for the 'ggnet2' function.
  walk_plot <- GGally::ggnet2(walk_data, label = TRUE, node.size = 9,
                              node.color = "pink", edge.size = 1,
                              edge.color = "grey", arrow.size = 8,
                              arrow.gap = 0.022, mode = 'kamadakawai')
  print(walk_plot)

  ###############
  # Return Data #
  ###############

  # NOTES:
  # - Return data quietly.
  # - This allows assignment to variable.

  invisible(walk_data)
}

# End of File.
