#----------------------------------------------------------------------------
# function RB_ADD_GBENCHMARK(<benchmark> source1 source2... LIBRARIES libs POSTCMD cmd)
#----------------------------------------------------------------------------
function(RB_ADD_GBENCHMARK benchmark)
  cmake_parse_arguments(ARG "" "" "LABEL;LIBRARIES;POSTCMD" ${ARGN})
  # FIXME: Move to target_include_directories.
  include_directories(BEFORE ${ROOTBENCH_SOURCE_DIR}/include)
  include_directories(${CMAKE_CURRENT_BINARY_DIR} ${GBENCHMARK_INCLUDE_DIR})
  set(source_files ${ARG_UNPARSED_ARGUMENTS})
  add_executable(${benchmark} ${source_files})
  set_property(TARGET ${benchmark} PROPERTY RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
  # Note we cannot use ROOT_EXECUTABLE without user-specified set of LIBRARIES to link with.
  # The test suites should choose this in their specific CMakeLists.txt file.
  # FIXME: For better coherence we could restrict the libraries the test suite could link
  # against. For example, tests in Core should link only against libCore. This could be tricky
  # to implement because some ROOT components create more than one library.
  target_link_libraries(${benchmark} ${ARG_LIBRARIES} gbenchmark RBSupport)
  #ROOT_PATH_TO_STRING(mangled_name ${benchmark} PATH_SEPARATOR_REPLACEMENT "-")
  if(ARG_POSTCMD)
    set(postcmd POSTCMD ${ARG_POSTCMD})
  endif()
  if(flamegraph)
      set(postcmd ${postcmd} "${PROJECT_SOURCE_DIR}/rootbench-scripts/flamegraph.sh")
      add_dependencies(${benchmark} flamegraph-download)
  endif()
  if(${ARG_LABEL} STREQUAL "long")
    set(TIMEOUT_VALUE 1200)
  elseif(${ARG_LABEL} STREQUAL "short")
    set(TIMEOUT_VALUE 3600)
  endif()

  set(RB_TESTS_${benchmark} RB_TESTS_${benchmark} CACHE STRING "")

  add_custom_command(
    COMMAND ${CMAKE_COMMAND}
    -Dbenchmark="${benchmark}"
    -Dcurrent_binary_dir="${CMAKE_CURRENT_BINARY_DIR}"
    -Dbinary_dir="${CMAKE_BINARY_DIR}"
    -P ${PROJECT_SOURCE_DIR}/cmake/modules/DumpConfigRootBench.cmake
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT  ${benchmark}ListOfBenchmarks.cmake
    DEPENDS ${benchmark})

  add_custom_target(
      ${benchmark}-cmake-registration ALL
      DEPENDS ${benchmark}ListOfBenchmarks.cmake)

  add_dependencies(${benchmark}-cmake-registration ${benchmark})

  add_custom_command(TARGET ${benchmark}-cmake-registration
    POST_BUILD
    COMMAND ${CMAKE_COMMAND}
    -Dbenchmark="${benchmark}"
    -DRB_TESTS_${benchmark}=${${RB_TESTS_${benchmark}}}
    -DCMAKE_CURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}"
    -DTIMEOUT_VALUE="${TIMEOUT_VALUE}"
    -DARG_LABEL="${ARG_LABEL}"
    -Dpostcmd="${postcmd}"
    -DCMAKE_MODULE_PATH="${CMAKE_MODULE_PATH}"
    -P ${PROJECT_SOURCE_DIR}/cmake/modules/RegisterRootBench.cmake
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS ${benchmark}-cmake-registration)

endfunction(RB_ADD_GBENCHMARK)

#----------------------------------------------------------------------------
# function RB_ADD_LIBRARY(<library> source1 source2... LIBRARIES libs)
#----------------------------------------------------------------------------
function(RB_ADD_LIBRARY library)
  cmake_parse_arguments(ARG "" "" "LIBRARIES;DEPENDENCIES" ${ARGN})
  set(sources ${ARG_UNPARSED_ARGUMENTS})
  include_directories(BEFORE ${ROOTBENCH_SOURCE_DIR}/include)
  add_library(${library} STATIC ${sources})
  if (ARG_LIBRARIES OR ARG_DEPENDENCIES)
    target_link_libraries(${library} ${ARG_LIBRARIES} ${ARG_DEPENDENCIES})
  endif()
endfunction(RB_ADD_LIBRARY)
