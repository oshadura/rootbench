#!/bin/bash
source /travis/.bashrc
find $HOME_FOLDER/build -name "*.gcda" -exec cp "{}" $HOME_FOLDER/coveralls/ \;
touch $HOME_FOLDER/build/coverage.info_part1
echo "LCOV info part 1 (due complex setup of CI slaves for ROOT builds)"
export LCOV_PATH_ROOTSYS="\"geninfo_adjust_src_path=/mnt/build/workspace/lcg_ext_rootcov/BUILDTYPE/Release/COMPILER/native/LABEL/ubuntu16/build/projects/ROOT-HEAD/src/ROOT-HEAD-build/=> `echo $ROOTSYS/`\""
$HOME_FOLDER/travis-fix/travis_wait_log 5 $LCOV --gcov-tool gcov -c -d $HOME_FOLDER/coveralls/ --no-markers --quiet  --base-directory `pwd` --ignore-errors graph \
--rc $LCOV_PATH_ROOTSYS \
--output-file $HOME_FOLDER/build/coverage.info_part1