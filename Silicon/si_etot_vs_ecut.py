from email import header
from os import sep
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


# data = np.loadtxt('si.etot_vs_ecut',skiprows=4)
# data = np.genfromtxt('si.etot_vs_ecut',skip_header=4,dtype='f16,f16',usemask=True)
#data = pd.read_csv('si.etot_vs_ecut',header=3, delimiter=' ')
data = pd.read_csv('si.etot_vs_ecut',header=3, delimiter=' ', keep_default_na=False)
#data = pd.read_csv('si.etot_vs_ecut',header=3, sep='\s+', keep_default_na=False)



#x = data[0:4]
#print(x)

# print(data.isna())
# print(data.dropna())
# '''
# ecut = []
# etot = []

# # open and read file
# f = open('/Users/landerson/Desktop/Project/quantum_espresso-tutorials/handson_pwscf/Silicon/si.etot_vs_ecut_py', 'r')

# # iterate through each line in file
# for line in f:
#     e = line.split(' ')
#     ecut.append(e[0])
#     etot.append(e[0])

# plt.xlabel("ecut")
# plt.ylabel("etot")
# plt.plot(ecut, etot, marker = 'o', c = 'g')

# plt.show()
# '''
