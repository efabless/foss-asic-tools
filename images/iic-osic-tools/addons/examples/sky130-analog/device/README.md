# Device Characterization

The sky130 PDK contains very detailed BSIM models for the transistors. However, there are no source for approximate device characteristics for use in hand calculations. This repo contains approximate device characteristics for some of the devices in the PDK and the simulations and plots which they were derived from. Values are derived for specific device length / width values but the values should be broadly similar for all length / width values. 


# Devices 
## sky130_fd_pr__nfet_g5v0d10v5
This is the lowest voltage NMOS device after the 1.8V FETs. As such it will probably be widely used in most analog and power designs. 

### 10 &mu;m Width / 0.5 &mu;m Length 
| Parameter                       | Value |
|---------------------------------|-------|
| V<sub>th</sub>                  | 0.7V     |
| &mu;<sub>n</sub> C<sub>ox</sub> | 125 &mu;AV<sup>-2</sup>;   |
| C<sub>ox</sub>                  | 2fF &mu;m<sup>-2</sup>   |
| &lambda;                        | 0.25 V<sup>-1</sup>    |
| R<sub>on</sub>                  | 267 &Omega; |

