How to run NEW-BENCH-3 

Before you start
Replace YOUR-PROJECT-PATH below with the full path to the project directory on your machine.

(PSEUDOHOST 'GABRIEL "{UNIX}/YOUR-PROJECT-PATH/")

(LOAD "{UNIX}/YOUR-PROJECT-PATH/Benchmarks/BENCH-3/NEW-BENCH-3.")

Load the files in tools:

(LOAD 'GABRIEL-TIMERS.LCOM)
(LOAD 'GABRIEL-OTHER.LCOM)

Load the files in BENCHMARKS/BENCH-3:

(LOAD 'IO-BENCHMARKS.LCOM)

Then run:

(BENCH-3
 "{UNIX}/YOUR-PROJECT-PATH/tools/"
 "{UNIX}/YOUR-PROJECT-PATH/Benchmarks/BENCH-3/"
 "{UNIX}/YOUR-PROJECT-PATH/Results/BENCH-3/")