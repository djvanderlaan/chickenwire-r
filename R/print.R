

#' @export
print.chickenwire <- function(x, ...) {
  stopifnot(methods::is(x, "chickenwire"))
  stopifnot(is.integer(x) && length(x) == 1)
  size <- rcpp_graph_size(x)
  cat("Graph number ", as.integer(x), "\n", sep ="")
  if (is_directed(x)) cat("Directed graph\n") else cat("Undirected graph\n")
  cat("Number of vertices: ", size[1], "\n", sep ="")
  cat("Number of edges: ", size[2], "\n", sep ="")
}
