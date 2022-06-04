import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.ticker as mtick
import pandas


data = pandas.read_csv('eff_test1.csv', sep=',')

# Data for plotting
Vin = data["Vin"]
Iin = data["Iin"]
Vout = data["Vout"]
Iout = data["Iout"]

Eff = (Vout*Iout)/(Vin*Iin)

fig, ax = plt.subplots()
ax.plot(Iout[1:], Eff[1:], linestyle='-', color="tab:blue", alpha=0.9, linewidth=3.0)
#ax.tight_layout()
ax.yaxis.set_major_formatter(mtick.PercentFormatter(1.0, 1))
#ax.set_ylabel('$\eta$',rotation=0, fontsize=18, labelpad=10)
ax.set_xlabel(r'Output Current (A)', fontsize=18)
plt.title('Open PMIC\nEfficiency vs Output Current (3.3V in, 1.8V out)', fontsize=14)
ax.grid(alpha=0.15)
plt.ylim([0.6, 0.95])
plt.xlim([0.0, 0.5])
fig.align_ylabels()
fig.tight_layout()


fig.savefig("eff1.png", dpi=300)
plt.show()