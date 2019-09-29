#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_random_walk_foodweb.R
# File Author: William Whinn

RandomWalkFoodweb <- function()
{
  data(foodwebs)

  # Create network object.
  gramwet <- foodwebs$gramwet

  # Prevent recursive relationships.
  simplify(gramwet)

  # Perform Random Walk.
  path <- igraph::random_walk(gramwet,
                              vcount(gramwet),
                              vcount(gramwet),
                              mode = 'all',
                              stuck = 'return')

  # Create igraph-compatible path.
  path <- graph_from_adj_list(path)

  path <- simplify(path)

  # Create clustered walktrap.
  clusters <- cluster_walktrap(path)

  plot(clusters, path,
       main = 'Random Walk / foodwebs$gramwet',
       sub = paste("Umbrella", packageVersion("umbrella")))
}

# End of File.
