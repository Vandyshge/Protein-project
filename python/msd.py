import matplotlib.pyplot as plt
import numpy as np
import sys

T = sys.argv[1]

data = np.genfromtxt(f'/home/common/studtscm06/peptide/data/msd/temp_{T}.msd', skip_header=2)

plt.xlabel('t (fs)')
plt.ylabel('msd')
plt.title(f'msd for T = {T} K')

plt.plot(data[:, 0], data[:, 1])
plt.savefig(f'/home/common/studtscm06/peptide/data/figure/msd_{T}.png')