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

#############
# Functions #
#############

RandomWalkFoodweb <- function()
{
  data("foodwebs")

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
