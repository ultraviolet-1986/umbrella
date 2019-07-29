#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_perform_data_analysis.R
# File Author: William Whinn

##############
# References #
##############

# - https://tinyurl.com/yycfo2zh

#############
# Functions #
#############

PerformDataAnalysis <- function(dataset)
{
  if (missing(dataset))
  {
    # Failure: Data have not been provided. Terminate analysis.
    print(paste("ERROR: Argument 'dataset' has not been defined. Terminating",
                "Data Analysis."))
    return()
  }
  else if (typeof(dataset) == 'list')
  {
    # Success: Data exists and is in the correct format.
    print("NOTE: Data is of type 'List'. Performing Data Analysis.")
  }
  else
  {
    # Failure: Catch unknown error.
    print("ERROR: An unknown error occurred. Terminating Data Analysis.")
    return()
  }
}
