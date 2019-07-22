\name{GenerateRandomNetworkFile}
\alias{GenerateRandomNetworkFile}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
GenerateRandomNetworkFile()
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
    umbrella_random_network_file <- "umbrella_random_network.csv"
    if (file.exists(umbrella_random_network_file)) {
        file.remove(umbrella_random_network_file)
        print(paste("NOTE:", umbrella_random_network_file, "has been deleted from the current working directory."))
    }
    for (i in 1:100) {
        write(paste(sample(1:100, 1, replace = TRUE), sample(1:100,
            1, replace = TRUE), sep = ", "), file = umbrella_random_network_file,
            append = TRUE, sep = "\n")
        i <- i + 1
    }
    print(paste("NOTE:", umbrella_random_network_file, "has been written to the current working directory."))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
