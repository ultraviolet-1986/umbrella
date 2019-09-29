\name{RandomWalk}
\alias{RandomWalk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{umbrella::RandomWalk()}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
RandomWalk(dataset, ontology, start_node, walk_length, random_seed = c(TRUE, FALSE), walk_mode = c("in", "out", "all"), stuck_response = c("return", "error"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataset}{
%%     ~~Describe \code{dataset} here~~
}
  \item{ontology}{
%%     ~~Describe \code{ontology} here~~
}
  \item{start_node}{
%%     ~~Describe \code{start_node} here~~
}
  \item{walk_length}{
%%     ~~Describe \code{walk_length} here~~
}
  \item{random_seed}{
%%     ~~Describe \code{random_seed} here~~
}
  \item{walk_mode}{
%%     ~~Describe \code{walk_mode} here~~
}
  \item{stuck_response}{
%%     ~~Describe \code{stuck_response} here~~
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
function (dataset, ontology, start_node, walk_length, random_seed = c(TRUE,
    FALSE), walk_mode = c("in", "out", "all"), stuck_response = c("return",
    "error"))
{
    if (missing(dataset)) {
        print(paste("ERROR: Argument 'dataset' has not been defined. Terminating",
            "Random Walk."))
        return()
    }
    if (missing(start_node)) {
        print(paste("ERROR: Argument 'start_node' has not been defined.",
            "Terminating Random Walk."))
        return()
    }
    if (missing(walk_length)) {
        walk_length <- round(vcount(dataset)/2)
        print("NOTE: Argument 'walk_length' has not been defined.")
        print(paste("NOTE: Automatically setting number of steps to ",
            walk_length, ".", sep = ""))
    }
    if (isTRUE(random_seed)) {
        umbrella::ApplyRandomSeed()
    }
    else if (isFALSE(random_seed)) {
        print(paste("NOTE: Argument 'random_seed' set to 'FALSE'. Proceeding with",
            "current pseudo-random seed."))
    }
    else if (missing(random_seed)) {
        print(paste("NOTE: Argument 'random_seed' not specified. Proceeding with",
            "current pseudo-random seed."))
    }
    else {
        print(paste("ERROR: Argument 'random_seed' has not been defined.",
            "Terminating Random Walk."))
        return()
    }
    if (missing(walk_mode)) {
        print(paste("NOTE: Argument 'walk_mode' not specified. Proceeding under ",
            "'all' mode."))
        walk_mode <- "all"
    }
    else if (walk_mode == "in") {
        print("NOTE: Random Walk will be executed under 'in' mode.")
    }
    else if (walk_mode == "out") {
        print("NOTE: Random Walk will be executed under 'out' mode.")
    }
    else if (walk_mode == "all") {
        print("NOTE: Random Walk will be executed under 'all' mode.")
    }
    else {
        print(paste("ERROR: Argument 'walk_mode' has not been defined. Terminating",
            "Random Walk."))
        return()
    }
    if (missing(stuck_response)) {
        print(paste("ERROR: Argument 'stuck' has not been defined. Terminating",
            "Random Walk."))
        return()
    }
    n <- vcount(dataset)
    tm <- matrix(sample(0:1, n^2, prob = c(0.95, 0.05), replace = TRUE),
        n, n)
    tm <- (tm == 1 | t(tm) == 1) * 1
    diag(tm) <- 0
    start <- start_node
    len <- walk_length
    path <- c(start, rep(NA, len))
    for (i in 2:(len + 1)) {
        idx <- tm[path[i - 1], ] != 0
        if (any(idx)) {
            path[i] <- resample(which(idx), 1, prob = tm[path[i -
                1], idx])
        }
        else {
            break
        }
    }
    path
    path <- igraph::graph_from_adj_list(path, mode = "all", duplicate = FALSE)
    print(path)
    print("NOTE: Plotting random walk on data set.")
    plot(path, main = "Random Walk Graph / RandomWalk()", sub = paste("Umbrella",
        packageVersion("umbrella")))
    invisible(path)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
