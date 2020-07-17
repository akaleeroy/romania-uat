@echo off

:start

start /b mapshaper ^
-i %1 ^
name="judete" ^
-proj EPSG:3844 ^
-style fill=none stroke="#aaa" ^
-o svg-data=name,countycode,region id-field=mnemonic format=svg - ^
| svgo ^
-i - ^
--pretty ^
--indent=2 ^
--disable=cleanupIDs ^
--enable=removeDimensions ^
-o "%~n1.svg"

shift
if NOT x%1==x goto start
