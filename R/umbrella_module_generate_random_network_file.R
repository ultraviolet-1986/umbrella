#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_generate_random_network_file..R
# File Author: William Whinn

#############
# Functions #
#############

generate_random_network_file <- function(nodes = 20, rows = 20) {
  # Define the 'umbrella_random_network.csv' file for writing.
  umbrella_random_network_file <- 'umbrella_random_network.csv'

  # Erase 'umbrella_random_network.csv' if exists to prepare for writing.
  if (file.exists(umbrella_random_network_file)) {
    file.remove(umbrella_random_network_file)
    print(paste("NOTE: '", umbrella_random_network_file, "' has been deleted ",
                "from the current working directory.", sep = ''))
  }

  # Write 'umbrella_random_network.csv' with parameters outlines by the user, or
  # create a file with 20 edges and 20 rows by default.

  for (i in 1:rows) {
    # Generate a pair of random numbers.
    numbers <- c(sample(1:nodes, 1), sample(1:nodes, 1))

    # If row numbers are identical, generate again until they are different.
    while (numbers[1] == numbers[2])
    {
      numbers <- c(sample(1:nodes, 1), sample(1:nodes, 1))
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
  print(paste("NOTE: '", umbrella_random_network_file, "' has been written to ",
              "current working directory.", sep = ''))
}

# End of File.
