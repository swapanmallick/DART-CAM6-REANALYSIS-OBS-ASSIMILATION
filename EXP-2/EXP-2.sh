#!/bin/sh
#################################################################
#  CMCC DART OBS-SEQ-OUT FILE ERROR STATS
#  Author Dr. Swapan Mallick
#  Date 29 MAY 2022 at CMCC
#################################################################
#
EXP=exp14init
YYYY=2017
MM=10
USERNAME=sm09722
##USERNAME=gc02720
##USERNAME=lg07622
LINEDIR=/work/csp/sm09722/OBS_STAT/${EXP}_${YYYY}_ERROR
mkdir -p ${LINEDIR}
rm -rf ${LINEDIR}/*_ERRTOT*.txt
rm -rf ${LINEDIR}/*_ERRNH*.txt
rm -rf ${LINEDIR}/*_ERRSH*.txt
rm -rf ${LINEDIR}/*_ERREQ*.txt
rm -rf ${LINEDIR}/*_LINE*.txt
#
SCRIPT=/users_home/csp/sm09722/EXP-2
WRKDIR=${LINEDIR}
echo ${WRKDIR}
#
for HRR in 00000 ; do
##for HRR in 00000 21600 43200 64800 ; do
   if [ ${HRR} = 00000 ];then
      UTC1="00"
      echo ${UTC1}
   elif [ ${HRR} = 21600 ];then
      UTC1="06"
      echo ${UTC1}
   elif [ ${HRR} = 43200 ];then
      UTC1="12"
      echo ${UTC1}
   elif [ ${HRR} = 64800 ];then
      UTC1="18"
      echo ${UTC1}
   fi
#
#----Change here for number of days run-----
#
#for DD in {01..30}; do
for DD in {21..30}; do
#
DATAFILE=/work/csp/${USERNAME}/CESM2/archive/${EXP}/${EXP}-${YYYY}-${MM}-${DD}-${HRR}/${EXP}.dart.e.cam_obs_seq_final.${YYYY}-${MM}-${DD}-${HRR}
#
cd ${WRKDIR}
cp -f ${SCRIPT}/CMCC_OBSSEQ.exe ./
cp -f ${SCRIPT}/ERROR_LINE.py ./
cp -f ${SCRIPT}/NUM_OBS.py ./
cp -f ${DATAFILE} file_inp 
#
./CMCC_OBSSEQ.exe
rm -rf CMCC_OBSSEQ.exe file_inp
#
#
for TYPE_PLOT in LAND_SFC_ALTIMETER MARINE_SFC_ALTIMETER RADIOSONDE_U_WIND RADIOSONDE_V_WIND RADIOSONDE_TEMP AIRCRAFT_U_WIND AIRCRAFT_V_WIND AIRCRAFT_TEMP SATWIND_U_WIND SATWIND_V_WIND GPSRO_REFRACTIVITY AIRS_BT AMSU-CH8 AMSU-CH9 AMSU-CH10 AMSU-CH11 AMSU-CH12 AMSU-CH13 AMSU-CH14 ; do

#
if [ ${TYPE_PLOT} = RADIOSONDE_U_WIND ];then
      FORTNO="601"
      UTCORTNO="201"
elif [ ${TYPE_PLOT} = RADIOSONDE_V_WIND ];then
      FORTNO="602"
      UTCORTNO="202"
elif [ ${TYPE_PLOT} = RADIOSONDE_TEMP ];then
      FORTNO="603"
      UTCORTNO="203"
elif [ ${TYPE_PLOT} = AIRCRAFT_U_WIND ];then
      cat fort.604 fort.613 >> fort.6015
      cat fort.204 fort.213 >> fort.2015
      FORTNO="6015"
      UTCORTNO="2015"
elif [ ${TYPE_PLOT} = AIRCRAFT_V_WIND ];then
      cat fort.605 fort.614 >> fort.6016
      cat fort.205 fort.214 >> fort.2016
      FORTNO="6016"
      UTCORTNO="2016"
elif [ ${TYPE_PLOT} = AIRCRAFT_TEMP ];then
      cat fort.606 fort.615 >> fort.6017
      cat fort.206 fort.215 >> fort.2017
      FORTNO="6017"
      UTCORTNO="2017"
elif [ ${TYPE_PLOT} = SATWIND_U_WIND ];then
      FORTNO="607"
      UTCORTNO="207"
elif [ ${TYPE_PLOT} = SATWIND_V_WIND ];then
      FORTNO="608"
      UTCORTNO="208"
elif [ ${TYPE_PLOT} = GPSRO_REFRACTIVITY ];then
      FORTNO="609"
      UTCORTNO="209"
elif [ ${TYPE_PLOT} = AIRS_BT ];then
      FORTNO="610"
      UTCORTNO="210"
elif [ ${TYPE_PLOT} = MARINE_SFC_ALTIMETER ];then
      FORTNO="611"
      UTCORTNO="211"
elif [ ${TYPE_PLOT} = LAND_SFC_ALTIMETER ];then
      FORTNO="612"
      UTCORTNO="212"
elif [ ${TYPE_PLOT} = AMSU-CH8 ];then
      FORTNO="621"
      UTCORTNO="221"
elif [ ${TYPE_PLOT} = AMSU-CH9 ];then
      FORTNO="622"
      UTCORTNO="222"
elif [ ${TYPE_PLOT} = AMSU-CH10 ];then
      FORTNO="623"
      UTCORTNO="223"
elif [ ${TYPE_PLOT} = AMSU-CH11 ];then
      FORTNO="624"
      UTCORTNO="224"
elif [ ${TYPE_PLOT} = AMSU-CH12 ];then
      FORTNO="625"
      UTCORTNO="225"
elif [ ${TYPE_PLOT} = AMSU-CH13 ];then
      FORTNO="626"
      UTCORTNO="226"
elif [ ${TYPE_PLOT} = AMSU-CH14 ];then
      FORTNO="627"
      UTCORTNO="227"
#
fi
#----------------AVERAGE CALCULATION-------------------
#
sed "s/FORTNO/${FORTNO}/g" ERROR_LINE.py > aa.py
python aa.py
echo ${YYYY}${MM}${DD}${UTC1} > dd.txt
paste dd.txt  ERRTOT.txt >> ${LINEDIR}/${TYPE_PLOT}_ERRTOT${UTC1}.txt
paste dd.txt  ERRNH.txt >> ${LINEDIR}/${TYPE_PLOT}_ERRNH${UTC1}.txt
paste dd.txt  ERRSH.txt >> ${LINEDIR}/${TYPE_PLOT}_ERRSH${UTC1}.txt
paste dd.txt  ERREQ.txt >> ${LINEDIR}/${TYPE_PLOT}_ERREQ${UTC1}.txt
echo ${LINEDIR}/${TYPE_PLOT}_ERRTOT${UTC1}.txt
rm -rf aa.py dd.txt ERRTOT.txt ERRNH.txt ERRSH.txt ERREQ.txt
#
sed "s/UTCORTNO/${UTCORTNO}/g" NUM_OBS.py > dd.py
python dd.py
echo ${YYYY}${MM}${DD}${UTC1} >> dd.txt
paste dd.txt obs.txt >> ${LINEDIR}/${TYPE_PLOT}_LINE${UTC1}.txt
rm -rf  dd.py obs.txt dd.txt 
echo ${LINEDIR}/${TYPE_PLOT}_LINE${UTC1}.txt
#
done   # END TYPE LOOP
rm -rf fort.*
done   # END UTC LOOP
done   # END DAY LOOP
cd ${SCRIPT}
exit
