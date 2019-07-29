
#' Raw/direct interface for adding vertices to graph
#'
#' Add vertices to graph. Assumes vertices are numbered 0 and up. To use the 
#' raw interface the user should ensure that the vertices (and edges) are labelled
#' using sequential integers starting from 0. 
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
#' @seealso
#' Is intended to be used together with \code{\link{add_edges_raw}} to create a 
#' graph where the user takes care of correctly labelling edges and vertices.
#'
#' @examples
#' # Create a graph with 4 vertices without edges
#' g <- create_graph()
#' g <- add_vertices_raw(g, data.frame(id = c(0,1,2,3)))
#' print(g)
#' delete_graph(g)
#'
#' # The example below shows what happens when vertices are not numbered
#' # sequentially from 0. Althoug we only add 4 vertices, the graph contains
#' # 5 vertices. This is because the vertex labelled 0 is automatically added
#' # when adding vertex 1.
#' g <- create_graph()
#' g <- add_vertices_raw(g, data.frame(id = c(1,2,3,4)))
#' print(g)
#' delete_graph(g)
#'
#' @export
add_vertices_raw <- function(graph_id, vertices, vertex_id_col = 1L) {
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)
  vertex_id <- vertices[, vertex_id_col]
  stopifnot(is.numeric(vertex_id) && length(vertex_id) >= 1)
  stopifnot(!any(is.na(vertex_id)))
  rcpp_add_vertices(graph_id, vertex_id)
  graph_id
}

