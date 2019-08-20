#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_generate_random_network_file..R
# File Author: William Whinn

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
