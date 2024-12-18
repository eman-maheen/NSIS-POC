!include "MUI2.nsh"
!include "x64.nsh"

# Application Details
Name "My Test Program"
Caption "My Test Program Installer"
VIProductVersion "1.0.0.0"
VIAddVersionKey "ProductName" "My Test Program"
VIAddVersionKey "CompanyName" "Eman's company"
VIAddVersionKey "FileVersion" "1.0.0"
VIAddVersionKey "ProductVersion" "1.0.0"
VIAddVersionKey "FileDescription" "Test Program Installer"
VIAddVersionKey "LegalCopyright" "© 2024 Your Company Name. All rights reserved."

# Installer output and default installation directory
OutFile "..\TestProgram-Setup.exe"
InstallDir "$PROGRAMFILES64\MyTestProgram"
RequestExecutionLevel admin

# Modern UI Configuration
!define MUI_WELCOMEPAGE_TITLE "Welcome to My Test Program Installation"
!define MUI_WELCOMEPAGE_TEXT "This will install My Test Program on your computer."

# Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\license.txt"  # License file will be in deploy folder
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

# Language
!insertmacro MUI_LANGUAGE "English"

Section "Main Installation"
    # Set output directory for installation
    SetOutPath $INSTDIR

    # Install executable and DLLs from the bin directory
    File /r "..\bin\*.*"

    # Create shortcuts
    CreateDirectory "$SMPROGRAMS\MyTestProgram"
    CreateShortCut "$SMPROGRAMS\MyTestProgram\My Test Program.lnk" "$INSTDIR\test-project.exe"
    CreateShortCut "$DESKTOP\My Test Program.lnk" "$INSTDIR\test-project.exe"

    # Create uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    CreateShortCut "$SMPROGRAMS\MyTestProgram\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

    # Registry information for Add/Remove Programs
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyTestProgram" "DisplayName" "My Test Program"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyTestProgram" "UninstallString" "$INSTDIR\Uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyTestProgram" "DisplayVersion" "1.0.0"
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyTestProgram" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyTestProgram" "NoRepair" 1
SectionEnd

Section "Uninstall"
    # Remove installed files
    Delete "$INSTDIR\test-project.exe"
    Delete "$INSTDIR\*.dll"
    
    # Remove plugin directories
    RMDir /r "$INSTDIR\platforms"
    RMDir /r "$INSTDIR\iconengines"
    RMDir /r "$INSTDIR\imageformats"
    RMDir /r "$INSTDIR\styles"
    RMDir /r "$INSTDIR\networkinformation"
    RMDir /r "$INSTDIR\tls"

    # Remove shortcuts
    Delete "$SMPROGRAMS\MyTestProgram\My Test Program.lnk"
    Delete "$SMPROGRAMS\MyTestProgram\Uninstall.lnk"
    Delete "$DESKTOP\My Test Program.lnk"
    RMDir "$SMPROGRAMS\MyTestProgram"

    # Remove registry entries
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyTestProgram"

    # Remove installation directory
    RMDir /r "$INSTDIR"
SectionEnd
