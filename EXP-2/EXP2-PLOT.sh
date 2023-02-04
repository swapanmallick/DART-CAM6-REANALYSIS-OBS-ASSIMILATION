#!/bin/sh
#################################################################
#  CMCC DART OBS-SEQ_OUT FILE PLOTS
#  Author Dr. Swapan Mallick
#  Date 28 JUNE 2022 at CMCC
#################################################################
#
EXP=exp14init
YYYY=2017
MONTH=10
SM_MONTH="OCTOBER 2017"
##SM_MONTH="OCTOBER-NOVEMBER 2017"
WRKDIR=/work/csp/sm09722/OBS_STAT/${EXP}_${YYYY}_ERROR
PDF_PLOTS=/work/csp/sm09722
SCRIPT=/users_home/csp/sm09722/EXP-2
#
mkdir -p ${PDF_PLOTS}
echo ${WRKDIR}
cd ${WRKDIR}
rm -rf *.png
#
ln -sf ${SCRIPT}/LINE_PLOT_ERROR_NH1.py ./
ln -sf ${SCRIPT}/LINE_PLOT_ERROR_NH3.py ./
ln -sf ${SCRIPT}/LINE_PLOT_ERROR_SH1.py ./
ln -sf ${SCRIPT}/LINE_PLOT_ERROR_SH3.py ./
ln -sf ${SCRIPT}/LINE_PLOT_ERROR_EQ1.py ./
ln -sf ${SCRIPT}/LINE_PLOT_ERROR_EQ3.py ./
#
echo ${SM_MONTH}
for UTC in 00; do
##for UTC in 00 06 12 18 ; do
#
#-------------PLOT TYPES OF OBSERVATION----------
#
for TYPE_PLOT in SATWIND_U_WIND  ; do
##for TYPE_PLOT in AIRCRAFT_V_WIND  ; do
##for TYPE_PLOT in LAND_SFC_ALTIMETER MARINE_SFC_ALTIMETER RADIOSONDE_U_WIND RADIOSONDE_V_WIND RADIOSONDE_TEMP AIRCRAFT_U_WIND AIRCRAFT_V_WIND AIRCRAFT_TEMP SATWIND_U_WIND SATWIND_V_WIND GPSRO_REFRACTIVITY AIRS_BT AMSU-CH8 AMSU-CH9 AMSU-CH10 AMSU-CH11 AMSU-CH12 AMSU-CH13 AMSU-CH14 ; do
#
#----------------PLOTS-------------------
#---------LOOP OVER THREE REGION-----
#---NORTH, SOUTH , TROPIC-----
#
for RIG in NH SH EQ ; do
#
cp ${TYPE_PLOT}_ERR${RIG}${UTC}.txt ERR.txt
sed "s/nan/00/g" ERR.txt > ERR1.txt
#-----------------------------------------------
#---------------ERROR, RMSE, SD PLOTS----------------------
#-----------------------------------------------
sed "s/FORTNO/${TYPE_PLOT}/g" LINE_PLOT_ERROR_${RIG}1.py > aa.py
sed "s/SMUTC1/${UTC}/g" aa.py > bb.py
sed "s/MM_SM/${SM_MONTH}/g" bb.py > cc.py
sed "s/SMUTC/${UTC}/g" cc.py > dd.py
python dd.py
echo ${WRKDIR}
rm -rf aa.py bb.py cc.py dd.py
#
rm -rf AA1_${TYPE_PLOT}_ERROR_${RIG}.png
mv AA1_LINE_ERROR_${RIG}.png ${RIG}AA1_${TYPE_PLOT}_ERROR_${RIG}.png
#-----------------------------------------------
#--------------- OI EDI PLOTS--------------------------------
#-----------------------------------------------
sed "s/FORTNO/${TYPE_PLOT}/g" LINE_PLOT_ERROR_${RIG}3.py > aa.py
sed "s/SMUTC1/${UTC}/g" aa.py > bb.py
sed "s/MM_SM/${SM_MONTH}/g" bb.py > cc.py
sed "s/SMUTC/${UTC}/g" cc.py > dd.py
python dd.py
echo ${WRKDIR}
rm -rf aa.py bb.py cc.py dd.py
rm -rf AA3_${TYPE_PLOT}_ERROR_${RIG}.png
mv AA3_LINE_ERROR_${RIG}.png ${RIG}AA3_${TYPE_PLOT}_ERROR_${RIG}.png
#-------------------------------------------------
#
rm -rf ERR.txt ERR1.txt 
done
#
echo ${WRKDIR}
mkdir -p ${PDF_PLOTS}/${UTC}
rm -rf ${PDF_PLOTS}/${UTC}/REPORT_${TYPE_PLOT}_${YYYY}.pdf
convert *${TYPE_PLOT}*.png ${PDF_PLOTS}/${UTC}/REPORT_${TYPE_PLOT}_${YYYY}.pdf
echo ${PDF_PLOTS}/${UTC}/REPORT_${TYPE_PLOT}_${YYYY}.pdf
done   #  TYPE
rm -rf *.png
#
done  # UTC LOOP
cd ${SCRIPT}
exit
