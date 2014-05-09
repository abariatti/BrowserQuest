@ECHO OFF 
set "BUILDDIR=..\client-build"
set "PROJECTDIR=..\client\js"
set CURDIR=%cd%

echo Deleting previous build directory

rmdir %BUILDDIR% /s /q

echo Building client with RequireJS
cd %PROJECTDIR%
node ../../bin/r.js -o build.js
cd %CURDIR%

echo Removing unnecessary js files from the build directory
cd %BUILDDIR%\js
mkdir .\temps 
mkdir .\temps\lib
copy game.js .\temps
copy home.js .\temps
copy .\lib\log.js .\temps\lib
copy .\lib\require-jquery.js .\temps\lib
copy .\lib\modernizr.js .\temps\lib
copy .\lib\css3-mediaqueries.js .\temps\lib
copy mapworker.js .\temps
copy detect.js .\temps
copy .\lib\underscore.min.js .\temps\lib
copy text.js .\temps
del *.* /Q
rmdir .\lib /s /q
xcopy .\temps\* .\. /S
rmdir .\temps /s /q

cd %CURDIR%

echo Removing sprites directory
rmdir %BUILDDIR%\sprites /s /q

echo Removing config directory
rmdir %BUILDDIR%\config /s /q

echo Moving build.txt to current dir
move %BUILDDIR%\build.txt %CURDIR%

echo Build complete