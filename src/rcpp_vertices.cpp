#include "graph.h"
#include "rcpp_graph_store.h"

#include <Rcpp.h>


// [[Rcpp::export]]
Rcpp::List rcpp_vertices(int graph_id) {
  const Graph* graph = get_graph(graph_id);
  VertexList vertices = graph->vertices();
  Rcpp::IntegerVector id(vertices.size());
  Rcpp::IntegerVector type(vertices.size());
  VertexList::size_type i = 0;
  for (auto p = vertices.cbegin(), end = vertices.cend(); p != end; ++p, ++i) {
    id[i] = i;
    type[i] = p->type();
  }
  Rcpp::List res(2);
  res[0] = id;
  res[1] = type;
  return res;
}

