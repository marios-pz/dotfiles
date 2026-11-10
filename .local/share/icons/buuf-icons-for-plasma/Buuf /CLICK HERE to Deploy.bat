png2ico -i "thepngs" -o "thepngs" -s 16 32bpp -s 24 32bpp -s 32 32bpp -s 48 32bpp -s 72 32bpp -s 128 32bpp -noconfirm
DEL /F /Q /S "thepngs\*.png"
XCOPY "thepngs\*" ".\" /E /C /H /Q /Y /G /K /O
RMDIR /S /Q ".\thepngs"
DEL /F /Q ".\png2ico.exe"
Move /Y ".\png2ico.zip" ".\Extre\png2ico.zip"
DEL /F /Q ".\README FIRST!.txt"
DEL /F /Q ".\CLICK HERE to Deploy.bat"
