\name{AnalyseData}
\alias{AnalyseData}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Umbrella: AnalyseData()
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
AnalyseData(dataset, draw_graph = c(TRUE, FALSE), random_seed = c(TRUE, FALSE))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataset}{
%%     ~~Describe \code{dataset} here~~
}
  \item{draw_graph}{
%%     ~~Describe \code{draw_graph} here~~
}
  \item{random_seed}{
%%     ~~Describe \code{random_seed} here~~
}
}
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
function (dataset, draw_graph = c(TRUE, FALSE), random_seed = c(TRUE,
    FALSE))
{
    if (isTRUE(random_seed)) {
        umbrella::ApplyRandomSeed()
    }
    else if (isFALSE(random_seed)) {
        print(paste("NOTE: Argument 'random_seed' is set to 'FALSE'. Proceeding ",
            "with machine default."))
    }
    else if (missing(random_seed)) {
        print(paste("NOTE: Argument 'random_seed' is missing. Proceeding with ",
            "machine default."))
    }
    else {
        print("ERROR: An unknown error occurred. Terminating Data Analysis.")
        return()
    }
    if (missing(dataset)) {
        print(paste("ERROR: Argument 'dataset' has not been defined. Terminating",
            "Data Analysis."))
        return()
    }
    else if (typeof(dataset) == "list") {
        print("NOTE: Data is of type 'list'.")
        data_type <- class(dataset)
    }
    else {
        print("ERROR: An unknown error occurred. Terminating Data Analysis.")
        return()
    }
    print("NOTE: Validation Complete. No errors encountered.")
    if (class(dataset) == "data.frame") {
        print(paste("NOTE: Data are 'data.frame' format. Converting to 'igraph'."))
        dataset <- igraph::graph_from_adj_list(dataset, mode = "all",
            duplicate = FALSE)
        print(paste("NOTE: Data have been converted to 'igraph'."))
    }
    else if (class(dataset) == "igraph") {
        print(paste("NOTE: Data are 'igraph' format. No conversion required."))
    }
    else {
        print("ERROR: An unknown error occurred. Terminating Data Analysis.")
        return()
    }
    print(paste("NOTE: Data contains a total of", igraph::ecount(dataset),
        "connections."))
    print(paste("NOTE: Data contains a total of", igraph::vcount(dataset),
        "nodes."))
    if (isTRUE(draw_graph)) {
        igraph::plot.igraph(dataset, main = "Network Data Graph",
            sub = paste("Umbrella", packageVersion("umbrella")))
    }
    invisible(dataset)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
