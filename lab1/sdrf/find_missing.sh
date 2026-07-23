#!/usr/bin/env bash
# Compare mzML filenames referenced in SDRF files against what's actually
# present in a directory.
#
# Usage:
#   ./find_missing.sh SRC_DIR [SDRF_DIR]

set -euo pipefail

SRC_DIR="${1:?Usage: $0 SRC_DIR [SDRF_DIR]}"
SDRF_DIR="${2:-.}"

SRC_DIR="$(cd "$SRC_DIR" && pwd)"
SDRF_DIR="$(cd "$SDRF_DIR" && pwd)"

# All unique mzML filenames referenced anywhere in the SDRFs
referenced=$(
    for sdrf in "$SDRF_DIR"/*.sdrf.tsv; do
        col=$(head -1 "$sdrf" | awk -F'\t' '{ for (i = 1; i <= NF; i++) if ($i == "comment[data file]") { print i; exit } }')
        [[ -z "$col" ]] && continue
        awk -F'\t' -v c="$col" 'NR>1 {print $c}' "$sdrf"
    done | sort -u
)

# All mzML files actually present in the directory
present=$(find "$SRC_DIR" -maxdepth 1 -type f -name '*.mzML' -printf '%f\n' | sort -u)

echo "Referenced in SDRF: $(echo "$referenced" | grep -c .)"
echo "Present in $SRC_DIR: $(echo "$present" | grep -c .)"
echo

echo "== MISSING (in SDRF, not in dir) =="
comm -23 <(echo "$referenced") <(echo "$present")

echo
echo "== EXTRA (in dir, not referenced by any SDRF) =="
comm -13 <(echo "$referenced") <(echo "$present")
