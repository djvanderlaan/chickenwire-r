

check_edges <- function(edge_src, edge_dst, edge_weight, edge_type) {
  # edge_src
  stopifnot(is.numeric(edge_src) && length(edge_src) >= 1)
  stopifnot(!any(is.na(edge_src)))
  # edge_dst
  stopifnot(is.numeric(edge_dst) && length(edge_dst) >= 1)
  stopifnot(length(edge_dst) == length(edge_src))
  stopifnot(!any(is.na(edge_dst)))
  # edge_weight
  stopifnot(is.numeric(edge_weight) && length(edge_weight) >= 1)
  stopifnot(length(edge_weight == 1) || length(edge_weight) == length(edge_src))
  stopifnot(!any(is.na(edge_weight)))
  # edge_type
  stopifnot(is.numeric(edge_type) && length(edge_type) >= 1)
  stopifnot(length(edge_type == 1) || length(edge_type) == length(edge_src))
  stopifnot(!any(is.na(edge_type)))
  TRUE
}

