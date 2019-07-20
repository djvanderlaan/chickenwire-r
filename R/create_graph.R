
#' Create empty graph
#'
#' @param directed create directed graph
#'
#' @details
#' Internally the graph is always stored as a directed graph. The option to 
#' specify that the graph is undirected has mainly effect when adding edges: 
#' when the edge A->B is added, the edge B->A is also added automatically. 
#'
#' @return
#' An object of type \code{chickenwire} which is a graph. In this case an empty
#' graph to which edges and vertices can be added using \code{\link{add_edges}} 
#' and \code{\link{add_vertices}}. See those functions for examples.
#'
#' @export
create_graph <- function(directed = TRUE) {
  graph_id <- rcpp_create_graph(directed)
  structure(graph_id, class = "chickenwire")
}

