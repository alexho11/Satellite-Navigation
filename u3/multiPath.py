import scipy.io
import numpy as np
import matplotlib.pyplot as plt

mat = scipy.io.loadmat('data.mat')
data = np.array(mat['data'])

t=np.arange(len(data))
lc=data[:,1]
cmc=data[:,4]
cn1=10*np.log10(data[:,5])

fig=plt.figure(figsize=(15,8));ax=fig.add_subplot(1,1,1)
ax.plot(t,lc,label='Carrier Phase Lc')
ax.plot(t,cmc,label='Code Phase CMC')
ax.plot(t,cn1,label='Signal to Noise Ratio CN1')
ax.legend(loc='best')
plt.ylabel('m')
plt.xlabel('time series')
plt.show()