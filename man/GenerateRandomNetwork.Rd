\name{GenerateRandomNetwork}
\alias{GenerateRandomNetwork}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{umbrella::GenerateRandomNetwork()}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
GenerateRandomNetwork(nodes = 25, to_file = c(TRUE, FALSE))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{nodes}{
%%     ~~Describe \code{nodes} here~~
}
  \item{to_file}{
%%     ~~Describe \code{to_file} here~~
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
function (nodes = 25, to_file = c(TRUE, FALSE))
{
    umbrella_random_network_file <- "umbrella_random_network.txt"
    umbrella_random_network <- igraph::erdos.renyi.game(nodes,
        0.33)
    if (isTRUE(to_file)) {
        if (file.exists(umbrella_random_network_file)) {
            print(paste("NOTE: Existing network file detected and will be",
                "overwritten."))
        }
        igraph::write_graph(umbrella_random_network, file = umbrella_random_network_file,
            format = "edgelist")
        print(paste("NOTE: Random network file '", umbrella_random_network_file,
            "' has been written", sep = ""))
    }
    invisible(umbrella_random_network)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
