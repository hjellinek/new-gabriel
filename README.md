# How to run NEW-BENCH-1 in Interlisp

1.  (PSEUDOHOST 'GABRIEL "{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/") 

2.  (LOAD "{DSK}<Users>kabirgupta>documents>interlisp>New-Bench Kabir/BENCHMARKS/BENCH-1/>NEW-BENCH-1") 

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
    "{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/tools/"
    "{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/BENCH-1/"
    "{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Results/")



