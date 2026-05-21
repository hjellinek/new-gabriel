#!/bin/sh
#
# do-bench.sh
#
# Run one Gabriel benchmark suite in Medley.
#
# Usage:
#   ./do-bench.sh bench-name bench-file bench-fn
#
# e.g.,
#   ./do-bench.sh "Tak" GABRIEL-TAK GABRIEL::TAK
#

set -eu

die() {
    printf '%s\n' "$*" >&2
    exit 1
}

[ "$#" -eq 3 ] || die "Usage: $0 bench-name bench-file bench-fn"

# The Name of the benchmark, human-readable
BENCHNAME="$1"
# The name of the benchmark file to load
BENCHFILE="$2"
# The name of the function to call.
BENCHFN="$3"

GABRIELDIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

TOOLSDIR="{GABRIEL}<tools>"
BENCHROOTDIR="{GABRIEL}<Benchmarks>"
RESULTSROOTDIR="{GABRIEL}<Results>"
DATADIR="{GABRIEL}<data>"
RESULTSDIR="${RESULTSROOTDIR}${BENCHNAME}>"

LOADS_SEXPR="(FILESLOAD (COMPILED) ${BENCHFILE})"

# Create the .cm file that will drive Medley
driverfiledir="/tmp/benchmarks-$$"
mkdir -p "${driverfiledir}"
cmfile="${driverfiledir}/benchmark.cm"
startfile="${driverfiledir}/start.lisp"

cat >"${startfile}" <<EOF
(PROGN
  (PSEUDOHOST 'GABRIEL "{DSK}${GABRIELDIR}")
  (MEDLEY-INIT-VARS 'GREET)
  (SETQ SYSOUTGAG T)
  (SETQ *UPPER-CASE-FILE-NAMES* NIL)
  (SETQ NO-HELP NIL)
  (SETQ *BENCHMARKS-DATA-DIR* "${DATADIR}")
  (SETQ *BENCHMARKS-TOOLS-DIR* "${TOOLSDIR}")
  (SETQ *BENCHMARKS-RESULTS-DIR* "${RESULTSDIR}")

  (PROGN
    (PUSHNEW DIRECTORIES "${TOOLSDIR}")
    (PUSHNEW DIRECTORIES "${BENCHROOTDIR}")
    ${LOADS_SEXPR})

  (${BENCHFN})

  (LOGOUT T)
)
STOP
EOF

cat >"${cmfile}" <<EOF
"
(LOAD '${startfile})
"
EOF


if [ -d "${MEDLEYDIR}/loadups/build" ]
then
    touch "${MEDLEYDIR}/loadups/build/.skip"
fi

printf '%s\n' "Running benchmarks"
printf '%s\n' "  BENCHROOTDIR   = ${BENCHROOTDIR}"
printf '%s\n' "  RESULTSDIR     = ${RESULTSDIR}"
printf '%s\n' "  CMFILE         = ${cmfile}"

/bin/sh "${MEDLEYDIR}/scripts/medley/medley.sh" \
    -m 256 \
    --config - \
    -ps 2 \
    --id bench_+ \
    --geometry 1024x768 \
    --noscroll \
    --logindir "${driverfiledir}" \
    --greet - \
    --rem.cm "${cmfile}" \
    --apps \
    -- \
    -timer 1000
