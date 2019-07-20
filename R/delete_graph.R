
#' Delete graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#'
#' @return
#' The memory belonging to the graph is cleared and \code{graph_id} is no longer
#' valid. Subsequent use of \code{graph_id} will give an error.
#'
#' @export
delete_graph <- function(graph_id) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  rcpp_delete_graph(graph_id)
}

