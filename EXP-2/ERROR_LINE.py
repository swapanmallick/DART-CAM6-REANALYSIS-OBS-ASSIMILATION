import numpy as np
#
TYPE,LON,LAT,HGT,RMSA,RMSF,OBS_VAL,OBS_PR,OBS_PO,PRI,POS,PRI_ES,POS_ES,T_SPP,T_SPO =  np.loadtxt('fort.FORTNO',skiprows=0, usecols=range(0,15), unpack=True)
output1 = open('ERRTOT.txt', "w+")
output2 = open('ERRNH.txt', "w+")
output3 = open('ERRSH.txt', "w+")
output4 = open('ERREQ.txt', "w+")
print(LON)
if(len(LON)<3):
   output1.write("%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s \n" % (("nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan")))
   output2.write("%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s \n" % (("nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan")))
   output3.write("%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s \n" % (("nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan")))
   output4.write("%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s \n" % (("nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan")))
   output1.close()
   output2.close()
   output3.close()
   output4.close()
   quit()
#
del TYPE,LON,LAT,HGT,RMSA,RMSF,OBS_VAL,OBS_PR,OBS_PO,PRI,POS,PRI_ES,POS_ES,T_SPP,T_SPO
#
TYPE,LON,LAT,HGT,RMSA,RMSF,OBS_VAL,OBS_PR,OBS_PO,PRI,POS,PRI_ES,POS_ES,T_SPP,T_SPO =  np.loadtxt('fort.FORTNO',skiprows=2, usecols=range(0,15), unpack=True)
#
nobs=len(LON)
E_PO=OBS_VAL-OBS_PO
E_PR=OBS_VAL-OBS_PR
NH=0;EQ=0;SH=0
E_PONH=0.0;E_PRNH=0.0;RMSANH=0.0;RMSFNH=0.0
PRI_ESNH=0.0;POS_ESNH=0.0
PRINH=0.0;POSNH=0.0
TPRNH=0.0;TPONH=0.0
#
E_POSH=0.0;E_PRSH=0.0;RMSASH=0.0;RMSFSH=0.0
PRI_ESSH=0.0;POS_ESSH=0.0
PRISH=0.0;POSSH=0.0
TPRSH=0.0;TPOSH=0.0
#
E_POEQ=0.0;E_PREQ=0.0;RMSAEQ=0.0;RMSFEQ=0.0
PRI_ESEQ=0.0;POS_ESEQ=0.0
PRIEQ=0.0;POSEQ=0.0
TPREQ=0.0;TPOEQ=0.0
#
for i in range(0,nobs):
   if(LAT[i]>30.0):
      E_PONH=E_PONH+E_PO[i];E_PRNH=E_PRNH+E_PR[i]
      RMSANH=RMSANH+RMSA[i];RMSFNH=RMSFNH+RMSF[i]
      PRI_ESNH=PRI_ESNH+PRI_ES[i];POS_ESNH=POS_ESNH+POS_ES[i]
      PRINH=PRINH+PRI[i];POSNH=POSNH+POS[i]
      TPRNH=TPRNH+T_SPP[i];TPONH=TPONH+T_SPO[i]
      NH=NH+1
#
   if(LAT[i]<-30.0):
      E_POSH=E_POSH+E_PO[i];E_PRSH=E_PRSH+E_PR[i]
      RMSASH=RMSASH+RMSA[i];RMSFSH=RMSFSH+RMSF[i]
      PRI_ESSH=PRI_ESSH+PRI_ES[i];POS_ESSH=POS_ESSH+POS_ES[i]
      PRISH=PRISH+PRI[i];POSSH=POSSH+POS[i]
      TPRSH=TPRSH+T_SPP[i];TPOSH=TPOSH+T_SPO[i]
      SH=SH+1
#
   if(LAT[i]<=30.0 and LAT[i]>=-30.0):
      E_POEQ=E_POEQ+E_PO[i];E_PREQ=E_PREQ+E_PR[i]
      RMSAEQ=RMSAEQ+RMSA[i];RMSFEQ=RMSFEQ+RMSF[i]
      PRI_ESEQ=PRI_ESEQ+PRI_ES[i];POS_ESEQ=POS_ESEQ+POS_ES[i]
      PRIEQ=PRIEQ+PRI[i];POSEQ=POSEQ+POS[i]
      TPREQ=TPREQ+T_SPP[i];TPOEQ=TPOEQ+T_SPO[i]
      EQ=EQ+1
#
output1.write("%12.0f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f \n" % (nobs,np.average(E_PO),np.average(E_PR),np.average(RMSA),np.average(RMSF),np.average(POS_ES),np.average(PRI_ES),np.average(POS),np.average(PRI),np.average(T_SPP),np.average(T_SPO)))
output2.write("%12.0f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f \n" % (NH,E_PONH/NH,E_PRNH/NH,RMSANH/NH,RMSFNH/NH,POS_ESNH/NH,PRI_ESNH/NH,POSNH/NH,PRINH/NH,TPRNH/NH,TPONH/NH))
output3.write("%12.0f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f \n" % (SH,E_POSH/SH,E_PRSH/SH,RMSASH/SH,RMSFSH/SH,POS_ESSH/SH,PRI_ESSH/SH,POSSH/SH,PRISH/SH,TPRSH/SH,TPOSH/SH))
output4.write("%12.0f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f \n" % (EQ,E_POEQ/EQ,E_PREQ/EQ,RMSAEQ/EQ,RMSFEQ/EQ,POS_ESEQ/EQ,PRI_ESEQ/EQ,POSEQ/EQ,PRIEQ/EQ,TPREQ/EQ,TPOEQ/EQ))
output1.close()
output2.close()
output3.close()
output4.close()
quit()
