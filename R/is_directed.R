
#' Get if graph is directed or not
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#'
#' @return
#' Boolean indicating whether the graph is directed or not. 
#'
#' @export
is_directed <- function(graph_id) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  rcpp_is_directed(graph_id)
}
