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
ax1 = fig.add_subplot(311)
plt.rcParams['font.size'] = 16
plt.text(15, 4.5, 'CMCC-DART MONITORING STATISTICS',horizontalalignment='center',verticalalignment='center',rotation='horizontal',color="Green")
plt.rcParams['font.size'] = 14
plt.text(15, 3.8, 'REGION (SOUTHERN HEMISPHERE)',fontweight='bold',fontstyle='italic',horizontalalignment='center',verticalalignment='center',rotation='horizontal', color="black")
plt.text(15, 3.2, 'FORTNO  MM_SM at SMUTC1-UTC',fontweight='bold',fontstyle='italic',horizontalalignment='center',verticalalignment='center',rotation='horizontal', color="Blue")
plt.rcParams['font.size'] = 18
#-----------------------------------------------
SM_A=E_PO
SM_B=E_PR
nu1 =range(0,len(DATE1))
#
plt.rcParams['font.size'] = 18
plt.xlim(0,30)
plt.ylim(-3., 3.)
ax1.plot(nu1,SM_A,'o-',color='blue',lw=2.0, label='OA')
ax1.plot(nu1,SM_B,'o-',color='green',lw=1.5,label='OB')
plt.rcParams['font.size'] = 18
ax1.set_ylabel('BIAS',fontsize=16, color='blue')
plt.xlabel('')
plt.axhline(y = 0.0, color = 'k', linestyle = '--')
plt.rcParams['font.size'] = 14
plt.legend(bbox_to_anchor=(0.8, 0.81),fancybox=False)
plt.rcParams['font.size'] = 18
del SM_A, SM_B
#-----------------------------------------------
ax2 = fig.add_subplot(312)
SM_A=RMSA
SM_B=RMSF
nu1 =range(0,len(DATE1))
#
plt.rcParams['font.size'] = 18
plt.xlim(0,30)
#plt.ylim(0, 3.)
ax2.plot(nu1,SM_A,'o-',color='blue',lw=2.0, label='OA')
ax2.plot(nu1,SM_B,'o-',color='green',lw=1.5,label='OB')
plt.rcParams['font.size'] = 18
ax2.set_ylabel('RMS',fontsize=16, color='blue')
plt.xlabel('')
plt.rcParams['font.size'] = 14
plt.legend(bbox_to_anchor=(0.8, 0.81),fancybox=False)
plt.rcParams['font.size'] = 18
del SM_A, SM_B
#-----------------------------------------------
ax3 = fig.add_subplot(313)
SM_B=np.sqrt(PRI_ES)
SM_A=np.sqrt(POS_ES)
nu1 =range(0,len(DATE1))
plt.xlim(0,30)
#
ax3.plot(nu1,SM_A,'o-',color='blue',lw=2.0, label='POST-ENS')
ax3.plot(nu1,SM_B,'o-',color='green',lw=1.5,label='PRIO-ENS')
plt.rcParams['font.size'] = 18
ax3.set_ylabel('STD DEV',fontsize=16, color='blue')
plt.xlabel('TIME')
plt.rcParams['font.size'] = 14
plt.legend(bbox_to_anchor=(0.8, 0.81),fancybox=False)
#-----------------------------------------------
##plt.show()
plt.savefig('AA1_LINE_ERROR_SH.png')
