# Goal: upgrade a repo from .NET 10 to .NET 11 (C# 15)

Use this file as input to an AI agent. Run it in one target repo at a time.

## Goal

Move the repo from `net10.0` to `net11.0` (C# 15 is the default language version).
Keep the behavior the same. Build, tests and analyzers must pass locally.

## Context

- .NET 11 GA: November 2026 (launch at .NET Conf, November 10-13, 2026).
- .NET 11 is STS (24 months of support). .NET 10 stays the LTS.
- The .NET 11 SDK comes from the nix setup (`sdk_11_0` in
  `~/git/github/setup/nix/home-manager/shared.nix`). Do not install SDKs ad hoc.
  If `dotnet --list-sdks` shows no `11.0.*` SDK, stop and report.

## Rules for the agent

- Start on a fresh branch from the updated default branch: `chore/dotnet-11-upgrade`.
- Change only what the upgrade requires. Do not refactor and do not adopt new
  C# 15 features in this change.
- Commit each working step (Conventional Commits).
- Run build, tests, formatter and analyzers (SonarCloud rules, Roslynator)
  locally before you push. See `~/.claude/dotnet-reference.md`.
- Report each behavioral breaking change that applies, with file and line, and
  the decision you made.

## Steps

Follow the official skill: [dotnet/skills - migrate-dotnet10-to-dotnet11](https://github.com/dotnet/skills/blob/main/plugins/dotnet-upgrade/skills/migrate-dotnet10-to-dotnet11/SKILL.md).

1. **Baseline.** Run `dotnet --version` to confirm the SDK. Do a clean build
   (`dotnet build --no-incremental`) and run the tests on `net10.0`. Record the
   current warnings and test results.
2. **Find the technology areas.** Look at SDK attributes (`Microsoft.NET.Sdk.Web`),
   package references (EF Core, SqlClient, OpenApi), Dockerfiles, and use of
   `BackgroundService`, compression, TAR, crypto and `DateOnly`/`TimeOnly` parsing.
3. **Update the SDK pin.** If `global.json` exists, set `sdk.version` to the
   installed 11.0.x SDK.
4. **Update the TFM.** Change `<TargetFramework>net10.0</TargetFramework>` to
   `net11.0` in every `.csproj`, or once in `Directory.Build.props`. For
   multi-targeted projects, add or replace in `<TargetFrameworks>`.
5. **Update packages.** Set all `Microsoft.AspNetCore.*`,
   `Microsoft.EntityFrameworkCore.*`, `Microsoft.Extensions.*` and
   `System.Net.Http.Json` packages to 11.0.x. With Central Package Management,
   change `Directory.Packages.props`. Also update analyzer packages so they
   support C# 15.
6. **Update container images.** Change `mcr.microsoft.com/dotnet/*:10.0` base
   images to `11.0`.
7. **Update CI.** Change the SDK version in pipeline files (`UseDotNet@2`,
   `actions/setup-dotnet`) to `11.0.x`.
8. **Restore, build, test.** Fix compile errors and new warnings. Do not
   suppress new warnings without a reason.
9. **Review behavioral changes** (see the list below). They compile but change
   runtime behavior.
10. **Verify.** Run the full local checks again, and compare with the baseline.

## Breaking changes to check

Full lists:

- [Breaking changes in .NET 11](https://learn.microsoft.com/en-us/dotnet/core/compatibility/11)
- [C# compiler breaking changes (.NET 11)](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/breaking-changes/compiler%20breaking%20changes%20-%20dotnet%2011)
- [Migrate ASP.NET Core from .NET 10 to .NET 11](https://learn.microsoft.com/en-us/aspnet/core/migration/100-to-110)

Hotspots for typical C# backends:

| Area | Change | Action |
| --- | --- | --- |
| Hosting | An unhandled exception in `BackgroundService.ExecuteAsync` now stops the host. | Find all `BackgroundService` types. Add try/catch where the service must not stop the app. |
| SqlClient | `Microsoft.Data.SqlClient` 7.0 moves Entra ID auth out of the core package. | If you use Entra ID / managed identity, add `Microsoft.Data.SqlClient.Extensions.Azure`. |
| OpenAPI | `Microsoft.AspNetCore.OpenApi` now uses `Microsoft.OpenApi` 3.x. The object model changes. | Update custom document, operation and schema transformers. |
| ASP.NET Core | Automatic CSRF protection middleware is on by default. | Check form endpoints and explicit `AddAntiforgery`/`UseAntiforgery` calls. JSON endpoints do not change. |
| Parsing | `DateOnly`/`TimeOnly` `TryParse` methods throw for invalid input. | Find all calls. Check what input they get. |
| Math | `Math.Round`/`MathF.Round` and decimal/BigInteger conversions are correctly rounded. Results can change. | Check money and rounding code, and tests with exact values. |
| Compression | ZIP reads validate CRC32. Deflate/GZip write headers for empty payloads. TAR checks header checksums. | Check code that reads external archives or checks output length. |
| Certificates | AIA download of intermediate CAs is off for client-certificate validation. | Install the full chain, or make clients send intermediates. |
| Crypto | DSA throws on macOS. | Use RSA or ECDSA. |
| NuGet | Restore does not search the global packages folder for a higher version. | Fix restore errors with explicit versions. |
| SDK | `dnx` scripts bypass `global.json`. VSTest no longer depends on Newtonsoft.Json. | Add an explicit `Newtonsoft.Json` reference if tests used it through VSTest. |
| Hardware | x86/x64 baseline is now `x86-64-v2`. | Check old build agents and hosts. |
| Compiler | Span collection expressions use declaration-block safe-context. `nameof(this.X)` in attributes is an error. | Fix the compile errors as the compiler reports them. |
| Blazor | `Virtualize.OverscanCount` default changes from 3 to 15. QuickGrid keeps state in the URL. | Set the old values if you need them. |
| EF Core | `SqlVector<T>` is not loaded in SELECT by default. SQLitePCLRaw encryption bundles are removed. | Use explicit projections. Change the SQLCipher setup. |

## Done criteria

- All projects target `net11.0`. `global.json`, Docker images and CI use SDK 11.
- Microsoft packages are on 11.0.x.
- Clean build with no new warnings compared to the baseline.
- All tests pass. Analyzers pass locally.
- A short report lists each applicable behavioral change and the decision for it.

## Reference

- [What's new in .NET 11](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-11/overview)
- [What's new in C# 15](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-15)
- [What's new in ASP.NET Core in .NET 11](https://learn.microsoft.com/en-us/aspnet/core/release-notes/aspnetcore-11)
- [.NET Conf 2026 agenda](https://dotnet.microsoft.com/en-us/conf/2026/agenda)
