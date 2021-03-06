#include "rcpp_graph_store.h"
#include "graph.h"
#include "random_walk.h"
#include "weigh_edges.h"

#include <Rcpp.h>
#include <algorithm>

// [[Rcpp::export]]
Rcpp::NumericVector rcpp_local_average_cont(int graph_id, Rcpp::NumericVector value, Rcpp::NumericVector vwght, 
    double alpha, int nworkers, int nstep_max, double precision) {
  Graph* graph = get_graph(graph_id);
  // Create values object
  VertexDoubleValues values(value.size());
  VertexDoubleValues weights(value.size());
  // Add vertices to graph and values to values object
  for (R_xlen_t i = 0, j = 0, end = value.size(); i < end; ++i, ++j) {
    if (j >= vwght.size()) j = 0;
    values[i] = value[i];
    weights[i] = vwght[j];
  }
  // Reweigh graph
  reweigh_edges_by_vertex_and_layer(*graph);
  // Random walk
  int nstep = 0;
  VertexDoubleValues rw = random_walk_continuous(*graph, values, weights, alpha, std::max(nworkers, 0), 
    std::max(nstep_max, 1), precision, &nstep);
  // Generate result object
  Rcpp::NumericVector res(rw.size());
  for (size_t i = 0; i < rw.size(); ++i) res[i] = rw[i];
  res.attr("nstep") = nstep;
  return res;
}

// [[Rcpp::export]]
Rcpp::List rcpp_local_average_cat(int graph_id, Rcpp::IntegerVector value, Rcpp::NumericVector vwght,
    double alpha, int nworkers, int nstep_max, double precision) {
  Graph* graph = get_graph(graph_id);
  // Create values object
  VertexCategoricalValues values(value.size());
  VertexDoubleValues weights(value.size());
  // Add vertices to graph and values to values object
  for (R_xlen_t i = 0, j = 0, end = value.size(); i < end; ++i, ++j) {
    if (j >= vwght.size()) j = 0;
    values[i] = value[i];
    weights[i] = vwght[j];
  }
  // Reweigh graph
  reweigh_edges_by_vertex_and_layer(*graph);
  // Random walk
  int nstep = 0;
  RandomWalkResult rw = random_walk_categorical(*graph, values, weights, alpha, std::max(nworkers, 0), 
    std::max(nstep_max, 1), precision, &nstep);
  // Generate result object
  Rcpp::List res(rw.size());
  for (size_t j = 0, jend = rw.size(); j < jend; ++j) {
    VertexDoubleValues& r = rw[j];
    Rcpp::NumericVector v(r.size());
    for (size_t i = 0; i < r.size(); ++i) v[i] = r[i];
    res[j] = v;
  }
  res.attr("nstep") = nstep;
  return res;
}

