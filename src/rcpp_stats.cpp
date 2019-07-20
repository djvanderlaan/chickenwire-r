#include "graph.h"
#include "rcpp_graph_store.h"

#include <Rcpp.h>

inline VertexList::size_type nedges(const Graph& graph) {
  VertexList::size_type n = 0;
  for (auto p = graph.vertices().cbegin(), end = graph.vertices().cend(); p != end; ++p) {
    n += p->degree();
  }
  return n;
}

// [[Rcpp::export]]
Rcpp::IntegerVector rcpp_graph_size(int graph_id) {
  const Graph* graph = get_graph(graph_id);
  Rcpp::IntegerVector res(2);
  res[0] = graph->vertices().size();
  res[1] = nedges(*graph);
  return res;
}

// [[Rcpp::export]]
int rcpp_nvertices(int graph_id) {
  const Graph* graph = get_graph(graph_id);
  return graph->vertices().size();
}


// [[Rcpp::export]]
bool rcpp_is_directed(int graph_id) {
  const Graph* graph = get_graph(graph_id);
  return graph->directed();
}

