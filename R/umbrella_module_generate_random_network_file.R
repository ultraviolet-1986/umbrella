#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_generate_random_network_file..R
# File Author: William Whinn

GenerateRandomNetworkFile <- function() {
  # Define the 'umbrella_random_network.csv' file for writing.
  umbrella_random_network_file <- 'umbrella_random_network.csv'

  # Erase 'umbrella_random_network.csv' if exists to prepare for writing.
  if (file.exists(umbrella_random_network_file)) {
    file.remove(umbrella_random_network_file)
    print(paste('NOTE:', umbrella_random_network_file, 'has been deleted from the current working directory.'))
  }

  # Write exactly 100 lines of random numbers (between 1 and 100) to 'umbrella_random_network.csv'.
  for (i in 1:100 ) {
    write(
      paste(sample(1:100, 1, replace = TRUE), sample(1:100, 1, replace = TRUE), sep = ', '),
      file = umbrella_random_network_file,
      append = TRUE,
      sep = "\n"
    )

    i <- i + 1
  }

  print(paste('NOTE:', umbrella_random_network_file, 'has been written to the current working directory.'))
}

# End of File.
