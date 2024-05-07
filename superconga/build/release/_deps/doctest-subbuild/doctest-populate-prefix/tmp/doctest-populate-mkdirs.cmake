# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/app/superconga/build/release/_deps/doctest-src"
  "/app/superconga/build/release/_deps/doctest-build"
  "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix"
  "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix/tmp"
  "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix/src/doctest-populate-stamp"
  "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix/src"
  "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix/src/doctest-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix/src/doctest-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/app/superconga/build/release/_deps/doctest-subbuild/doctest-populate-prefix/src/doctest-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
