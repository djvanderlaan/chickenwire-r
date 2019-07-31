
#' Add edges to graph
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#' @param edges a data.frame withe edges. Should contain at least two columns:
#'   source vertex id's of the edge and destination id's. By default it is assumed 
#'   that these are in the first two columns of the data.frame (see \code{edge_src_col}
#'   and \code{edge_dst_col}).
#' @param edge_src_col name or number of the column from \code{edges} containing the source 
#'   vertex id's of the edges. Column should contain integer values.
#' @param edge_dst_col name or number of the column from \code{edges} containing the destination 
#'   vertex id's of the edges. Column should contain integer values.
#' @param edge_weight_col name or number of the column from \code{edges} containing the weights 
#'   of the edges. When omitted weights of 1 are assumed. Column should contain 
#'   numeric values.
#' @param edge_type_col name or number of the column from \code{edges} containing the types 
#'   of the edges. When omitted all edges have type 1. Should be of type integer.
#' @param auto_add_vertices automatically create vertices when an edge contains id's that
#'   do not exist yet. When \code{vertices} is given this parameter is set to \code{FALSE}.
#'
#' @details
#' Note that the original \code{graph_id} is modified. 
#'
#' @return
#' Modifies \code{graph_id} and returns \code{graph_id}.
#'
#' @examples
#' # Create graph with three vertices and 5 edges between them.
#' g <- create_graph()
#' g <- add_edges(g, data.frame(src = c(1,1,2,2,3), dst = c(2,3,1,3,1)))
#' print(g)
#' delete_graph(g)
#'
#' # Create graph with four vertices and 5 edges between them; one of the
#' # vertices does not have edges.
#' g <- create_graph()
#' g <- add_vertices(g, 1:4)
#' g <- add_edges(g, data.frame(src = c(1,1,2,2,3), dst = c(2,3,1,3,1)))
#' print(g)
#' delete_graph(g)
#'
#' @export
add_edges <- function(graph_id, edges, edge_src_col = 1, edge_dst_col = 2, 
    edge_weight_col, edge_type_col, auto_add_vertices = TRUE) {
  # Check input
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)

  edge_src <- edges[[edge_src_col]]
  edge_dst <- edges[[edge_dst_col]]
  stopifnot(is.numeric(edge_src) || is.character(edge_src) || is.factor(edge_src))
  stopifnot(is.numeric(edge_dst) || is.character(edge_dst) || is.factor(edge_dst))

  vertices <- attr(graph_id, "vertex_ids")
  if (auto_add_vertices) {
    # Check if we need to add vertices and do so
    new_vertices <- setdiff(unique(c(edge_src, edge_dst)), vertices)
    if (length(new_vertices)) graph_id <- add_vertices(graph_id, new_vertices)
    vertices <- attr(graph_id, "vertex_ids")
  }

  edge_src <- match(edge_src, vertices) - 1L
  edge_dst <- match(edge_dst, vertices) - 1L

  edge_weight <- if (!missing(edge_weight_col)) 
    edges[[edge_weight_col]] else 1.0
  edge_type <- if (!missing(edge_type_col)) 
    edges[[edge_type_col]] else 1L
  if (is.factor(edge_type) || is.character(edge_type)) 
    edge_type <- as.integer(as.factor(edge_type)) - 1
  check_edges(edge_src, edge_dst, edge_weight, edge_type)

  rcpp_add_edges(graph_id, edge_src, edge_dst, edge_weight, edge_type, FALSE)
  graph_id
}

