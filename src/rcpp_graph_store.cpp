#include "rcpp_graph_store.h"
#include <unordered_map>
#include <string>
#include <stdexcept>

std::unordered_map<int, Graph*> graphs_;
int current_counter_ = 0;

Graph* get_graph(int id, bool throw_error) {
  std::unordered_map<int, Graph*>::iterator p = graphs_.find(id);
  if (p == graphs_.end()) {
    if (throw_error) 
      throw std::runtime_error("Graph does not exist: id = " +
        std::to_string(id) + ".");
    return 0;
  }
  if (throw_error && !p->second) 
    throw std::runtime_error("Graph is already deleted: id = " +
      std::to_string(id) + ".");
  return p->second;
}

int register_graph(Graph* graph) {
  graphs_[current_counter_] = graph;
  return current_counter_++;
}

void delete_graph(int id) {
  std::unordered_map<int, Graph*>::iterator p = graphs_.find(id);
  if (p == graphs_.end()) throw std::runtime_error("Trying to delete graph that doesn't exist: id = " + 
    std::to_string(id) + ".");
  if (!p->second) throw std::runtime_error("Trying to delete graph that is already deleted: id = " + 
    std::to_string(id) + ".");
  delete p->second;
  p->second = 0;
}

void delete_all_graphs() {
  for (std::unordered_map<int, Graph*>::iterator p = graphs_.begin(); p != graphs_.end(); ++p) {
    if (p->second) delete p->second;
    p->second = 0;
  }
}

