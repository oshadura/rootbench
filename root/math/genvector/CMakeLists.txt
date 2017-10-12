RB_ADD_GBENCHMARK(GenVectorBenchmarks
  Cartesian3DBenchmarks.cxx
  LIBRARIES
  GenVector
  MathCore)

 add_test(NAME rootbench-GenVectorBenchmarks
		COMMAND GenVectorBenchmarks
		--benchmark_out_format=json
		--benchmark_out=rootbench-GenVectorBenchmarks.json
		--benchmark_color=false
		)
