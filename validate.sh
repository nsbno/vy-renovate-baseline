#!/bin/bash
set -eu -o pipefail

echo "Fetching latest JSON Schema"
curl -s https://docs.renovatebot.com/renovate-schema.json > renovate-schema.json

echo "Now validating.."
echo "Note: The logs for 'keywords ignored' can be ignored."

for x in $(ls -1 *.json *.json5 2>/dev/null | grep -v "^package.json$" | grep -v "^package-lock.json$" | grep -v "^renovate-schema.json$"); do
  if [[ "$x" == *.json5 ]]; then
    echo "Validating $x (converting from JSON5)"
    tmpfile=$(mktemp)
    npx json5 -c "$x" 2>/dev/null
    npx ajv --strict=false -s renovate-schema.json -d "${x%.json5}.json"
    rm -f "${x%.json5}.json"
  else
    echo "Validating $x"
    npx ajv --strict=false -s renovate-schema.json -d "$x"
  fi
done
