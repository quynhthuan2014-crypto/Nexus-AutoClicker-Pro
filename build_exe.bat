@echo off
setlocal
clang --target=x86_64-pc-windows-msvc -fms-extensions -O2 -c NexusAutoClicker.c -o NexusAutoClicker.obj
if errorlevel 1 goto fail
lld-link /dll /noentry /machine:x64 /def:kernel32.def /out:kernel32_stub.dll /implib:kernel32.lib
if errorlevel 1 goto fail
lld-link /dll /noentry /machine:x64 /def:user32.def /out:user32_stub.dll /implib:user32.lib
if errorlevel 1 goto fail
lld-link /dll /noentry /machine:x64 /def:winmm.def /out:winmm_stub.dll /implib:winmm.lib
if errorlevel 1 goto fail
lld-link /machine:x64 /subsystem:windows /entry:WinMainCRTStartup /nodefaultlib /out:NexusAutoClicker_Pro.exe NexusAutoClicker.obj kernel32.lib user32.lib winmm.lib
if errorlevel 1 goto fail
echo Build complete: NexusAutoClicker_Pro.exe
exit /b 0
:fail
echo Build failed.
pause
exit /b 1
