
#' Delete all graph
#'
#' @return
#' The memory belonging to all graphs is cleared and all \code{graph_id} are no longer
#' valid. Subsequent use of a \code{graph_id} will give an error.
#'
#' @export
delete_all_graphs <- function() {
  rcpp_delete_all_graphs()
}

