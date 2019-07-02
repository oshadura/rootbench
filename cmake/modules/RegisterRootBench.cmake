list(APPEND CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH})

#----------------------------------------------------------------------------
# function RB_REGISTER_BENCH(<benchmark>)
#----------------------------------------------------------------------------
function(RB_REGISTER_BENCH benchmark RB_TESTS_${benchmark} CMAKE_CURRENT_BINARY_DIR TIMEOUT_VALUE ARG_LABEL postcmd)
message(STATUS ${RB_TESTS_${benchmark}})
foreach(rb_bench ${RB_TESTS_${benchmark}})
  string(REGEX REPLACE "-" "/" rb_bench "${rb_bench}")
  message(STATUS ${rb_bench})
  ROOT_ADD_TEST(rootbench-${benchmark}-${rb_bench}
    COMMAND ${benchmark} --benchmark_filter=${rb_bench}^ --benchmark_out_format=csv --benchmark_out=rootbench-${benchmark}.csv --benchmark_color=false
    WORKING_DIR ${CMAKE_CURRENT_BINARY_DIR}
    POSTCMD ${postcmd}
    TIMEOUT "${TIMEOUT_VALUE}"
    LABELS "${ARG_LABEL}"
    DEPENDS ${benchmark}-cmake-registration
    RUN_SERIAL TRUE
    )
  endforeach()
endfunction()

RB_REGISTER_BENCH(${benchmark} ${RB_TESTS_${benchmark}} ${CMAKE_CURRENT_BINARY_DIR} ${TIMEOUT_VALUE} ${ARG_LABEL} ${postcmd})
