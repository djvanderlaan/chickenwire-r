#include <Rcpp.h>
#include "rcpp_graph_store.h"

using namespace Rcpp;

RcppExport void R_unload_chickenwire(DllInfo *dll) {
  delete_all_graphs();
}

