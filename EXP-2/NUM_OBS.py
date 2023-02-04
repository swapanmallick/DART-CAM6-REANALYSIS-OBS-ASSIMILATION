import numpy as np
##
KIND, LON, LAT, HGT, OBS, QC1, QC2 =  np.loadtxt('fort.UTCORTNO', usecols=range(0,7), unpack=True)
QC=QC2
nobs=len(OBS)
output1 = open('obs.txt', "w+")
if(len(OBS)<5):
      output1.write("%12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s %12s \n" % (("nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan","nan")))
      output1.close()
      quit() 
#print(OBS)
del KIND, LON, LAT, HGT, OBS, QC1, QC2
KIND, LON, LAT, HGT, OBS, QC1, QC2 =  np.loadtxt('fort.UTCORTNO',skiprows=2, usecols=range(0,7), unpack=True)
QC=QC2
nobs=len(OBS)
CLATH1=LAT
CLONH1=LON
print(np.max(CLONH1),np.min(CLONH1))
print(np.max(CLATH1),np.min(CLATH1))
LAT11=np.zeros(nobs);LON11=np.zeros(nobs)
LAT22=np.zeros(nobs);LON22=np.zeros(nobs)
QC11=np.zeros(nobs);QC22=np.zeros(nobs)
##QC11=np.empty(nobs);QC22=np.empty(nobs)
k=0;l=0;NH=0;SH=0;EQ=0
for i in range(0,nobs):
    if(QC[i]>=1.0):
       LAT11[k]=CLATH1[i];LON11[k]=CLONH1[i];QC11[k]=1
       k=k+1 
    if(QC[i]<1.0):
       LAT22[l]=CLATH1[i];LON22[l]=CLONH1[i];QC22[l]=10
       l=l+1
       if(CLATH1[i]>30.0):NH=NH+1
       if(CLATH1[i]<-30.0):SH=SH+1
       if(CLATH1[i]<= 30.0 and CLATH1[i]>=-30.0):EQ=EQ+1
#
obs_usd=l
obs_reg=k
#print(l,k)
tot = obs_usd+obs_reg
prec = obs_usd/tot *100
#--------_CALCULATE OBS NUMBER----------------
aa=np.zeros(10)
for k in range(0,9):
   for j in range(0,nobs):
       if(QC[j]>=0.0+k and QC[j]<1.0 + k):aa[k]=aa[k]+1
#
output1.write("%12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f %12.1f \n" % (tot*1., obs_reg, prec, aa[0],aa[1],aa[2],aa[3],aa[4],aa[5],aa[6],aa[7],aa[8],aa[9],NH,SH,EQ))
output1.close()
quit()
