cat("Local averate continuous\n")

library(chickenwire)

g2 <- create_graph()
g2 <- add_edges(g2, data.frame(src = c(1,1,2,2,3,3), dst = c(2,3,1,3,1,2)), 
  vertices = 1:4)


cat("A")
rw <- local_average(g2, vertex_values = c(0, 0, 0, 0))
stopifnot(all.equal(rw, c(0, 0, 0, NA)))
cat(" OK\n")

cat("B")
rw <- local_average(g2, vertex_values = c(1, 1, 1, 1))
stopifnot(all.equal(rw, c(1, 1, 1, NA)))
cat(" OK\n")

cat("C")
rw <- local_average(g2, vertex_values = c(0, 1, 0, 0))
tst <- abs(rw - 0.33) < 0.05
stopifnot(all.equal(tst, c(TRUE, TRUE, TRUE, NA)))
cat(" OK\n")

cat("D")
rw <- local_average(g2, vertex_values = c(0, 1, 0, 0), 
  vertex_weights = c(1, 0, 1, 1))
stopifnot(all.equal(rw, c(0, 0, 0, NA)))
cat(" OK\n")

cat("E")
rw <- local_average(g2, vertex_values = c(0, 1, 0, 0), 
  vertex_weights = c(0, 1, 0, 0))
stopifnot(all.equal(rw, c(1, 1, 1, NA)))
cat(" OK\n")

cat("Local averate categorical\n")

cat("A")
rw <- local_average(g2, vertex_values = c("A", "A", "A", "A"))
stopifnot(all.equal(rw$A, c(1, 1, 1, NA)))
cat(" OK\n")

cat("B")
rw <- local_average(g2, vertex_values = c("B", "B", "B", "B"))
stopifnot(all.equal(rw$B, c(1, 1, 1, NA)))
cat(" OK\n")

cat("C")
rw <- local_average(g2, vertex_values = c("A", "B", "A", "A"))
tst <- abs(rw$B - 0.33) < 0.05
stopifnot(all.equal(tst, c(TRUE, TRUE, TRUE, NA)))
tst <- abs(rw$B + rw$A - 1) < 1E-4
stopifnot(all.equal(tst, c(TRUE, TRUE, TRUE, NA)))
cat(" OK\n")

cat("D")
rw <- local_average(g2, vertex_values = c("A", "B", "A", "A"), 
  vertex_weights = c(1, 0, 1, 1))
stopifnot(all.equal(rw$B, c(0, 0, 0, NA)))
tst <- abs(rw$B + rw$A - 1) < 1E-4
stopifnot(all.equal(tst, c(TRUE, TRUE, TRUE, NA)))
cat(" OK\n")

cat("E")
rw <- local_average(g2, vertex_values = c("A", "B", "A", "A"), 
  vertex_weights = c(0, 1, 0, 0))
stopifnot(all.equal(rw$B, c(1, 1, 1, NA)))
tst <- abs(rw$B + rw$A - 1) < 1E-4
stopifnot(all.equal(tst, c(TRUE, TRUE, TRUE, NA)))
cat(" OK\n")

delete_graph(g2)
