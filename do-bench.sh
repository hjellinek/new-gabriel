#!/bin/sh
#
#  do_benchmark.sh
#
#  Script to run Gabriel benchmarks in Medley.
#
#  Call with the benchmark file name as the first argument and
#  the benchmark function to call as the second argument.  For example:
#
#  $ do_benchmark.sh NEW-BENCH-1.lcom IL:BENCH-1 "$toolsDir" "$benchmarksDir" "$resultsDir"
#
#  Copyright 2026 Interlisp.org.
#
SCRIPTDIR=$(cd "$(dirname "$0")" && pwd)
main() {
        MEDLEYDIR="/Users/kabirgupta/Documents/Interlisp/medley_folder/medley"
        export MEDLEYDIR

        PROJECTDIR="/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir"
        TOOLSDIR="${PROJECTDIR}/tools"
        BENCHDIR="${PROJECTDIR}/Benchmarks/BENCH-1"
        RESULTSDIR="${PROJECTDIR}/Results/BENCH-1"

        #Fixing error - Unable to open X11 display from DISPLAY
        DISPLAY=localhost:0
        export DISPLAY

        logindir=/tmp/benchmarks-$$
        mkdir -p "${logindir}"
        cmfile=${logindir}/hcfiles.cm

cat >"${cmfile}" <<EOF
"

(PROGN
  (IL:MEDLEY-INIT-VARS 'IL:GREET)
  (SETQ SYSOUTGAG T)
  (IL:SETQ IL:*UPPER-CASE-FILE-NAMES* NIL)
  (IL:SETQ IL:NO-HELP NIL)

  (IL:PSEUDOHOST 'GABRIEL '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/BENCH-1/)

  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/BENCHMARKS/BENCH-1/NEW-BENCH-1)

  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/BENCH-1/TAK.LCOM)

  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/tools/GABRIEL-TIMERS.LCOM)
  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/tools/GABRIEL-OTHER.LCOM)
  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/tools/GABRIEL-TAK.LCOM)
  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/BENCH-1/ARITH-BENCHMARKS.LCOM)
  (LOAD '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/BENCH-1/IO-BENCHMARKS.LCOM)

  ($2
    '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/tools/
    '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Benchmarks/BENCH-1/
    '{UNIX}/Users/kabirgupta/Documents/Interlisp/New-Bench-Kabir/Results/BENCH-1/)

  (IL:DRIBBLE)
  (IL:LOGOUT T)
)

"
EOF

        # Make sure loadups/build is not included in HCFILES
        if [ -d "${MEDLEYDIR}/loadups/build" ]
        then
          touch "${MEDLEYDIR}/loadups/build/.skip"
        fi

        /bin/sh "${MEDLEYDIR}/scripts/medley/medley.command"     \
             --config -                                          \
             --id bench_+                                        \
             --geometry 1024x768                                 \
             --noscroll                                          \
             --logindir "${logindir}"                            \
             --greet -                                           \
             --rem.cm "${cmfile}"                                \
             --apps

}

main "$@"