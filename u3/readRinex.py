import re
import numpy as np
from numpy import append
import datetime as dt
import matplotlib.pyplot as plt
from operator import add
G,R,S,E,C,I,J=[],[],[],[],[],[],[]
sum=[]
g,r,s,e,c,i,j=0,0,0,0,0,0,0
t=[]

with open ("INSA00DEU_R_20221212300_01H_01S_MO.rnx") as file:
    header=False
    for line in file:
        if header:
            if '>' in line:
                t.append(line)
                if g!=0:
                    G.append(g)
                    R.append(r)
                    S.append(s)
                    E.append(e)
                    C.append(c)
                    I.append(i)
                    J.append(j)
                    sum.append(g+r+s+e+c+i+j)
                    g,r,s,e,c,i,j=0,0,0,0,0,0,0
            elif 'G' in line:
                g+=1
            elif 'R' in line:
                r+=1
            elif 'S' in line:
                s+=1
            elif 'E' in line:
                e+=1
            elif 'C' in line:
                c+=1
            elif 'I' in line:
                i+=1
            elif 'J' in line:
                j+=1
        if 'END OF HEADER' in line:
            header=True

matches=re.search(">\s(\d+)\s+(\d)\s+(\d+)\s(\d+)\s+(\d+)\s+(\d+)",t[0])
st=dt.datetime(int(matches.group(1)),int(matches.group(2)),int(matches.group(3)),
int(matches.group(4)),int(matches.group(5)),int(matches.group(6)))

matches=re.search(">\s(\d+)\s+(\d)\s+(\d+)\s(\d+)\s+(\d+)\s+(\d+)",t[-1])
et=dt.datetime(int(matches.group(1)),int(matches.group(2)),int(matches.group(3)),
int(matches.group(4)),int(matches.group(5)),int(matches.group(6)))

sec=(et-st).seconds
time=np.arange(sec)
t1=st+dt.timedelta(seconds=round(sec+1)/4)
t2=t1+dt.timedelta(seconds=round(sec+1)/4)
t3=t2+dt.timedelta(seconds=round(sec+1)/4)


fig=plt.figure(figsize=(15,8));ax=fig.add_subplot(1,1,1)
ax.plot(time,G,label='GPS')
ax.plot(time,R,label='GLONASS')
ax.plot(time,S,label='SBAS payload')
ax.plot(time,E,label='Galileo')
ax.plot(time,C,label='BeiDou')
ax.plot(time,J,label='QZSS')
ax.plot(time,sum,label='total')
ax.legend(loc='best')
plt.ylabel('number of satellites')
ticks=ax.set_xticks(np.linspace(0,sec+1,5))
labels=ax.set_xticklabels([st,t1,t2,t3,et])
plt.show()


