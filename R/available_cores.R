

# Guess a reasonable number of cores to use
# 
# @details
# It first checks if the option \code{mc.cores} is set. If not, it checks
# if the environment variable \code{_R_CHECK_LIMIT_CORES_} is set: if, so
# it used 2 cores. If not, it returns 0, indicating 'use all available 
# cores'.
#
# @export
available_cores <- function() {
  # If mc.cores is set use that
  ncores <- getOption("mc.cores", NA_integer_)
  # mc.cores gives the number of cores additional to the core R-process. Therefore, 
  # mc.cores can be 0
  if (!is.na(ncores) && ncores == 0) ncores <- 1L
  # On R CMD check limits the number of cores to 2
  if (is.na(ncores)) {
    rcmdcheck_limit <- tolower(Sys.getenv("_R_CHECK_LIMIT_CORES_", ""))
    rcmdcheck_limit <- (nzchar(rcmdcheck_limit) && (rcmdcheck_limit != "false"))
    ncores <- if (rcmdcheck_limit) 2L else NA_integer_
  }
  # Use default value of 0
  if (is.na(ncores)) ncores <- 0L
  ncores
}
