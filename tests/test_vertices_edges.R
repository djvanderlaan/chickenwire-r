cat("Edges/vertices\n")

library(chickenwire)

data(ssi)


cat("A")
g <- create_graph(directed = TRUE)
g <- add_vertices(g, ssi$vertices)
g <- add_edges(g, ssi$edges)

v <- vertices(g)

stopifnot(all.equal(v$id, ssi$vertices$id))
cat(" OK\n")

cat("B")
stopifnot(all.equal(v$type, rep(0L, nrow(ssi$vertices))))
cat(" OK\n")


cat("C")
e <- edges(g)
ee <- ssi$edges[c("src", "dst")]
ee <- ee[order(ee$src, ee$dst), ]
e <- e[order(e$src, e$dst), ]
stopifnot(all.equal(ee$src, e$src))
stopifnot(all.equal(ee$dst, e$dst))
cat(" OK\n")


cat("D")
stopifnot(all(e$weight == 1))
cat(" OK\n")

cat("E")
stopifnot(all(e$type == 1))
cat(" OK\n")

cat("F")
gg <- create_graph()
v <- vertices(gg)
stopifnot(nrow(v) == 0)
stopifnot(names(v) == c("id", "type"))
cat(" OK\n")

cat("G")
e <- edges(gg)
stopifnot(nrow(e) == 0)
stopifnot(names(e) == c("src", "dst", "weight", "type"))
cat(" OK\n")

delete_graph(gg)
delete_graph(g)
