#!/bin/sh
# ocode installer for Linux / macOS
set -e
cd "$(dirname "$0")"
PY=python3
$PY -c 'import sys; sys.exit(0 if sys.version_info >= (3,9) else 1)' || { echo "ocode needs Python 3.9 or newer"; exit 1; }
echo "Installing ocode..."
$PY -m pip install --user --upgrade . 
for pkgs in "pillow av" "psutil" "sounddevice numpy faster-whisper" "discord.py"; do
  $PY -m pip install --user --upgrade $pkgs >/dev/null 2>&1 && echo "  + $pkgs" || echo "  - $pkgs: skipped"
done
$PY -m ocode doctor || true
echo
echo "Done. Open a new terminal and type:  ocode      (make sure ~/.local/bin is on your PATH)"
