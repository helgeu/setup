#!/usr/bin/env bash
set -euo pipefail

# test-commit-rules.sh - Test the WhatWhy commit message rules.
#
# Each file in tests/commits has a first line "# expect: <rules>", where
# <rules> is "pass" or a space-separated list of WhatWhy rule names. The
# test runs Vale with only the WhatWhy style and the Commit View, and
# compares the rules that fire with the expected rules. The Commit View
# skips comment lines, so the expect line does not change the result.
#
# The Commit View comes from the installed Vale styles (~/.config/vale),
# and the WhatWhy rules come from this repository, so the test checks the
# rules before a nix switch.
#
# Usage: nix/vale/tests/test-commit-rules.sh
# Exit code: 1 when at least one fixture fails, else 0.

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STYLES_SRC="$HERE/../styles/WhatWhy"
INSTALLED="${VALE_STYLES:-$HOME/.config/vale/styles}"

[ -d "$INSTALLED/config/views" ] || { echo "error: no Commit View in $INSTALLED (run the nix switch once)" >&2; exit 2; }

WORK="$(mktemp -d)"
trap 'chmod -R u+w "$WORK"; rm -rf "$WORK"' EXIT
mkdir -p "$WORK/styles"
mkdir -p "$WORK/styles/config"
cp -RL "$INSTALLED/config/views" "$WORK/styles/config/views"
cp -R "$STYLES_SRC" "$WORK/styles/WhatWhy"
cat > "$WORK/test.ini" <<'EOF'
StylesPath = styles
MinAlertLevel = suggestion

[COMMIT_EDITMSG]
BasedOnStyles = WhatWhy
View = Commit
EOF

FAIL=0
TOTAL=0
for f in "$HERE"/commits/*.txt; do
  TOTAL=$((TOTAL + 1))
  expect="$(sed -n '1s/^# expect: //p' "$f")"
  [ "$expect" = "pass" ] && expect=""
  expect="$(printf '%s\n' $expect | sort -u | tr '\n' ' ' | sed 's/ *$//')"
  out="$(vale --config="$WORK/test.ini" --path=COMMIT_EDITMSG --output=line < "$f" 2>&1)" || true
  if printf '%s' "$out" | grep -qv '^COMMIT_EDITMSG:' && [ -n "$out" ]; then
    echo "ERROR $(basename "$f"): vale failed: $out"
    FAIL=$((FAIL + 1))
    continue
  fi
  got="$(printf '%s\n' "$out" | awk -F: 'NF >= 4 { print $4 }' | sort -u | tr '\n' ' ' | sed 's/ *$//')"
  if [ "$got" = "$expect" ]; then
    echo "ok    $(basename "$f")"
  else
    echo "FAIL  $(basename "$f"): expected [${expect}] got [${got}]"
    printf '%s\n' "$out" | sed 's/^/        /'
    FAIL=$((FAIL + 1))
  fi
done

echo "$((TOTAL - FAIL))/$TOTAL fixtures pass."
[ "$FAIL" -eq 0 ]
