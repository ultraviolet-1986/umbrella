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
  ###################
  # Data Validation #
  ###################

  if (missing(dataset))
  {
    # FAILURE: Data have not been provided. Terminate analysis.
    print(paste("ERROR: Argument 'dataset' has not been defined. Terminating",
                "Data Analysis."))
    return()
  }
  else if (typeof(dataset) == 'list')
  {
    # SUCCESS: Data exists and is in the correct format.
    print("NOTE: Data is of type 'List'. Performing Data Analysis.")

    # NOTES:
    # - Continue outside of IF statement.
    # - Error conditions will terminate data analysis.
  }
  else
  {
    # FAILURE: Catch unknown error.
    print("ERROR: An unknown error occurred. Terminating Data Analysis.")
    return()
  }

  #################
  # Data Analysis #
  #################

  print("NOTE: Validation Complete. Listing results.")
}
