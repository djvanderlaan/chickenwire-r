
#' Get the vertices of a graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#'
#' @return
#' Data.frame with vertices.
#'
#' @export
vertices <- function(graph_id) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  v <- rcpp_vertices(graph_id)
  v <- as.data.frame(v)
  names(v) <- c("id", "type")
  v
}

