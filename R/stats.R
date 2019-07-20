#' Get number of vertices in graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#'
#' @return
#' An integer with the number of vertices.
#'
#' @export
nvertices <- function(graph_id) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  rcpp_nvertices(graph_id)
}

#' Get number of edges in graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#'
#' @return
#' An integer with the number of edges.
#'
#' @export
nedges <- function(graph_id) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  rcpp_graph_size(graph_id)[2]
}

