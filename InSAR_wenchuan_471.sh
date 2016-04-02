#!/bin/bash
#
#Purpose: Imaging the geocoded differential interferogram    
#Created by Bochen ZHANG @PolyU

ps1=1.ps

#gray
#echo "0 220 5000 220 " > dem_wc.cpt

# Change the default parameters 
gmtset ANNOT_FONT_SIZE_PRIMARY=9p FRAME_PEN=1.8P HEADER_FONT_SIZE=20p HEADER_FONT=19 ANNOT_FONT_SIZE=20p

#psbasemap -R104.5/107/29/33.5 -JM6i -B1/1:."Wenchuan":WSne -Gwhite -P -K -U"by Bochen ZHANG @@PolyU">$ps1
psbasemap -R104.5/107/29/33.5 -JM4.5i -B1/1:.:WSne -Gwhite -P -K>$ps1

grdimage srtm_57_06.nc -R -J -Cdem_wc.cpt  -Itif.grd.int1 -K -O -P >> $ps1
grdimage srtm_58_06.nc -R -J -Cdem_wc.cpt  -Itif.grd.int2 -K -O -P >> $ps1
grdimage srtm_57_07.nc -R -J -Cdem_wc.cpt  -Itif.grd.int3 -K -O -P >> $ps1
grdimage srtm_58_07.nc -R -J -Cdem_wc.cpt  -Itif.grd.int4 -K -O -P >> $ps1

gmtset  ANNOT_FONT_SIZE=18p

echo 105 29.2 104.85 30 | psxy -N -Svs -Gblack -J -R -K -O -W2p>> $ps1
echo 104.98 29.3 105.4 29.38 | psxy -N -Svs -Gblack -J -R -K -O -W2p >> $ps1

echo 104.85 29.25 15 100.35 0 5 Flight direction | pstext -R -J -O -K >>$ps1
echo 105.1 29.22 15 10.35 0 5 LOS | pstext -R -J -O -K >>$ps1

gmtset  ANNOT_FONT_SIZE=15p

psscale -D3.4i/8i/1.8i/0.13ih -Cgamma_displ.cpt -I0.4 -P -B1.57a3.14/:: -O -K>> $ps1

echo 105.9 33.1 14 0 0 5 LOS Phase Change| pstext -R -J -O -K >>$ps1
echo 106 33. 14 0 0 5 [11.8 cm/fringe] | pstext -R -J -O -K >>$ps1

#To make a file for illuminating

#grdgradient 471_dem.grd -A100 -G471dem.grd.int -Ne0.8 -V -M

#interferogram

grdimage  471_int.grd -R -JM -O -Q -I471dem.grd.int -Cgamma_displ.cpt  >>  $ps1

#
ps2raster -A -TG -E500 -W $ps1

#
rm -f .gmt* *.cpt 
