#include "graph.h"
#include "rcpp_graph_store.h"

#include <Rcpp.h>


// [[Rcpp::export]]
Rcpp::List rcpp_edges(int graph_id) {
  const Graph* graph = get_graph(graph_id);
  VertexList vertices = graph->vertices();
  // determine number of edges
  VertexList::size_type nedges = 0;
  for (auto p = vertices.cbegin(), end = vertices.cend(); p != end; ++p) {
    nedges += p->degree();
  }
  // Initialise vectors
  Rcpp::IntegerVector src(nedges);
  Rcpp::IntegerVector dst(nedges);
  Rcpp::NumericVector weight(nedges);
  Rcpp::IntegerVector type(nedges);
  // Fill
  VertexList::size_type i = 0;
  VertexList::size_type vertexid = 0;
  for (auto p = vertices.cbegin(), end = vertices.cend(); p != end; ++p, ++vertexid) {
    const EdgeList& edges = p->edges();
    for (auto q = edges.cbegin(), qend = edges.cend(); q != qend; ++q, ++i) {
      src[i]    = vertexid;
      dst[i]    = q->dst();
      weight[i] = q->weight();
      type[i]   = q->type();
    }
  }
  Rcpp::List res(4);
  res[0] = src;
  res[1] = dst;
  res[2] = weight;
  res[3] = type;
  return res;
}

