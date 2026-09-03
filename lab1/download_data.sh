#!/usr/bin/env bash
# Downloads the mzML files and FASTA database for CB2110 Lab 2 (quantmsdiann)
# from the course Google Drive folder. Run this from inside the quantmsdiann
# Codespace terminal:
#
#   bash download_data.sh
#
set -euo pipefail

FOLDER_URL="https://drive.google.com/drive/folders/1OsKP8rRKaUSf-J7nXuglRH0CZAWcrNYs?usp=sharing"
DATA_DIR="data"

if ! command -v gdown &> /dev/null; then
  echo "Installing gdown..."
  pip install --quiet gdown || pip install --quiet --break-system-packages gdown
fi

mkdir -p "${DATA_DIR}"

echo "Downloading course data folder from Google Drive..."
gdown --folder -O "${DATA_DIR}" "${FOLDER_URL}"

echo "Done. Files in ${DATA_DIR}/:"
find "${DATA_DIR}" -type f -exec ls -lh {} \;
