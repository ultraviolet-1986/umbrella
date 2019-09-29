\name{RandomJourney}
\alias{RandomJourney}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
RandomJourney(data, attribute, walk_mode = "out")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
}
  \item{attribute}{
%%     ~~Describe \code{attribute} here~~
}
  \item{walk_mode}{
%%     ~~Describe \code{walk_mode} here~~
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
function (data, attribute, walk_mode = "out") 
{
    path <- ""
    stuck <- FALSE
    loop_iteration <- 0
    root_nodes <- which(sapply(sapply(V(data), function(x) neighbors(data, 
        x, mode = "in")), length) == 0)
    root_nodes <- as.vector(as.integer(root_nodes))
    print(paste("NOTE: Detected root nodes:"))
    print(root_nodes)
    print(paste("Number of Root Nodes: ", length(root_nodes), 
        ".", sep = ""))
    if (length(root_nodes) > 1) {
        root_nodes <- sample(root_nodes, 1, replace = FALSE)
    }
    else if (length(root_nodes) == 1) {
        root_nodes <- as.integer(root_nodes)
    }
    else {
        print("NOTE: No 'root node' has been detected. Selecting at random.")
        root_nodes <- sample(length(data), 1, replace = FALSE)
    }
    previous_state <- as.vector(as.integer(root_nodes))
    print(paste("NOTE: Beginning Random Journey from the selected node: ", 
        root_nodes, ".", sep = ""))
    print(root_nodes)
    while (isFALSE(stuck)) {
        loop_iteration <- loop_iteration + 1
        walk <- random_walk(data, start = previous_state, steps = 2, 
            stuck = "return", mode = walk_mode)
        next_step <- tail(as.integer(walk), n = 1)
        nodes_available <- igraph::neighbors(data, next_step, 
            mode = walk_mode)
        number_of_nodes <- length(igraph::neighbors(data, next_step, 
            mode = "out"))
        attribute_mod <- vertex_attr(data, attribute, index = V(data))[[next_step]]
        attribute_mod_next <- vertex_attr(data, attribute, index = V(data))[[(as.integer(next_step) + 
            1)]]
        next_step_loop <- 0
        while (number_of_nodes >= next_step_loop) {
            if (as.integer(attribute_mod) > as.integer(attribute_mod_next)) {
                print(paste("NOTE: Targeting a node containing a lower value of ", 
                  "attribute '", attribute, "',", sep = ""))
                next_step <- sample(number_of_nodes, size = 1)
                break
            }
            else {
                print("NOTE: Reject current target. Choosing another target.")
            }
            next_step_loop <- next_step_loop + 1
        }
        if (attribute_mod == 0) {
            print(paste("NOTE: Detected a target with attribute '", 
                attribute, "' value of '0'.", sep = ""))
            print("NOTE: Searching for nearest alternative.")
        }
        else if (as.integer(attribute_mod) > as.integer(next_step)) {
            print(paste("NOTE: Selected a target of a lower value of attribute '", 
                attribute, "' than itself.", sep = ""))
        }
        else if (as.integer(attribute_mod) < as.integer(next_step)) {
            print(paste("NOTE: A target of a lower value of attribute '", 
                attribute, "' is not available.", sep = ""))
            print("NOTE: No logical path forward available.")
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
            invisible(path)
        }
        else if (loop_iteration >= igraph::vcount(data)) {
            print(paste("NOTE: Number of loops performed has reached the length of", 
                "the network."))
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
            invisible(path)
        }
        else if (number_of_nodes <= 1) {
            print("NOTE: There are no nodes available for traversal.")
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
            invisible(path)
        }
        else {
            print("NOTE: RandomJourney() has encountered an unknown error.")
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
            invisible(path)
        }
        path <- union(path, walk)
    }
    path <- as.vector(as.integer(path))
    path <- path[-1]
    path <- graph_from_adj_list(path)
    path <- simplify(path)
    print(paste("NOTE: Performed", loop_iteration, "loop(s)."))
    print(paste("NOTE: Printing path taken."))
    print(path)
    invisible(path)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
