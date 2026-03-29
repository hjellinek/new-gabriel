#!/bin/sh
#
# do-bench.sh
#
# Run one Gabriel benchmark suite in Medley with one command.
#
# Usage:
#   ./do-bench.sh bench-1
#   ./do-bench.sh bench-2
#   ./do-bench.sh bench-3
#   ./do-bench.sh bench-4
#   ./do-bench.sh bench-5
#
# Optional environment overrides:
#   PROJECTDIR=/path/to/New-Bench-Kabir
#   MEDLEYDIR=/path/to/medley
#   MEDLEY_LAUNCHER=/path/to/medley.command
#   DISPLAY=localhost:0

set -eu

die() {
    printf '%s\n' "$*" >&2
    exit 1
}

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
PROJECTDIR="${PROJECTDIR:-${SCRIPT_DIR}}"

if [ -z "${MEDLEYDIR:-}" ]
then
  die "Set MEDLEYDIR to your Medley install path, e.g. MEDLEYDIR=/path/to/medley ./do-bench.sh bench-1"
fi

TOOLSDIR="${PROJECTDIR}/tools"
RESULTSROOT="${PROJECTDIR}/Results"

DISPLAY=localhost:0
export DISPLAY
export MEDLEYDIR

SUITE="${1:-}"

[ -n "$SUITE" ] || die "Usage: ./do-bench.sh bench-1|bench-2|bench-3|bench-4|bench-5"

case "$SUITE" in
    bench-1)
        BENCHDIR="${PROJECTDIR}/Benchmarks/BENCH-1"
        RESULTSDIR="${RESULTSROOT}/BENCH-1"
        BENCHFILE="NEW-BENCH-1.LCOM"
        BENCHFN="IL:BENCH-1"

        [ -f "${TOOLSDIR}/GABRIEL-TIMERS.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-TIMERS.LCOM"
        [ -f "${TOOLSDIR}/GABRIEL-OTHER.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-OTHER.LCOM"
        [ -f "${TOOLSDIR}/GABRIEL-TAK.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-TAK.LCOM"
        [ -f "${BENCHDIR}/TAK.LCOM" ] || die "Missing ${BENCHDIR}/TAK.LCOM"
        [ -f "${BENCHDIR}/ARITH-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/ARITH-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/IO-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/IO-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/${BENCHFILE}" ] || die "Missing ${BENCHDIR}/${BENCHFILE}"

        LOADS='
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-TIMERS.LCOM)
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-OTHER.LCOM)
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-TAK.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/TAK.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/ARITH-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/IO-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/'"${BENCHFILE}"')
'
        ;;
    bench-2)
        BENCHDIR="${PROJECTDIR}/Benchmarks/BENCH-2"
        RESULTSDIR="${RESULTSROOT}/BENCH-2"
        BENCHFILE="NEW-BENCH-2.LCOM"
        BENCHFN="IL:BENCH-2"

        [ -f "${TOOLSDIR}/GABRIEL-TIMERS.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-TIMERS.LCOM"
        [ -f "${TOOLSDIR}/GABRIEL-OTHER.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-OTHER.LCOM"
        [ -f "${BENCHDIR}/IO-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/IO-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/${BENCHFILE}" ] || die "Missing ${BENCHDIR}/${BENCHFILE}"

        LOADS='
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-TIMERS.LCOM)
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-OTHER.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/IO-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/'"${BENCHFILE}"')
'
        ;;
    bench-3)
        BENCHDIR="${PROJECTDIR}/Benchmarks/BENCH-3"
        RESULTSDIR="${RESULTSROOT}/BENCH-3"
        BENCHFILE="NEW-BENCH-3.LCOM"
        BENCHFN="IL:BENCH-3"

        [ -f "${TOOLSDIR}/GABRIEL-TIMERS.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-TIMERS.LCOM"
        [ -f "${TOOLSDIR}/GABRIEL-OTHER.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-OTHER.LCOM"
        [ -f "${BENCHDIR}/IO-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/IO-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/${BENCHFILE}" ] || die "Missing ${BENCHDIR}/${BENCHFILE}"

        LOADS='
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-TIMERS.LCOM)
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-OTHER.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/IO-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/'"${BENCHFILE}"')
'
        ;;
    bench-4)
        BENCHDIR="${PROJECTDIR}/Benchmarks/BENCH-4"
        RESULTSDIR="${RESULTSROOT}/BENCH-4"
        BENCHFILE="NEW-BENCH-4.LCOM"
        BENCHFN="IL:BENCH-4"

        [ -f "${TOOLSDIR}/GABRIEL-TIMERS.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-TIMERS.LCOM"
        [ -f "${TOOLSDIR}/GABRIEL-OTHER.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-OTHER.LCOM"
        [ -f "${BENCHDIR}/IO-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/IO-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/${BENCHFILE}" ] || die "Missing ${BENCHDIR}/${BENCHFILE}"

        LOADS='
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-TIMERS.LCOM)
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-OTHER.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/IO-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/'"${BENCHFILE}"')
'
        ;;
    bench-5)
        BENCHDIR="${PROJECTDIR}/Benchmarks/BENCH-5"
        RESULTSDIR="${RESULTSROOT}/BENCH-5"
        BENCHFILE="NEW-BENCH-5.LCOM"
        BENCHFN="IL:BENCH-5"

        [ -f "${TOOLSDIR}/GABRIEL-TIMERS.LCOM" ] || die "Missing ${TOOLSDIR}/GABRIEL-TIMERS.LCOM"
        [ -f "${BENCHDIR}/MISC-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/MISC-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/IO-BENCHMARKS.LCOM" ] || die "Missing ${BENCHDIR}/IO-BENCHMARKS.LCOM"
        [ -f "${BENCHDIR}/${BENCHFILE}" ] || die "Missing ${BENCHDIR}/${BENCHFILE}"

        LOADS='
  (LOAD '"'"'{UNIX}'"${TOOLSDIR}"'/GABRIEL-TIMERS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/MISC-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/IO-BENCHMARKS.LCOM)
  (LOAD '"'"'{UNIX}'"${BENCHDIR}"'/'"${BENCHFILE}"')
'
        ;;
    *)
        die "Usage: ./do-bench.sh bench-1|bench-2|bench-3|bench-4|bench-5"
        ;;
esac

mkdir -p "${RESULTSDIR}"

logindir="/tmp/benchmarks-$$"
mkdir -p "${logindir}"
cmfile="${logindir}/hcfiles.cm"

cat >"${cmfile}" <<EOF
"

(PROGN
  (IL:MEDLEY-INIT-VARS 'IL:GREET)
  (SETQ SYSOUTGAG T)
  (IL:SETQ IL:*UPPER-CASE-FILE-NAMES* NIL)
  (IL:SETQ IL:NO-HELP NIL)

  (IL:PSEUDOHOST 'GABRIEL '{UNIX}${BENCHDIR}/)

${LOADS}

  (${BENCHFN}
    '{UNIX}${TOOLSDIR}/
    '{UNIX}${BENCHDIR}/
    '{UNIX}${RESULTSDIR}/)

  (IL:DRIBBLE)
  (IL:LOGOUT T)
)

"
EOF

if [ -d "${MEDLEYDIR}/loadups/build" ]
then
    touch "${MEDLEYDIR}/loadups/build/.skip"
fi

printf '%s\n' "Running ${SUITE}"
printf '%s\n' "  BENCHDIR   = ${BENCHDIR}"
printf '%s\n' "  RESULTSDIR = ${RESULTSDIR}"
printf '%s\n' "  CMFILE     = ${cmfile}"

/bin/sh "${MEDLEYDIR}/scripts/medley/medley.command" \
    --config - \
    --id bench_+ \
    --geometry 1024x768 \
    --noscroll \
    --logindir "${logindir}" \
    --greet - \
    --rem.cm "${cmfile}" \
    --apps