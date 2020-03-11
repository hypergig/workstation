#! /bin/bash
set -euo pipefail

mkdir -vp  ~/screenshots

[ "${1:-}" != "full" ] && geo="$(slurp -d)"
grim ${geo:+-g "${geo}"} ~/screenshots/$(date --iso-8601=sec | sed 's/\(:\|,\)/-/g').png
