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

## Dependencies

At present, these are the following packages which are required in order to use
`umbrella`:

- `rstudioapi`
- `ipgraph`
- `igraphdata`

## References

(To be written)
