# Umbrella

A Biased Generic Random Walk Algorithm for Community Detection written in R

## Introduction

Umbrella is a package for R and RStudio, which aims to provide a means of
obtaining accurate results for community detection tasks by applying a generic
random walk algorithm onto a multitude of fields, regardless of subject.

## Installation Instructions

It is possible to install this package using the following commands in R or
RStudio:

### GitHub Method

```R
  install.packages('devtools', dependencies = TRUE)
  library('devtools')
  install_github("ultraviolet-1986/umbrella")
```

### CRAN Repository Method (Not yet implemented)

```R
  install.packages('umbrella', dependencies = TRUE)
```

## Functions

Once this package has been installed, it can be loaded using:

```R
  library('umbrella')
```

Once the package has been installed and loaded, the following functions become
available:

- **`ApplyRandomSeed()`** / **`umbrella::ApplyRandomSeed()`**
  - This function will erase the current seed for generating pseudo-random
    numbers (if any are already applied) and will select a new one from between
    `1` and `1,000,000`.
  - Use `help(ApplyRandomSeed)`for more information.

- **`GenerateRandomNetworkFile()`** /
  **`umbrella::GenerateRandomNetworkFile()`**
  - This function will write a comma-separated file named
    `umbrella_random_network.csv` within the current working directory. If this
    file exists, it will be removed and re-written.
  - It is possible to convert these data to a matrix for outputting a graphical
    network.
  - Use `help(GenerateRandomNetworkFile)`for more information.
    
- **`RandomWalk()`** / **`umbrella::RandomWalk()`**
  - This function will attempt to perform and plot a random walk using a
    specified data set.
  - Use `help(RandomWalk)` for more information.

## Dependencies

At present, these are the following packages which are required in order to use
`umbrella`:

- `rstudioapi`
- `ipgraph`

## Suggestions

Although not required to perform any task using `umbrella`, these data were used
and tested throughout.

- `igraphdata`

## References

(To be written)
