# Limite Unități Administrativ-Teritoriale România

## Date geografice

De la @geospatialorg

~~[geo-spatial.org - România - seturi de date vectoriale generale > Limitele unităților administrative din România](http://www.geo-spatial.org/download/romania-seturi-vectoriale#uat)~~

Fișier sursă ~~[**GeoJSON poligon 20.12.2019**](http://www.geo-spatial.org/file_download/29535)~~  
<small>Size: 189 MB (198,546,274 bytes)</small>  
<small>MD5 checksum: A04BAA4CDF93E93A169EF77EAE31469C</small>
<small>Size (GZipped): 57.3 MB (60,088,360 bytes)</small>  

## Unelte

[mapshaper](https://mapshaper.org/)

`npm install -g mapshaper`

[Command Reference · mbloch/mapshaper Wiki](https://github.com/mbloch/mapshaper/wiki/Command-Reference)

`npm install -g svgo`

[svg/svgo: Node.js tool for optimizing SVG files](https://github.com/svg/svgo)

## Procesare

### Împărțire pe județe

```bat
mapshaper ro_uat_poligon.geojson name="" -simplify 0.009 -split countyMn -o format=geojson
```

✓ Simplificare `9%` folosind algoritmul implicit `weighted Visalingam simplification`

### Conversie SVG

`geojson\# Drag GeoJSON to export to SVG.cmd` ↓

```bat
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
-o "%~n1.svg"

shift
if NOT x%1==x goto start

```

✓ Proiecție: `EPSG:3844` - Pulkovo 1942(58) / Stereo70 - Projected  
✓ Fiecare UAT e un `<path>`;  
✓ Un singur grup `<g>` top-level  
✓ Fără lufturi / margini  
✓ SIRUTA: `id="7767"` natcode = Codul SIRUTA al unitații administrative  
✓ Nume localitate: `data-name="Stremț"`  
✓ Tip localitatate: `class="comuna"`  
✓ Responsiv: SVGO `removeDimensions`  

### Metadate adiționale

Pentru selecție mai rapidă înlocuim în toate SVG-urile după export `data-type` → `class`

```xml
<path d="M519.349..." id="7767" data-name="Stremț" class="comuna"/>
```

```js
// natLevName mappings
type = {
  'Oras': 'oras',
  'Comuna': 'comuna',
  'Municipiu, altul decat resedinta de judet': 'municipiu',
  'Municipiu resedinta de judet': 'municipiu resedinta',
  'Sectoarele municipiului Bucuresti': 'sector'
}[natLevName]
```

## Extra

Afișează proprietățile unui fișier GIS cu comanda: 

```sh
mapshaper alba-uat-poligon.geojson -info
```

Proiecții:

- ✓ **EPSG:3844** - Pulkovo 1942(58) / Stereo70 - Projected
- ✓ **webmercator**
- ✗ **UTM** apare rotit
- ✗ **wgs84** apare lat

Reference: [Export topojson from Mapshaper with an ID field that is a composite created from multiple fields - Geographic Information Systems Stack Exchange](https://gis.stackexchange.com/questions/233438/export-topojson-from-mapshaper-with-an-id-field-that-is-a-composite-created-from)

Tutorial: [Elections Data – Spatial Perspectives in QGIS 3.8.3 – Map The Clouds](https://blog.maptheclouds.com/tutorials/spatial-perspective-elections)

## TODO

- [ ] NodeJS script instead of batch script
- [ ] `<g>` add property `region`?

<!-- 
```css
.comuna { fill: aliceblue }
.oras { fill: hotpink }
.municipiu { fill: rebeccapurple }
.resedinta { fill: red }
.sector { fill: bisque }
```
-->
