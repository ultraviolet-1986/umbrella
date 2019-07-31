#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_generate_random_network_file..R
# File Author: William Whinn

#############
# Functions #
#############

GenerateRandomNetworkFile <- function(edges = 20, vertices = 20) {
  # Define the 'umbrella_random_network.csv' file for writing.
  umbrella_random_network_file <- 'umbrella_random_network.csv'

  # Erase 'umbrella_random_network.csv' if exists to prepare for writing.
  if (file.exists(umbrella_random_network_file)) {
    file.remove(umbrella_random_network_file)
    print(paste('NOTE:', umbrella_random_network_file, 'has been deleted from',
                'the current working directory.'))
  }

  # Write 'umbrella_random_network.csv' with parameters outlines by the user, or
  # create a file with 20 edges and 20 vertices by default.

  # Create a placeholder for randomly-generated numbers within this scope.
  numbers <- c(NULL, NULL)

  for (i in 1:vertices) {
    # Generate a pair of random numbers.
    numbers <- c(sample(1:edges, 1), sample(1:edges, 1))

    # If row numbers are identical, generate again until they are different.
    while (numbers[1] == numbers[2])
    {
      print("NOTE: Row is identical. Iterating.")
      numbers <- c(sample(1:edges, 1), sample(1:edges, 1))
    }

    # Once numbers are unique to their row, write them to the file.
    write(
      paste(numbers[1],
            numbers[2],
            sep = ', '),
      file = umbrella_random_network_file,
      append = TRUE,
      sep = "\n"
    )

    # Increment the loop counter by one.
    i <- i + 1
  }

  print(paste('NOTE:', umbrella_random_network_file, 'has been written to the',
              'current working directory.'))
}

# End of File.
