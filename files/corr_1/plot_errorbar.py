import os
import matplotlib.pyplot as plt
import numpy as np
dir=os.getcwd()
x,y,err = [],[],[]
for dirpath, dirnames, filenames in os.walk(dir):
	for i in range(len(filenames)):
		if filenames[i] == 'r_corrfunc_err.dat':
			#print(dirpath)
			os.chdir(dirpath)
			#print(os.getcwd()) 
			plt.plotfile('r_corrfunc_err.dat', delimiter=' ', cols=(0, 1), names=('ln r', 'ln <SiSj>'),linewidth = 1, color='black')
			f = open('r_corrfunc_err.dat','r')
			for line in f:
				#line = line.strip()
				columns = line.split()
				x.append(float(columns[0]))
				y.append(float(columns[1]))
				err.append(float(columns[2]))
			f.close()
			plt.errorbar(x,y,yerr=err,fmt='none',ecolor='black', capsize=2)
			
			m,c = np.polyfit(x, y, deg=1)
			m=float(m)
			c=float(c)
			#val = str('y=%m * x + %c')
			plt.plot(x, m * np.array(x) + c, color='red', label=['slope=', m])
			#ax.scatter(x, y)
			plt.legend()
			#fig.show()
			plt.savefig('plot.jpg')
			#plt.savefig('plot.jpg')
print('FINISHED!')
#print(x,y,err)