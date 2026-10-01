# WORKAROUND (aarch64-darwin): bicep does not build.
#
# Grpc.Tools ships only an x86_64 protoc and grpc_csharp_plugin for macOS (true
# up to at least 2.72.0; nixpkgs pins 2.68.1). Rosetta is not available in the
# Nix build sandbox, so the build stops with:
#   error MSB6003: ... tools/macosx_x64/protoc ... Bad CPU type in executable
#
# Grpc.Tools reads PROTOBUF_PROTOC and GRPC_PROTOC_PLUGIN before it falls back
# to its bundled binaries. Point both at the native nixpkgs builds.
#
# Linux is not affected (the bundled linux_x64 tools run, and the binary cache
# has bicep prebuilt), so keep this override off Linux to avoid a local rebuild.
#
# Because this override forces a local build on darwin, the test suite runs on
# the host. On macOS, .NET reads the current culture from the system region
# (here Norway, which uses a comma decimal separator) via Core Foundation, and
# ignores LANG/LC_ALL. The DeploymentRendererTests render a duration and assert
# the invariant form (e.g. "0.3s"), so they fail with "0,3s". Force invariant
# globalization for the CHECK phase only, via preCheck: dotnetCheckHook runs
# `dotnet test --no-build`, so the already-compiled tests pick up the runtime
# env var and format with a period. Do NOT set this for the whole build:
# DOTNET_SYSTEM_GLOBALIZATION_INVARIANT also makes the GeneratedRegex source
# generator fail (SYSLIB1042) at compile time.
#
# TODO: remove when nixpkgs builds bicep on aarch64-darwin.
final: prev:
  prev.lib.optionalAttrs prev.stdenv.hostPlatform.isDarwin {
    bicep = prev.bicep.overrideAttrs (_: {
      PROTOBUF_PROTOC = "${final.protobuf}/bin/protoc";
      GRPC_PROTOC_PLUGIN = "${final.grpc}/bin/grpc_csharp_plugin";
      preCheck = "export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1";
    });
  }