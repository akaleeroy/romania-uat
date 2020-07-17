@echo off

:start

start /b mapshaper ^
-i %1 ^
-each "type = { 'Oras': 'oras', 'Comuna': 'comuna', 'Municipiu, altul decat resedinta de judet': 'municipiu', 'Municipiu resedinta de judet': 'municipiu resedinta', 'Sectoarele municipiului Bucuresti': 'sector'}[natLevName]" ^
-proj EPSG:3844 ^
-style fill=none stroke="#aaa" ^
-o svg-data=name,type id-field=natcode format=svg - ^
| svgo ^
-i - ^
--pretty ^
--indent=2 ^
--disable=cleanupIDs ^
--enable=removeDimensions ^
-o "svg/%~n1.svg"

shift
if NOT x%1==x goto start
