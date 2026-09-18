# WORKAROUND (all platforms): opencode server error after sending a prompt.
#
# Bun 1.4.x regressed compiled-executable code splitting. The opencode binary
# that Bun produces crashes at runtime with:
#   TypeError: undefined is not an object (evaluating 'a.name')
# which the TUI surfaces as "Failed to send prompt / Unexpected server error".
#
# Upstream fix (nixpkgs PR #564101, issue #563241) builds opencode with
# `splitting: false`. That fix is on nixpkgs master but has not reached the
# nixpkgs-unstable channel yet, so this overlay applies the exact same patch to
# the pinned opencode. It mirrors the upstream postPatch step verbatim.
#
# TODO: remove once nixpkgs-unstable ships opencode with splitting disabled
# (opencode >= 1.18.31, or the 1.18.30 rebuild from PR #564101).
final: prev: {
  opencode = prev.opencode.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        substituteInPlace packages/opencode/script/build.ts \
          --replace-fail 'splitting: true,' 'splitting: false,'
      '';
  });
}