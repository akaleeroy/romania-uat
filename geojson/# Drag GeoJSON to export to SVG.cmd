@echo off

:start

start /b mapshaper ^
-i %1 ^
-proj EPSG:3844 ^
-style fill=none stroke="#aaa" ^
-o id-field="natcode" format=svg - ^
| svgo ^
-i - ^
--pretty ^
--indent=2 ^
--disable=cleanupIDs ^
--enable=removeDimensions ^
-o "%~n1.svg"

shift
if NOT x%1==x goto start
