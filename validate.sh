#!/bin/bash
set -eu -o pipefail

echo "Fetching latest JSON Schema"
curl -s https://docs.renovatebot.com/renovate-schema.json > renovate-schema.json

echo "Now validating.."
echo "Note: The logs for 'keywords ignored' can be ignored."

for x in $(ls -1 *.json *.json5 2>/dev/null | grep -v "^package.json$" | grep -v "^package-lock.json$" | grep -v "^renovate-schema.json$"); do
  echo "Validating $x"
  tmpfile=$(mktemp).json
  npx json5 -o "$tmpfile" "$x"
  npx ajv --strict=false -s renovate-schema.json -d "$tmpfile"
  rm -f "$tmpfile"
done
