# Umbrella

A Biased Generic Random Walk Algorithm for Community Detection written in R

## Introduction

Umbrella is a package for R and RStudio, which aims to provide a means of
obtaining accurate results for community detection tasks by applying a generic
random walk algorithm onto a multitude of fields, regardless of subject.

## Installation Instructions

It is possible to install this package using the following commands in R or
RStudio:

### GitHub Method (Not yet tested)

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

- **`AnalyseData()`** / **`umbrella::AnalyseData()`**
  - This function will analyse a given data set and generate useful statistics
    regarding a data set.
  - The analysis results will be returned as a list object which may then be
    queried and utilised.
  - If the given dataset is of an unknown type or derived from another network
    library, this function will convert it to `igraph` format.
    - Use `help(AnalyseData)`for more information.

- **`ApplyRandomSeed()`** / **`umbrella::ApplyRandomSeed()`**
  - This function will erase the current seed for generating pseudo-random
    numbers (if any are already applied) and will select a new one from between
    `1` and `1,000,000`.
  - Use `help(ApplyRandomSeed)`for more information.

- **`GenerateRandomNetwork()`** / **`umbrella::GenerateRandomNetwork()`**
  - This function will optionally write a comma-separated file named
    `umbrella_random_network.csv` within the current working directory. If this
    file exists, it will be removed and re-written.
  - It is possible to convert these data to a matrix for outputting a graphical
    network.
  - Use `help(GenerateRandomNetwork)`for more information.

- **`RandomJourney()`** / **`umbrella::RandomJourney()`**
  - This function will perform a series of connected random walks that will
    pass their 'state' from one iteration to another until the network has
    been fully explored.
  - The intention was to make this universal, however, the principles behind
    this algorithm may be 'tweaked' to create a random journey specific to the
    connected field.
  - Random Journey operates by applying decision-making to the random walk
    process and allowing more intelligent network navigation.
  - Use `help(RandomJourney)`for more information.

- **`RandomJourneyFoodweb()`** / **`umbrella::RandomJourneyFoodweb()`**
  - As `RandomJourney()` except it has been tuned for use with `igraphdata` and
    the `foodwebs$gramwet` sub-network specifically.
  - Use `help(RandomJourneyFoodweb)`for more information.

- **`RandomWalk()`** / **`umbrella::RandomWalk()`**
  - This function will attempt to perform and plot a random walk using a
    specified data set.
  - Use `help(RandomWalk)` for more information.

## Dependencies

At present, these are the following packages which are required in order to use
`umbrella`:

- `GGally`
- `ipgraph`
- `igraphdata`
- `rstudioapi`

## References and Resources

- [Link](REFERENCES.md)
