\name{RandomWalk}
\alias{RandomWalk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Umbrella: RandomWalk()
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
RandomWalk(dataset = "placeholder", start_node, steps, random_seed = c(TRUE, FALSE), mode = c("in", "out", "all"), stuck = c("stop_walk", "raise_error"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataset}{
%%     ~~Describe \code{dataset} here~~
}
  \item{start_node}{
%%     ~~Describe \code{start_node} here~~
}
  \item{steps}{
%%     ~~Describe \code{steps} here~~
}
  \item{random_seed}{
%%     ~~Describe \code{random_seed} here~~
}
  \item{mode}{
%%     ~~Describe \code{mode} here~~
}
  \item{stuck}{
%%     ~~Describe \code{stuck} here~~
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
function (dataset = "placeholder", start_node, steps, random_seed = c(TRUE,
    FALSE), mode = c("in", "out", "all"), stuck = c("stop_walk",
    "raise_error"))
{
    if (missing(start_node)) {
        print(paste("ERROR: Argument 'start_node' has not been defined.",
            "Terminating Random Walk."))
        return()
    }
    if (missing(steps)) {
        print(paste("ERROR: Argument 'steps' has not been defined. Terminating",
            "Random Walk."))
        return()
    }
    if (isTRUE(random_seed)) {
        print("NOTE: Applying a unique psuedo-random seed.")
        ApplyRandomSeed()
    }
    else if (isFALSE(random_seed)) {
        print("NOTE: Proceeding with current pseudo-random seed.")
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
    if (missing(mode)) {
        print("NOTE: Argument 'mode' not specified. Proceeding under 'all' mode.")
        mode <- "all"
    }
    else if (mode == "in") {
        print("NOTE: Random Walk will be executed under 'in' mode.")
    }
    else if (mode == "out") {
        print("NOTE: Random Walk will be executed under 'out' mode.")
    }
    else if (mode == "all") {
        print("NOTE: Random Walk will be executed under 'all' mode.")
    }
    else {
        print(paste("ERROR: Argument 'mode' has not been defined. Terminating",
            "Random Walk."))
        return()
    }
    if (missing(stuck)) {
        print(paste("ERROR: Argument 'stuck' has not been defined. Terminating",
            "Random Walk."))
        return()
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
