#!/bin/bash

function build {
  copy_lib
  document
  echo "Building package"
  R CMD build ./
}

function check {
  build
  package=$(ls chickenwire*.tar.gz | tail -n 1)
  echo "Checking package $package"
  R CMD check $package
}

function clean {
  echo "Cleaning up files from chickenwire lib"
  find ./src -type f ! -name 'rcpp_*' -delete
  echo "Cleaning up binaries"
  rm -f ./src/*.o ./src/*.so
}

function copy_lib {
  echo "Copying chickenwire lib to source dir"
  cp --update chickenwire/include/*.h ./src/
  cp --update chickenwire/src/*.cpp ./src/
}

function document {
  echo "Generating documentation..."
  Rscript  -e "roxygen2::roxygenise()"
}

function test {
  copy_lib
  echo "Running tests"
  for file in tests/test*; do \
    Rscript -e "devtools::load_all(); source('$file')";\
  done
}


case $1 in 
  build) 
    build
    ;;
  check)
    check
    ;;
  clean)
    clean
    ;;
  copy_lib)
    copy_lib
    ;;
  document)
    document
    ;;
  test)
    test
    ;;
  *)
    echo $"Usage: $0 {build|check|clean|copy_lib|document|test}"
esac

