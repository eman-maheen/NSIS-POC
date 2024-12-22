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
VIAddVersionKey "LegalCopyright" " 2024 Your Company Name. All rights reserved."

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

# Function to check if Visual C++ Redistributable is installed
Function CheckVCRedist
    # Check if Visual C++ Redistributable is already installed
    ReadRegDword $R0 HKLM "SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" "Installed"
    ${If} $R0 != "1"
        DetailPrint "Installing Visual C++ Redistributable..."
        ExecWait '"$INSTDIR\VC_redist.x64.exe" /quiet /norestart' $0
        ${If} $0 != "0"
            MessageBox MB_OK|MB_ICONEXCLAMATION "Failed to install Visual C++ Redistributable. The program may not work correctly."
        ${EndIf}
    ${Else}
        DetailPrint "Visual C++ Redistributable is already installed."
    ${EndIf}
FunctionEnd

Section "Main Installation"
    # Set output directory for installation
    SetOutPath $INSTDIR

    # Copy VC++ Redistributable installer
    File "..\VC_redist.x64.exe"
    
    # Install Visual C++ Redistributable if needed
    Call CheckVCRedist
    
    # Delete VC++ Redistributable installer after installation
    Delete "$INSTDIR\VC_redist.x64.exe"

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
