cat("Stats\n")

library(chickenwire)

data(ssi)


cat("A")
g <- create_graph(directed = TRUE)
stopifnot(nvertices(g) == 0)
cat(" OK\n")

cat("B")
stopifnot(nedges(g) == 0)
cat(" OK\n")

g <- add_edges(g, ssi$edges, ssi$vertices)
cat("C")
stopifnot(nvertices(g) == nrow(ssi$vertices))
cat(" OK\n")

cat("D")
stopifnot(nedges(g) == nrow(ssi$edges))
cat(" OK\n")

cat("E")
stopifnot(is_directed(g) == TRUE)
cat(" OK\n")

cat("F")
g2 <- create_graph(directed = FALSE)
stopifnot(is_directed(g2) == FALSE)
cat(" OK\n")


delete_graph(g)
delete_graph(g2)
