# How to run NEW-BENCH-1 in Interlisp

## Before you start
Replace `YOUR-PROJECT-PATH` below with the full path to the project directory on your machine.

1.  (PSEUDOHOST 'GABRIEL "{UNIX}/YOUR-PROJECT-PATH/")

2.  (LOAD 'GABRIEL-BENCHMARKS-BENCH-1-NEW-BENCH-1)

3.  Load the files in tools:

    (LOAD 'GABRIEL-TIMERS.LCOM)
    (LOAD 'GABRIEL-OTHER.LCOM)
    (LOAD 'GABRIEL-TAK.LCOM)

4.  Load the files in BENCHMARKS/BENCH-1:

    (LOAD 'TAK.LCOM) 
    (LOAD 'ARITH-BENCHMARKS.LCOM) 
    (LOAD 'IO-BENCHMARKS.LCOM) 

5.  Then run:

    (BENCH-1
     "{UNIX}/YOUR-PROJECT-PATH/tools/"
     "{UNIX}/YOUR-PROJECT-PATH/Benchmarks/BENCH-1/"
     "{UNIX}/YOUR-PROJECT-PATH/Results/")



