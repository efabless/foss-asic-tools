#!/bin/bash

$XYCE_SRCDIR/Xyce_Regression/TestScripts/run_xyce_regression \
--output=$XYCE_SRCDIR/Xyce_Test --xyce_test="$XYCE_SRCDIR/Xyce_Regression" \
--taglist="+parallel+nightly?noverbose-klu-verbose?fft" \
--resultfile=$XYCE_SRCDIR/parallel_results \
"mpirun -np 2 --allow-run-as-root `pwd`/src/Xyce" 
