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

- <http://geneontology.org/>
- <http://konect.cc/networks/ucidata-zachary/>
- <http://konect.uni-koblenz.de/networks/opsahl-powergrid>
- <http://networksciencebook.com/>
- <http://robot.obolibrary.org/>
- <http://vlado.fmf.uni-lj.si/pub/networks/data/bio/foodweb/foodweb.htm>
- <http://www.mtholyoke.edu/~tchumley/s395/Networks_Ch3.html>
- <http://www.obofoundry.org/ontology/wbphenotype.html>
- <http://www.shizukalab.com/toolkits/sna/sna_data>
- <http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata>
- <https://3uzly11fn22f2ax25l6snwb1-wpengine.netdna-ssl.com/wp-content/uploads/map-of-internet.png>
- <https://archive.ics.uci.edu/ml/index.php>
- <https://arxiv.org/pdf/1712.06468.pdf>
- <https://bioportal.bioontology.org/ontologies/ECSO/?p=summary>
- <https://bookdown.org/ndphillips/YaRrr/dataframe-column-names.html>
- <https://briatte.github.io/ggnet/>
- <https://ci.mines-stetienne.fr/seas/ElectricPowerSystemOntology>
- <https://cran.r-project.org/mirrors.html>
- <https://cran.r-project.org/web/packages/data.tree/vignettes/data.tree.html>
- <https://cran.r-project.org/web/packages/diffusr/vignettes/diffusr.html>
- <https://github.com/datacamp/authoring/issues/52>
- <https://github.com/dkaslovsky/Coupled-Biased-Random-Walks>
- <https://github.com/igraph/igraph/blob/master/src/random_walk.c>
- <https://github.com/kenmcgarry/ComplexNetworks>
- <https://github.com/laderast/igraphTutorial/blob/master/igraphNetworks.Rmd>
- <https://github.com/ontodev/robot>
- <https://github.com/wwkong/Biased-Random-Walk>
- <https://igraph.org/r/doc/as_adjacency_matrix.html>
- <https://igraph.org/r/doc/communities.html>
- <https://igraph.org/r/doc/degree.html>
- <https://igraph.org/r/doc/graph_from_adjacency_matrix.html>
- <https://igraph.org/r/doc/simplify.html>
- <https://kateto.net/wp-content/uploads/2016/01/NetSciX_2016_Workshop.pdf>
- <https://networkdata.ics.uci.edu/netdata/html/floridaFoodWebs.html>
- <https://onlinelibrary.wiley.com/doi/full/10.1002/ece3.3648>
- <https://protege.stanford.edu/>
- <https://protegewiki.stanford.edu/wiki/Protege_Ontology_Library>
- <https://rdrr.io/cran/igraphdata/man/foodwebs.html>
- <https://realpython.com/instance-class-and-static-methods-demystified/>
- <https://snap.stanford.edu/data/>
- <https://snap.stanford.edu/data/C-elegans-frontal.html>
- <https://snap.stanford.edu/data/cit-HepPh.html>
- <https://snap.stanford.edu/data/Florida-bay.html>
- <https://sparontologies.github.io/cito/current/cito.html>
- <https://stackoverflow.com/questions/11488174/how-to-select-a-cran-mirror-in-r>
- <https://stackoverflow.com/questions/12384071/how-to-coerce-a-list-object-to-type-double>
- <https://stackoverflow.com/questions/35366187/how-to-write-if-else-statements-if-dataframe-is-empty>
- <https://stackoverflow.com/questions/40086031/remove-self-loops-and-vertex-with-no-edges>
- <https://stackoverflow.com/questions/46651278/how-to-compute-random-walk-between-all-pairs-of-nodes-in-graph>
- <https://stackoverflow.com/questions/47837607/creating-a-transitions-matrix-for-markov-model-in-r>
- <https://stackoverflow.com/questions/4904972/convert-igraph-object-to-a-data-frame-in-r>
- <https://stackoverflow.com/questions/49095518/more-efficient-way-to-run-a-random-walk-on-a-transition-matrix-than-the-igraph>
- <https://stats.stackexchange.com/questions/206447/how-to-create-a-random-walk-model-using-forecast-r-package>
- <https://stats.stackexchange.com/questions/26722/calculate-transition-matrix-markov-in-r>
- <https://www.biorxiv.org/content/10.1101/106369v1.full>
- <https://www.datascienceontology.org/>
- <https://www.mosaicdatascience.com/blogs/ontology-101-part-1-what-is-an-ontology/>
- <https://www.mosaicdatascience.com/blogs/ontology-101-part-2-a-practical-application-of-an-ontology/>
- <https://www.r-bloggers.com/a-plot-of-250-random-walks/>
- <https://www.rdocumentation.org/packages/sna/versions/2.3-2/topics/gplot.layout>
- <https://www.sciencedirect.com/topics/mathematics/transition-probability-matrix>
- <https://www.stat.auckland.ac.nz/~ihaka/downloads/Waikato-WRUG.pdf>
- <https://www.w3.org/wiki/Good_Ontologies>
