cat("Raw interface\n")

library(chickenwire)

cat("A")
g <- create_graph(directed = TRUE)
g <- add_vertices_raw(g, data.frame(id = c(0,1,2)))
stopifnot(nvertices(g) == 3)
cat(" OK\n")

cat("B")
stopifnot(nedges(g) == 0)
cat(" OK\n")

cat("C")
g <- add_edges_raw(g, data.frame(src = c(0,0,1), dst=c(1,2,2)))
stopifnot(nvertices(g) == 3)
cat(" OK\n")

cat("D")
g <- add_vertices_raw(g, data.frame(id = 4))
stopifnot(nvertices(g) == 5)
cat(" OK\n")

cat("E")
err <- TRUE
try({
  g <- add_edges_raw(g, data.frame(src = c(5), dst=c(1)))
  err <- FALSE
}, silent = TRUE)
stopifnot(err)
cat(" OK\n")

delete_graph(g)

