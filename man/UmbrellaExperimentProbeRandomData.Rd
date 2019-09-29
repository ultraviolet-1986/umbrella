\name{UmbrellaExperimentProbeRandomData}
\alias{UmbrellaExperimentProbeRandomData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
UmbrellaExperimentProbeRandomData()
}
%- maybe also 'usage' for other objects documented here.
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function () 
{
    print("########## EXPERIMEMT ##########")
    setwd("~/")
    test_data <- umbrella::GenerateRandomNetwork(to_file = TRUE)
    test_data <- umbrella::AnalyseData(test_data, draw_graph = TRUE)
    print("TEST: Performing random walk on testing data.")
    test_random_walk <- igraph::random_walk(test_data$dataset, 
        start = 1, steps = 10, mode = "all")
    print(test_random_walk)
    print("TEST: Output an adjacency edge list of the network data.")
    print(igraph::as_adj_edge_list(test_data$dataset))
    test_random_walk <- igraph::graph_from_adj_list(test_random_walk)
    test_random_walk <- simplify(test_random_walk)
    print("TEST: Plotting random walk on testing data.")
    igraph::plot.igraph(test_random_walk, main = "Random Walk Graph / UmbrellaExperimentProbeRandomData()", 
        sub = paste("Umbrella", packageVersion("umbrella")))
    print("TEST: Return data as graph object.")
    print(test_data)
    invisible(test_data)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
