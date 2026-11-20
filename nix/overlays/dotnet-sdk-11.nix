# WORKAROUND (all platforms): .NET 11 GA SDK is not in nixpkgs-unstable yet.
#
# Repos pin `"version": "11.0.100"` with `allowPrerelease: false` in
# global.json. nixpkgs-unstable still ships 11.0.100-rc.3, so `dotnet` refuses
# to build them. nixpkgs master already has 11.0.100 GA.
#
# Expose the GA SDK as a separate attribute, sdk_11_0_ga, and use it only in
# the combined SDK (home-manager/shared.nix). Do not override sdk_11_0:
# - master's sdk_11_0 is source-built (VMR, needs Swift on darwin); take the
#   prebuilt sdk_11_0-bin instead.
# - overriding sdk_11_0 would rebuild everything built with it (roslyn-ls).
#
# TODO: when the warning below fires, remove this overlay and the
# nixpkgs-master input, and use sdk_11_0 again in home-manager/shared.nix.
nixpkgs-master: _final: prev:
let
  master = import nixpkgs-master {
    inherit (prev.stdenv.hostPlatform) system;
    config = prev.config;
  };
  unstableSdk = prev.dotnetCorePackages.sdk_11_0;
  unstableHasGa = !(prev.lib.hasInfix "-" unstableSdk.version);
in
{
  dotnetCorePackages = prev.dotnetCorePackages // {
    sdk_11_0_ga =
      prev.lib.warnIf unstableHasGa
        "overlays/dotnet-sdk-11.nix: nixpkgs-unstable has sdk_11_0 ${unstableSdk.version}; remove this overlay and the nixpkgs-master input."
        master.dotnetCorePackages.sdk_11_0-bin;
  };
}
