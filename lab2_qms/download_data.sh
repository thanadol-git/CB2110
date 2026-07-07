#!/usr/bin/env bash
# Downloads the mzML files and FASTA database for CB2110 Lab 2 (quantmsdiann).
# Fill in MZML_URLS and FASTA_URL below with your course-hosted direct-download
# links, then run this script from inside the quantmsdiann Codespace terminal:
#
#   bash download_data.sh
#
set -euo pipefail

# TODO(instructor): replace with the real direct-download links (course server/Drive/S3).
MZML_URLS=(
  "https://example.com/path/to/sample1.mzML"
  "https://example.com/path/to/sample2.mzML"
)
FASTA_URL="https://example.com/path/to/proteins.fasta"

DATA_DIR="data"
mkdir -p "${DATA_DIR}"

for url in "${MZML_URLS[@]}"; do
  fname="$(basename "${url}")"
  echo "Downloading ${fname}..."
  curl -fL --retry 3 -o "${DATA_DIR}/${fname}" "${url}"
done

echo "Downloading $(basename "${FASTA_URL}")..."
curl -fL --retry 3 -o "${DATA_DIR}/$(basename "${FASTA_URL}")" "${FASTA_URL}"

echo "Done. Files in ${DATA_DIR}/:"
ls -lh "${DATA_DIR}"
