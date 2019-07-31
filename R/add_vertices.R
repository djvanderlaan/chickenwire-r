
#' Add vertices to graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#' @param vertices a data.frame or vector with vertices. By default it is assumed that
#'   the first column of the data.frame contains the vertex id's (see \code{vertex_id_col}). This
#'   column, or the vector supplied should of type \code{numeric}, \code{character} or 
#'   \code{factor}.
#' @param vertex_id_col name or number of the column from \code{vertices} containing
#'   the id's of the vertices. Used when a data.frame is supplied for \code{vertices}.
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
  if (is.numeric(vertices) || is.character(vertices) || is.factor(vertices)) {
    vertex_id <- vertices
  } else if (is.data.frame(vertices)) {
    vertex_id <- vertices[[vertex_id_col]]
  }
  stopifnot(is.numeric(vertex_id) || is.character(vertex_id) || is.factor(vertex_id))
  stopifnot(length(vertex_id) >= 1)
  stopifnot(!any(is.na(vertex_id)))
  stopifnot(!any(duplicated(vertex_id)))
  # Create/update list with vertex ids
  vertex_ids <- attr(graph_id, "vertex_ids")
  if (is.null(vertex_ids)) {
    vertex_ids <- vertex_id
    new_vertex_ids <- seq_along(vertex_ids) - 1L
  } else {
    new_vertex_ids <- setdiff(vertex_id, vertex_ids)
    if (length(new_vertex_ids) != length(vertex_id))
      warning("Ingnoring vertices that are already included in the graph")
    vertex_ids <- c(vertex_ids, new_vertex_ids)
    new_vertex_ids <- match(new_vertex_ids, vertex_ids) - 1L
  }
  # Add
  rcpp_add_vertices(graph_id, new_vertex_ids)
  attr(graph_id, "vertex_ids") <- vertex_ids
  graph_id
}

