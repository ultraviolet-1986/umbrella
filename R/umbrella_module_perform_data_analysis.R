#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_module_perform_data_analysis..R
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
  else
  {
    # Success: Data have been provided. Perform analysis.
  }
}
