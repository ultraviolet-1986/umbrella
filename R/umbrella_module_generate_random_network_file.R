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

GenerateRandomNetwork <- function(nodes = 25, to_file = c(TRUE, FALSE))
{
  # Prevent re-writing the file name.
  umbrella_random_network_file <- 'umbrella_random_network.txt'

  # Create an 'Edros Renyi' graph to export as both data and a text file.
  umbrella_random_network <- igraph::erdos.renyi.game(nodes, .33)

  # Export the data as a text file within the user's current working directory
  # and overwrite any existing data.
  if(isTRUE(to_file))
  {
    if(file.exists(umbrella_random_network_file))
    {
      print(paste("NOTE: Existing network file detected and will be",
                  "overwritten."))
    }

    # Output data to text file within current working directory.
    igraph::write_graph(umbrella_random_network,
                        file = umbrella_random_network_file,
                        format = 'edgelist')

    print(paste("NOTE: Random network file '", umbrella_random_network_file,
                "' has been written", sep = ''))
  }

  # Return the dataset quietly.
  invisible(umbrella_random_network)
}

# End of File.
