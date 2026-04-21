# Medley Interlisp Gabriel Benchmarks

## About

This repository runs Gabriel benchmark suites in Medley Interlisp.

The benchmark set comes from the work documented by Richard P. Gabriel in [*Performance and Evaluation of Lisp Systems*](https://www.dreamsongs.com/Files/Timrep.pdf).

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/hjellinek/new-gabriel.git
cd gabriel
```

### 2. Make the runner executable

```bash
chmod +x do-bench.sh
```

### 3. Set MEDLEYDIR (required before first run)

Set only `MEDLEYDIR` to your Medley install path:

```bash
export MEDLEYDIR="/absolute/path/to/medley"
```

Or pass it inline for one run:

```bash
MEDLEYDIR="/absolute/path/to/medley" ./do-bench.sh bench-1
```

### 4. Run a benchmark suite

```bash
./do-bench.sh bench-1
./do-bench.sh bench-2
./do-bench.sh bench-3
./do-bench.sh bench-4
./do-bench.sh bench-5
```

## What Each Suite Runs

- `bench-1`: TAK, ARITH, IO
- `bench-2`: AREFY (and IO support load)
- `bench-3`: CONSY
- `bench-4`: POLY
- `bench-5`: MISC (with IO and MISC support loads)

## Benchmark Summary

- `bench-1`
   - Main tests: `TAK`, `ARITH`, `IO`
   - Expected output files: `AV-TAK.txt`, `IO.txt`, `PAV-ARITH.txt` (after recompiling `NEW-BENCH-1`)
   - Current status: runs
- `bench-2`
   - Main tests: `AREFY` and related benchmark set
   - Expected output file: `AREFY.txt` (after recompiling `NEW-BENCH-2`)
   - Current status: has known storage exhaustion issue
- `bench-3`
   - Main tests: `CONSY`
   - Expected output file: `CONSY.txt` (after recompiling `NEW-BENCH-3`)
   - Current status: runs
- `bench-4`
   - Main tests: `POLY`
   - Expected output file: `POLY.txt` (after recompiling `NEW-BENCH-4`)
   - Current status: runs
- `bench-5`
   - Main tests: `MISC`
   - Expected output file: `MISC.txt` (after recompiling `NEW-BENCH-5`)
   - Current status: has known stack overflow issue

## Results

Each run writes output under `Results/`:

- `Results/BENCH-1/`
- `Results/BENCH-2/`
- `Results/BENCH-3/`
- `Results/BENCH-4/`
- `Results/BENCH-5/`

Primary output files now use `.txt` names in the `NEW-BENCH-*` source files.

Important: `do-bench.sh` currently loads `NEW-BENCH-*.LCOM` for all suites. To get `.txt` output in actual runs, recompile each `NEW-BENCH-*` source in Medley so the updated output names are included in the `.LCOM` files.

## Issue Groups And Recovery Steps

### Group A: BENCH-1 output naming and file replacement behavior

- What happened
   - BENCH-1 originally writes `.Results` files (`AV-TAK.Results`, `IO.Results`, `PAV-ARITH.Results`).
- Why
   - The output names are defined inside `NEW-BENCH-1` and used by the compiled `NEW-BENCH-1.LCOM`.
- Important behavior
   - Changing output names to `.txt` creates separate new files.
   - Existing `.Results` files are not replaced automatically.
- Step-by-step (to use `.txt` for BENCH-1)
   - 1. Recompile `NEW-BENCH-1` in Medley so `NEW-BENCH-1.LCOM` includes the new names.
   - 2. Run `./do-bench.sh bench-1`.
   - 3. Check `Results/BENCH-1/` for `AV-TAK.txt`, `IO.txt`, `PAV-ARITH.txt`.
   
### Group B: BENCH-5 runtime stability issue

- What happened
   - BENCH-5 can fail with stack overflow and force a hard reset/URAID prompt.
- Why
   - During BENCH-5 execution, stack usage can grow until Medley reports stack full.
- Error lines
   - `WARN: freestackblock:StackFull ...`
   - `Error Stack Overflow, MUST HARDRESET!`
   - `Enter the URaid`

### Group C: BENCH-2 known storage issue

- What happened
   - BENCH-2 can stop during TRIANG with storage exhaustion.
- Error line
   - `In IL: DOSTORAGEFULLINTERRUPT: Serious condition XCL: STORAGE-EXHAUSTED occurred.`

- Additional context
   - Starting VMem - 21%
   - End Vmem - 97%

## Project Layout

```text
do-bench.sh
README.md

tools/
   GABRIEL-TIMERS
   GABRIEL-TIMERS.LCOM
   GABRIEL-OTHER
   GABRIEL-OTHER.LCOM
   GABRIEL-TAK
   GABRIEL-TAK.LCOM

aux/
   1000-SYMBOLS
   2000-FLOATS-TO-READ

Benchmarks/
   BENCH-1/
      NEW-BENCH-1
      NEW-BENCH-1.LCOM
      TAK
      TAK.LCOM
      ARITH-BENCHMARKS
      ARITH-BENCHMARKS.LCOM
      IO-BENCHMARKS
      IO-BENCHMARKS.LCOM
   BENCH-2/
      NEW-BENCH-2
      NEW-BENCH-2.LCOM
      IO-BENCHMARKS
      IO-BENCHMARKS.LCOM
   BENCH-3/
      NEW-BENCH-3
      NEW-BENCH-3.LCOM
      IO-BENCHMARKS
      IO-BENCHMARKS.LCOM
   BENCH-4/
      NEW-BENCH-4
      NEW-BENCH-4.LCOM
      IO-BENCHMARKS
      IO-BENCHMARKS.LCOM
   BENCH-5/
      NEW-BENCH-5
      NEW-BENCH-5.LCOM
      IO-BENCHMARKS
      IO-BENCHMARKS.LCOM
      MISC-BENCHMARKS
      MISC-BENCHMARKS.LCOM

Results/
   BENCH-1/
   BENCH-2/
   BENCH-3/
   BENCH-4/
   BENCH-5/
```

## Environment (for reported issues)

- OS: macOS
- OS version: Tahoe 26.2
- Display/window system: X11
- Host arch: arm64
- Medley version: Venue Medley 2.0





