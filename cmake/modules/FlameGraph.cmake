
set (FLAMEGRAPH_DIR ${CMAKE_BINARY_DIR}/contrib/FlameGraph)
if (NOT EXISTS ${FLAMEGRAPH_DIR}/flamegraph.pl)
	message (STATUS "Flamegraph not found. Downloading it!")
	include (ExternalProject)
	ExternalProject_Add (FlameGraph
		UPDATE_COMMAND ""
		SOURCE_DIR ${FLAMEGRAPH_DIR}
		GIT_REPOSITORY https://github.com/brendangregg/FlameGraph
		GIT_PROGRESS 1
		GIT_SHALLOW 1
		UPDATE_COMMAND ""
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		INSTALL_COMMAND ""
	)
else ()
	message (STATUS "Using flamegraph.pl found at ${FLAMEGRAPH_DIR}")
endif ()
