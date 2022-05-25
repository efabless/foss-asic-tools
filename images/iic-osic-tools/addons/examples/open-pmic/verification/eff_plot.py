import matplotlib
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
import numpy as np
import pandas


data = pandas.read_csv('eff_plot.csv', sep=',')

# Data for plotting
Power_out = data["Rload"]*data["Iout"]*data["Iout"]
Eff = data["Eff"]

fig, ax = plt.subplots()
ax.plot(Power_out, Eff, linestyle='-', marker='o', markerfacecolor=(0,0,1, 1), color=(0,0,1,0.3) )
#ax.tight_layout()
ax.yaxis.set_major_formatter(mtick.PercentFormatter(1.0, 1))

ax.set(xlabel='Power (W)', ylabel='$\eta$')
#ax.set_title('Converter Efficiency', fontsize=24)
ax.set_ylabel('$\eta$',rotation=0, fontsize=18, labelpad=10)
ax.set_xlabel(r'Power (W)', fontsize=18)
ax.grid(alpha=0.15)
fig.align_ylabels()
fig.tight_layout()


fig.savefig("eff_plot.png", dpi=300)
plt.show()