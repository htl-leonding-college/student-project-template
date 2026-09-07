#!/usr/bin/env bash
# Baut docs/ lokal zur Website — dieselben Schritte wie die Pipeline.
set -euo pipefail
cd "$(dirname "$0")"

IMAGE="asciidoctor/docker-asciidoctor:1.83"
OUT="build/site"

rm -rf "$OUT" && mkdir -p "$OUT"
cp -R docs/* "$OUT/"

docker run --rm -u "$(id -u):$(id -g)" -e HOME=/tmp \
  -v "${PWD}:/documents" -w /documents "$IMAGE" \
  asciidoctor -r asciidoctor-diagram -a toc=left -a icons=font \
    -a source-highlighter=rouge "$OUT"/*.adoc

echo "fertig: $OUT/index.html"
