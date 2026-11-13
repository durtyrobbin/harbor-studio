# Harbor Studio Windows installer

Build the independent x64 setup with Inno Setup 7.1.1 (or a compatible newer compiler):

```powershell
./packaging/harbor/build-installer.ps1 -PayloadDirectory E:/path/to/Harbor-Studio -OutputDirectory E:/path/to/installers -IsccPath E:/tools/InnoSetup/ISCC.exe
```

The payload is the prepared Harbor distribution, including its license notices. The version comes from `[workspace.package]` in Cargo.toml. Build output and a unique staged payload stay under OutputDirectory. The builder rejects reparse points and excludes runtime settings/recovery folders. No application binaries or setup executables are committed to Git.

Setup installs for the current user into `%LOCALAPPDATA%/Programs/Harbor/Harbor-Studio`. It registers Windows Installed apps/uninstall metadata, App Paths, Start Menu and optional desktop shortcuts with the Harbor icon and AppUserModelID. It does not change file associations, start background services, close applications automatically, or use upstream update channels. Close the app before upgrading if its executable is in use.

Uninstall removes only installer-owned files and registration. User-generated `HarborStudioData` settings, recovery files and documents are retained. The prepared PDF/Paint payload includes portable.txt; Studio already stores settings beside its executable. Keep the stable AppId for future upgrades.

Setup executables are unsigned development builds. This packaging does not change the feature limitations in HARBOR-QUALIFICATION.md. An installer alone does not guarantee a healthy Windows Search index; verify Start discovery after installation.

Harbor Vector is hosted by Studio. Its clearly labeled shortcut opens Studio; choose New painting, then Harbor Vector. There is no separately installed Vector binary.
