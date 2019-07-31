
#' Get the edges of a graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#'
#' @return
#' Data.frame with edges.
#'
#' @export
edges <- function(graph_id) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  e <- rcpp_edges(graph_id)
  e <- as.data.frame(e)
  names(e) <- c("src", "dst", "weight", "type")
  if (!is.null(attr(graph_id, "vertex_ids"))) {
    vertex_ids <- attr(graph_id, "vertex_ids")
    e$src <- vertex_ids[e$src + 1L]
    e$dst <- vertex_ids[e$dst + 1L]
  }
  e
}

