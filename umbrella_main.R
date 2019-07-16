#!/usr/bin/env Rscript

# MSc Data Science (Full Time)
# PROM02 Computing Master's Project

# File Name: umbrella_main.R
# File Author: William Whinn

# INSTRUCTIONS
# - If using RStudio, open this file and click 'Source' to begin.
# - If not using RStudio, run from the directory of this file in the Terminal.

##############
# References #
##############

# https://tinyurl.com/yyme5ygu
# https://tinyurl.com/yy57glof
# https://tinyurl.com/zln59lc
# https://tinyurl.com/yxaqwcqf

#################
# Prerequisites #
#################

# Set current working directory according to file location.
tryCatch(
  {
    # Graphical Execution under RStudio.
    require('rstudioapi')
    print("NOTE: Package 'rstudioapi' has been attached.")
    setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
    print("SUCCESS: Operating under RStudio. Attempting graphical execution...")
  },
  error = function(e) {
    # Headless Execution under the Terminal (Script directory only).
    print("ERROR: Not operating under RStudio. Attempting headless execution...")
    detach('package:rstudioapi', unload = TRUE, character.only = TRUE)
    print("NOTE: Package 'rstudioapi' has been detached.")
  }
)

#################
# Local Modules #
#################

# Connect to local files relative to above working directory declaration.
source('module_apply_random_seed.R', chdir = TRUE)

#############
# Variables #
#############

#############
# Functions #
#############

#############
# Kickstart #
#############

ApplyRandomSeed()  # Comment to enforce specific seed.

# End of File.
