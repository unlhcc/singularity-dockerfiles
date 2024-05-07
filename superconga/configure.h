//===--------- configure.h.in - Collection of useful macro defines --------===//
//
// Part of the SuperConga Project, under the GNU LGPL v3 license or higher.
// See LICENSE.txt for license information.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file contains useful macro defines, like version number, project name,
/// paths, etc. cmake parses this file and creates configure.h, the latter which
/// can then be included e.g. in C++, such that the defines become available.
///
//===----------------------------------------------------------------------===//
#ifndef CONGA_CONFIGURE_H_
#define CONGA_CONFIGURE_H_

#include <string>

namespace conga {
namespace configure {
// Version number
const std::string version = "1.1.0";

// Project name
const std::string projectName = "SuperConga";

// Paths
const std::string rootPath = "/app/superconga";
const std::string dataPath = "/app/superconga/data";
const std::string sourcePath = "/app/superconga/src";
const std::string buildPath = "/app/superconga/build";
const std::string includePath = "/app/superconga/include";

// License statement
const std::string licenseStatement =
    "Copyright (C) 2019 superconga developers, Inc.\nThis is free software; "
    "see the source for copying conditions.\nThere is NO warranty; not even "
    "for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.";

// Define CUDA and HIP identifiers. This is safer than relying on macros such as
// __CUDACC__ etc, since several different compilers other than nvcc can compile
// CUDA code. Furthermore, such macros might be enabled/disabled in unexpected
// scenarios. See:
// https://docs.amd.com/bundle/HIP-Programming-Guide-v5.2/page/Transitioning_from_CUDA_to_HIP.html#d4439e822
#define CONGA_HIP 0
#define CONGA_CUDA 1

constexpr int useHip = CONGA_HIP;
constexpr int useCuda = CONGA_CUDA;

// Define integral constants, useful to set up template meta programming as a
// solution to enable/disable HIP or CUDA implementation at compile time (using
// std::enable_if).
typedef std::integral_constant<bool, useCuda> UseCudaType;
typedef std::integral_constant<bool, useHip> UseHipType;

} // namespace configure
} // namespace conga

#endif // CONGA_CONFIGURE_H_
