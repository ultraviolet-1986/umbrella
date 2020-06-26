\name{RandomJourneyFoodweb}
\alias{RandomJourneyFoodweb}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{umbrella::RandomJourneyFoodweb())}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
RandomJourneyFoodweb(random_seed = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
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
function (random_seed = FALSE)
{
    if (random_seed == TRUE) {
        print("########## APPLY RANDOM SEED ##########")
        umbrella::ApplyRandomSeed()
    }
    print("########## BEGIN EXPERIMEMT ##########")
    print(paste("TEST: Loading the 'foodwebs' dataset from package",
        "'igraphdata'."))
    data("foodwebs")
    attribute <- "Biomass"
    gramwet <- foodwebs$gramwet
    gramwet <- simplify(gramwet)
    node_name_list <- ""
    path <- ""
    stuck <- FALSE
    loop_iteration <- 0
    root_nodes <- which(sapply(sapply(V(gramwet), function(x) neighbors(gramwet,
        x, mode = "out")), length) == 0)
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
        root_nodes <- sample(length(gramwet), 1, replace = FALSE)
    }
    previous_state <- as.vector(as.integer(root_nodes))
    print(paste("NOTE: Beginning Random Journey from the selected node: ",
        root_nodes, ".", sep = ""))
    print(root_nodes)
    walk_mode <- "all"
    while (isFALSE(stuck)) {
        loop_iteration <- loop_iteration + 1
        walk <- random_walk(gramwet, start = previous_state,
            steps = 2, stuck = "return", mode = walk_mode)
        next_step <- tail(as.integer(walk), n = 1)
        nodes_available <- igraph::neighbors(gramwet, next_step,
            mode = walk_mode)
        number_of_nodes <- length(igraph::neighbors(gramwet,
            next_step, mode = walk_mode))
        biomass_current <- vertex_attr(gramwet, attribute, index = V(gramwet))[[next_step]]
        biomass_next <- vertex_attr(gramwet, attribute, index = V(gramwet))[[(as.integer(next_step) +
            1)]]
        weight_current <- edge_attr(gramwet, "weight", index = V(gramwet))[[next_step]]
        weight_current <- as.double(weight_current)
        weight_next <- edge_attr(gramwet, "weight", index = V(gramwet))[[(as.integer(next_step) +
            1)]]
        weight_next <- as.double(weight_next)
        node_name_current <- vertex_attr(gramwet, "name", index = V(gramwet))[[as.double(next_step)]]
        node_name_next <- vertex_attr(gramwet, "name", index = V(gramwet))[[(as.double(next_step) +
            1)]]
        node_name_list_current <- union(node_name_current, node_name_next)
        node_name_list <- union(node_name_list, node_name_list_current)
        distance <- igraph::distances(gramwet, v = node_name_current,
            to = node_name_next)
        distance <- toString(distance)
        next_step_loop <- 0
        if ((biomass_current < biomass_next) && (weight_current >
            weight_next) && (isTRUE(distance <= 5))) {
            print(paste("NOTE: '", node_name_next, "' has/have been consumed by '",
                node_name_current, "'.", sep = ""))
            next_step <- sample(number_of_nodes, size = 1)
        }
        else if ((biomass_current > biomass_next) && (weight_current <
            weight_next) && (isTRUE(distance > 5))) {
            print(paste("NOTE: '", node_name_current, "' has/have been consumed by '",
                node_name_next, "'.", sep = ""))
            next_step <- sample(number_of_nodes, size = 1)
        }
        else if (biomass_current == 0) {
            print(paste("NOTE: Detected a creature with biomass of 0 at the",
                "current location."))
            stuck <- TRUE
        }
        else {
            print(paste("NOTE: '", node_name_current, "' can/will not likely ",
                "consume '", node_name_next, "'. Selecting another target.",
                sep = ""))
            next_step <- sample(number_of_nodes, size = 1)
        }
        if (loop_iteration >= igraph::vcount(gramwet)) {
            print("NOTE: This foodweb has been fully explored.")
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
        }
        else if (number_of_nodes == 0) {
            print("NOTE: There are no creatures available for consumption.")
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
        }
        else if (isFALSE(stuck)) {
        }
        else {
            print("NOTE: Random Journey has encountered an unknown error.")
            print("NOTE: Terminating Random Journey.")
            stuck <- TRUE
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
    node_name_list <- node_name_list[-1]
    print(paste("NOTE: Printing list of nodes visited during Random Journey."))
    print(cat(node_name_list, sep = "\n"))
    clusters <- cluster_walktrap(path)
    plot(clusters, path, main = "Random Journey / foodwebs$gramwet",
        sub = paste("Umbrella", packageVersion("umbrella")))
    print("NOTE: Plotting random walk on 'foodwebs' data. Please Wait.")
    walk_plot <- GGally::ggnet2(path, label = TRUE, node.size = 9,
        node.color = "pink", edge.size = 1, edge.color = "grey",
        arrow.size = 8, arrow.gap = 0.022, mode = "kamadakawai")
    print(walk_plot)
    invisible(path)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
