# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/app/superconga/build/release/_deps/highfive-src"
  "/app/superconga/build/release/_deps/highfive-build"
  "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix"
  "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix/tmp"
  "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix/src/highfive-populate-stamp"
  "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix/src"
  "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix/src/highfive-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix/src/highfive-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/app/superconga/build/release/_deps/highfive-subbuild/highfive-populate-prefix/src/highfive-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()