import os
import matplotlib.pyplot as plt
import numpy as np
dir=os.getcwd()
x=[]
y=[]
for dirpath, dirnames, filenames in os.walk(dir):
	for i in range(len(filenames)):
		if filenames[i] == 'r_corrfunc.dat':
			#print(dirpath)
			os.chdir(dirpath)
			#print(os.getcwd()) 
			plt.plotfile('r_corrfunc.dat', delimiter=' ', cols=(0, 1), names=('ln r', 'ln <SiSj>'), marker='o')
			f = open('r_corrfunc.dat','r')
			for line in f:
				#line = line.strip()
				columns = line.split()
				x.append(float(columns[0]))
				y.append(float(columns[1]))
				#err.append(float(columns[2]))
			f.close()
			m,c = np.polyfit(x, y, deg=1)
			m=float(m)
			c=float(c)
			#val = str('y=%m * x + %c')
			plt.plot(x, m * np.array(x) + c, color='red', label=['slope=', m])
			#ax.scatter(x, y)
			plt.legend()
			plt.savefig('plot.jpg')
print('FINISHED!')