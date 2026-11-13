; Independent Harbor Windows installer. Build with build-installer.ps1.
#ifndef PayloadDir
  #error PayloadDir must name a staged distribution
#endif
#ifndef OutputDir
  #error OutputDir must name the installer output directory
#endif
#ifndef AppVersion
  #error AppVersion must come from the workspace version
#endif
[Setup]
AppId=io.durtyrobbin.harbor-studio
AppName=Harbor Studio
AppVersion={#AppVersion}
AppPublisher=Harbor contributors
AppPublisherURL=https://github.com/durtyrobbin/harbor-studio
AppSupportURL=https://github.com/durtyrobbin/harbor-studio/issues
DefaultDirName={localappdata}\Programs\Harbor\Harbor-Studio
DefaultGroupName=Harbor
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
UninstallDisplayName=Harbor Studio
UninstallDisplayIcon={app}\Harbor.ico
SetupIconFile=..\..\assets\harbor\icon.ico
OutputDir={#OutputDir}
OutputBaseFilename=Harbor-Studio-{#AppVersion}-windows-x64-setup
Compression=lzma2/fast
SolidCompression=yes
WizardStyle=modern
CloseApplications=no
RestartApplications=no
ChangesAssociations=yes
[Tasks]
Name: desktopicon; Description: "Create a desktop shortcut"; Flags: checkedonce
[Files]
Source: "{#PayloadDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
[Icons]
Name: "{group}\Harbor Studio"; Filename: "{app}\Harbor-Studio.exe"; WorkingDir: "{app}"; IconFilename: "{app}\Harbor.ico"; AppUserModelID: "io.durtyrobbin.harbor-studio"
Name: "{autodesktop}\Harbor Studio"; Filename: "{app}\Harbor-Studio.exe"; WorkingDir: "{app}"; IconFilename: "{app}\Harbor.ico"; AppUserModelID: "io.durtyrobbin.harbor-studio"; Tasks: desktopicon
Name: "{group}\Harbor Vector (via Studio)"; Filename: "{app}\Harbor-Studio.exe"; WorkingDir: "{app}"; IconFilename: "{app}\Harbor.ico"; AppUserModelID: "io.durtyrobbin.harbor-studio"; Comment: "Choose New painting, then Harbor Vector"
Name: "{autodesktop}\Harbor Vector (via Studio)"; Filename: "{app}\Harbor-Studio.exe"; WorkingDir: "{app}"; IconFilename: "{app}\Harbor.ico"; AppUserModelID: "io.durtyrobbin.harbor-studio"; Comment: "Choose New painting, then Harbor Vector"; Tasks: desktopicon
[Registry]
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\App Paths\Harbor-Studio.exe"; ValueType: string; ValueName: ""; ValueData: "{app}\Harbor-Studio.exe"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\App Paths\Harbor-Studio.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}"
; No wildcard UninstallDelete: user-created settings, recovery and documents remain.
