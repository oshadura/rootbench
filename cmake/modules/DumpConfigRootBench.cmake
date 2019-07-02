# ARG: ${CMAKE_ARGV3} - name of benchmark
# ARG: ${CMAKE_ARGV4} - CMAKE_CURRENT_BINARY_DIR
# ARG: ${CMAKE_ARGV5} - CMAKE_BINARY_DIR
message(STATUS ${benchmark})
message(STATUS ${binary_dir})
message(STATUS ${curent_binary_dir})

#----------------------------------------------------------------------------
# function RB_DUMP_CONF_HELPER(<benchmark>)
#----------------------------------------------------------------------------
function(RB_DUMP_CONF_HELPER benchmark binary_dir)
# Check available benchmarks in binary executables
  exec_program(${current_binary_dir}/${benchmark} ARGS "--benchmark_list_tests=true" OUTPUT_VARIABLE RB_TESTS RETURN_VALUE RETVAR)
  string(REGEX REPLACE "\n" ";" RB_TESTS "${RB_TESTS}")
  # / should be replaced since CMake is not happy with it.
  string(REGEX REPLACE "/" "-" RB_TESTS "${RB_TESTS}")
  # Backup values in separate file
  file(WRITE ${current_binary_dir}/${benchmark}ListOfBenchmarks.cmake "set(RB_TESTS_${benchmark} ${RB_TESTS})")
  file(APPEND ${binary_dir}/CMakeCache.txt "RB_TESTS_${benchmark}:STRING=${RB_TESTS}\n")
endfunction()

RB_DUMP_CONF_HELPER(${benchmark} ${current_binary_dir})
