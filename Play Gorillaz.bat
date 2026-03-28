@echo off
setlocal

:: =========================================================================
:: GORILLAZ: FINAL DRIVE - PORTABLE LAUNCHER
:: Fixes crashes and lockups on modern Windows (10/11) without needing
:: administrator privileges, registry edits, or system-wide DEP changes.
:: =========================================================================

:: Fix 1: Localize the Temp folder.
:: Director 8.5 extracts engine files to the TEMP directory. Modern 
:: Windows Temp paths are often too long or contain unsupported characters.
if exist "%~dp0GameTemp" rd /s /q "%~dp0GameTemp"
mkdir "%~dp0GameTemp"
set "TEMP=%~dp0GameTemp"
set "TMP=%~dp0GameTemp"

:: Fix 2: Force Shockwave 3D onto DirectX 7 for the most stable renderer path.
reg add "HKCU\Software\Macromedia\Shockwave 8\renderer3dsetting" /ve /t REG_SZ /d 4 /f >nul

:: Fix 3: Spoof Windows 98 and force DEP Disable. 
:: This explicitly disables NX (Data Execution Prevention) for the process.
set "__COMPAT_LAYER=WIN98 DisableNXShowUI"

:: Fix 4: CPU Affinity.
:: Older Shockwave engines have severe race conditions on multi-core CPUs.
:: This forces the game to run only on CPU 0 to prevent DIRAPI.dll freezes.
echo Booting Gorillaz Final Drive...
start "Gorillaz" /affinity 1 "gorillaz_final_drive.exe"
