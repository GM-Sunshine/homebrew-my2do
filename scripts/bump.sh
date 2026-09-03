#!/usr/bin/env bash
# Bump Formula/my2do.rb to the current live CLI version + sha256.
# Run this whenever you release a new CLI version, then commit + push the tap.
set -euo pipefail

URL="${MY2DO_CLI_URL:-https://my2do.app/cli/my2do}"
DIR="$(cd "$(dirname "$0")/.." && pwd)"
FORMULA="$DIR/Formula/my2do.rb"

tmp="$(mktemp)"
trap 'rm -f "$tmp" "$tmp.bak"' EXIT

echo "Fetching $URL …"
curl -fsSL "$URL" -o "$tmp"
head -1 "$tmp" | grep -q '#!/usr/bin/env bash' || { echo "unexpected download; aborting" >&2; exit 1; }

# Version is read from the script itself (not executed).
ver="$(grep -m1 -oE 'VERSION="[^"]+"' "$tmp" | sed -E 's/VERSION="(.*)"/\1/')"
[ -n "$ver" ] || { echo "could not read VERSION from CLI" >&2; exit 1; }

if command -v sha256sum >/dev/null 2>&1; then
  sha="$(sha256sum "$tmp" | awk '{print $1}')"
else
  sha="$(shasum -a 256 "$tmp" | awk '{print $1}')"
fi

sed -E -i.bak \
  -e "s|^  version \"[^\"]+\"|  version \"$ver\"|" \
  -e "s|^  sha256 \"[^\"]+\"|  sha256 \"$sha\"|" \
  "$FORMULA"
rm -f "$FORMULA.bak"

echo "Bumped my2do → version $ver, sha256 $sha"
echo "Now: git -C \"$DIR\" commit -am \"my2do $ver\" && git -C \"$DIR\" push"
