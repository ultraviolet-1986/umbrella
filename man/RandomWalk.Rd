\name{RandomWalk}
\alias{RandomWalk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Function: RandomWalk()
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
    if (isTRUE(random_seed)) {
        print("NOTE: Applying a unique psuedo-random seed.")
        ApplyRandomSeed()
    }
    else if (isFALSE(random_seed)) {
        print("NOTE: Proceeding with default pseudo-random seed.")
    }
    else if (missing(random_seed)) {
        print("NOTE: Proceeding with default pseudo-random seed.")
    }
    else {
        print("ERROR: Argument 'random_seed' has not been defined correctly.")
        return()
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line