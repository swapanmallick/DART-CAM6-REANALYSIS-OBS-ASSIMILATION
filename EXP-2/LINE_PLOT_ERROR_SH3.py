import matplotlib.pyplot as plt
import numpy as np
import matplotlib as rc
from matplotlib import rcParams
#
fig = plt.figure(figsize=(10.0, 14.0))
plt.rcParams['font.size'] = 18
plt.rcParams['font.family'] = 'serif'
plt.rcParams['axes.linewidth'] = 1.5
#
DATE1,obs,E_PO,E_PR,RMSA,RMSF,POS_ES,PRI_ES,POS,PRI,T_SPP, T_SPO  = np.loadtxt('ERR1.txt', skiprows=0, usecols=range(0, 12), unpack=True)
DATE2,Tot, Rej, Percent,QCF0,QCF1,QCF2,QCF3,QCF4,QCF5,QCF6,QCF7,QCF8,QCF9,NH,SH,EQ  = np.loadtxt('FORTNO_LINESMUTC.txt', skiprows=0, usecols=range(0, 17), unpack=True)
ax1 = fig.add_subplot(311)
plt.rcParams['font.size'] = 16
#plt.text(15, 1.3, 'CMCC-DART MONITORING STATISTICS',horizontalalignment='center',verticalalignment='center',rotation='horizontal',color="Green")
#plt.rcParams['font.size'] = 14
#plt.text(15, 1.15, 'REGION (SOUTHERN HEMISPHERE)',fontweight='bold',fontstyle='italic',horizontalalignment='center',verticalalignment='center',rotation='horizontal', color="black")
#plt.text(15, 1.03, 'FORTNO  MM_SM at SMUTC1-UTC',fontweight='bold',fontstyle='italic',horizontalalignment='center',verticalalignment='center',rotation='horizontal', color="Blue")
plt.rcParams['font.size'] = 18
#-----------------------------------------------
SM_A=T_SPP
SM_B=T_SPO
nu1 =range(0,len(DATE1))
#
plt.rcParams['font.size'] = 18
plt.xlim(0,30)
plt.ylim(0, np.max(SM_B)+0.2)
ax1.plot(nu1,SM_A,'-',color='black',lw=2.0, label='OBS-INF')
ax1.plot(nu1,SM_B,'-',color='darkgrey',lw=3.0, label='EDI')
plt.rcParams['font.size'] = 12
plt.legend(bbox_to_anchor=(0.8, 0.81),fancybox=False)
#
ax2=ax1.twinx()
ax2.spines['right'].set_color('blue')
ax2.tick_params(colors='blue', which='both')
plt.rcParams['font.size'] = 12
ax2.plot(nu1,SH/1000,'o',color='blue',lw=0.8,label='ASSIM')
ax2.set_ylabel('ASSIM OBS COUNT (x 10$^{3}$)', fontsize=14, color='blue')
plt.xlabel('TIME')
#-----------------------------------------------
#plt.legend(bbox_to_anchor=(0.8, 0.81),fancybox=False)
#-----------------------------------------------
##plt.show()
plt.savefig('AA3_LINE_ERROR_SH.png')
