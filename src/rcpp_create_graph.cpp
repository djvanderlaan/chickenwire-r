#include "rcpp_graph_store.h"
#include <Rcpp.h>

#include <iostream>
#include <iomanip>

// [[Rcpp::export]]
int rcpp_create_graph(bool directed) {
  Graph* graph = new Graph(directed);
  return register_graph(graph);
}

// [[Rcpp::export]]
void rcpp_add_vertices(int graph_id, Rcpp::IntegerVector id) {
  Graph* graph = get_graph(graph_id);
  for (R_xlen_t i = 0, end = id.size(); i < end; ++i) 
    graph->add_vertex(id[i]);
}

// [[Rcpp::export]]
void rcpp_add_edges(int graph_id, Rcpp::IntegerVector src, Rcpp::IntegerVector dst, 
    Rcpp::NumericVector wght, Rcpp::IntegerVector type, bool auto_add_vertex) {
  Graph* graph = get_graph(graph_id);
  for (R_xlen_t i = 0, j = 0, k = 0, end = src.size(); i != end; ++i, ++j, ++k) {
    if (j >= wght.size()) j = 0;
    if (k >= type.size()) k = 0;
    if (auto_add_vertex) {
      graph->add_vertex_if_not_exists(src[i]);
      graph->add_vertex_if_not_exists(dst[i]);
    }
    graph->add_edge(src[i], dst[i], wght[j], type[k]);
  }
}

// [[Rcpp::export]]
void rcpp_delete_graph(int graph_id) {
  delete_graph(graph_id);
}

// [[Rcpp::export]]
void rcpp_delete_all_graphs() {
  delete_all_graphs();
}

