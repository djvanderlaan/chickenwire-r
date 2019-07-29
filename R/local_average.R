#' Local network averages
#'
#' @param graph_id the graph to which to add the edges and vertices. Should
#'   be of type \code{chickenwire}.
#' @param vertex_values a vector with vertex values. Can be numeric, factor or
#'   character values. 
#' @param vertex_weights a vector with vertex weights. Should be numeric and 
#'   have the same length as \code{vertex_values}. Optional.
#' @param alpha probability of continuing the random walk (1-restart 
#'   probability).
#' @param nstep_max maximum number of iterations.
#' @param nworkers number of threads to use during the calculation.
#' @param precision when updates in the local averages are smaller than 
#'   \code{precision} the algorithm is stopped.
#'
#' @return
#' A data.frame. The rows correspond to the vertices.
#'
#' @export
local_average <- function(graph_id, vertex_values, vertex_weights = 1.0, alpha = 0.85, nstep_max = 200,
   nworkers = available_cores(), precision = 1E-5) {

  stopifnot(methods::is(graph_id, "chickenwire"))
  stopifnot(is.integer(graph_id) && length(graph_id) == 1)

  # vertex_id
  # TODO:
  #if (is.factor(vertex_id) || is.character(vertex_id)) 
    #vertex_id <- seq_along(vertex_id)-1L
  #stopifnot(is.numeric(vertex_id) && length(vertex_id) >= 1)
  #stopifnot(!any(is.na(vertex_id)))
  # vertex_weights
  stopifnot(is.numeric(vertex_weights) && length(vertex_weights) >= 1)
  stopifnot(length(vertex_weights == 1) || length(vertex_weights) == length(vertex_values))
  stopifnot(!any(is.na(vertex_weights)))
  # vertex_values
  value_name <- deparse(substitute(vertex_values))
  value_factor <- FALSE
  if (is.factor(vertex_values) || is.character(vertex_values)) {
    vertex_values <- as.factor(vertex_values)
    value_name <- levels(vertex_values)
    vertex_values <- as.integer(vertex_values) - 1
    value_factor <- TRUE
  } else if (is.logical(vertex_values)) {
    vertex_values <- 1.0 * vertex_values;
  }
  stopifnot(is.numeric(vertex_values) && length(vertex_values) == nvertices(graph_id))
  stopifnot(!any(is.na(vertex_values)))
  # alpha
  stopifnot(is.numeric(alpha) && length(alpha) == 1)
  stopifnot(alpha >= 0 && alpha <= 1)
  # nstep_max
  stopifnot(is.numeric(nstep_max) && length(nstep_max) == 1)
  stopifnot(nstep_max > 0)
  # precision
  stopifnot(is.numeric(precision) && length(precision) == 1)
  stopifnot(precision > 0 && precision <= 1)
  # random_walk
  if (value_factor) {
    res <- rcpp_local_average_cat(graph_id, vertex_values, vertex_weights, alpha, nworkers, nstep_max, precision)
    nstep <- attr(res, "nstep")
    res <- as.data.frame(res)
    # when the highest levels are missing from the data set these are not 
    # included in the results. Fix this
    if (ncol(res) < length(value_name)) 
      for (col in seq(ncol(res)+1L, length(value_name)))
        res[[col]] <- 0.0
    names(res) <- value_name
    attr(res, "nstep") <- nstep
  } else {
    res <- rcpp_local_average_cont(graph_id, vertex_values, vertex_weights, alpha, nworkers, nstep_max, precision)
  }
  res
}

