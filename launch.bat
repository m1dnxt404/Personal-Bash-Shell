@echo off
title DevShell

:: Launch bash with our custom config only — Git Bash is NOT affected.
:: --rcfile  : use our .bashrc instead of ~/.bashrc
:: -i        : interactive shell (enables aliases, prompt, etc.)
"C:\Program Files\Git\usr\bin\bash.exe" --rcfile "%~dp0config\.bashrc" -i
