
#' Raw/direct interface for adding edges to graph
#'
#' Adds edges to a graph. Assumes that vertices are numbered 0 and up. Does not
#' recode the source and destination id's of the edges. Does not add vertices
#' when these do not yet exists (this will generate an error; edges are added up 
#' until the error).
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
#'
#' @details
#' Note that the original \code{graph_id} is modified. 
#'
#' @return
#' Modifies \code{graph_id} and returns \code{graph_id}.
#'
#' @seealso
#' Is intended to be used together with \code{\link{add_vertices_raw}} to create a 
#' graph where the user takes care of correctly labelling edges and vertices.
#'
#' @examples
#' # Create graph with three vertices and 5 edges between them.
#' g <- create_graph()
#' g <- add_vertices_raw(g, data.frame(id = c(0,1,2,3,4)))
#' g <- add_edges_raw(g, data.frame(src = c(0,0,1,1,2), dst = c(1,2,0,2,0)))
#' print(g)
#' delete_graph(g)
#'
#' @export
add_edges_raw <- function(graph_id, edges, edge_src_col = 1, edge_dst_col = 2, 
    edge_weight_col, edge_type_col) {

  # Check input
  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)

  edge_src <- edges[, edge_src_col]
  edge_dst <- edges[, edge_dst_col]

  edge_weight <- if (!missing(edge_weight_col)) 
    edges[, edge_weight_col] else 1.0
  edge_type <- if (!missing(edge_type_col)) 
    edges[, edge_type_col] else 1L

  check_edges(edge_src, edge_dst, edge_weight, edge_type)

  rcpp_add_edges(graph_id, edge_src, edge_dst, edge_weight, edge_type, FALSE)
  graph_id
}
