#!/usr/bin/env bash
# Downloads the mzML files and FASTA database for CB2110 Lab 2 (quantmsdiann)
# from the course Google Drive folder. Run this from inside the quantmsdiann
# Codespace terminal:
#
#   bash download_data.sh
#
set -euo pipefail

FOLDER_URL="https://drive.google.com/drive/folders/1avWBun0Q9P-oE4yirmTj0ntmgXDkRhUg?usp=sharing"
DATA_DIR="data"

if ! command -v gdown &> /dev/null; then
  echo "Installing gdown..."
  pip install --quiet gdown
fi

mkdir -p "${DATA_DIR}"

echo "Downloading course data folder from Google Drive..."
gdown --fuzzy --folder --remaining-ok -O "${DATA_DIR}" "${FOLDER_URL}"

echo "Done. Files in ${DATA_DIR}/:"
find "${DATA_DIR}" -type f -exec ls -lh {} \;
