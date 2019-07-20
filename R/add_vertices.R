
#' Add vertices to graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#' @param vertices a data.frame with vertices (optional). By default it is assumed that
#'   the first column contains the vertex id's (see \code{vertex_id_col}).
#' @param vertex_id_col name or number of the column from \code{vertices} containing
#'   the id's of the vertices. Should contain integer values.
#'
#' @details
#' Note that the original \code{graph_id} is modified. 
#'
#' @return
#' Modifies \code{graph_id} and returns \code{graph_id}.
#'
#' @examples
#' # Create a graph with 4 vertices without edges
#' g <- create_graph()
#' g <- add_vertices(g, data.frame(id = c(1,2,3,4)))
#' print(g)
#' delete_graph(g)
#'
#'
#' @export
add_vertices <- function(graph_id, vertices, vertex_id_col = 1L) {
  # Check input
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  if (is.numeric(vertices)) {
    vertex_id <- vertices
  } else {
    vertex_id <- vertices[, vertex_id_col]
  }
  stopifnot(is.numeric(vertex_id) && length(vertex_id) >= 1)
  stopifnot(!any(is.na(vertex_id)))
  # Add
  rcpp_add_vertices(graph_id, vertex_id)
  # TODO: store vertex ids with graph; we need those when we want to add
  # additional edges/vertices
  graph_id
}

