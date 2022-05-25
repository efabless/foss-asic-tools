v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
T {For dynamic characterisation:} 1010 -1420 0 0 0.4 0.4 {}
T {For static (hysteresis) characterisation
Increasing voltage} 1010 -1260 0 0 0.4 0.4 {}
T {For static (hysteresis) characterisation
Decreasing voltage} 1010 -1080 0 0 0.4 0.4 {}
C {devices/vsource.sym} 1040 -1350 0 0 {name=V1 value="pulse -0.5 0.5 0 1u 1u 0.5u 3u" }
C {devices/vsource.sym} 1040 -990 0 0 {name=V3 value="pwl 0 160m 99n 160m 100n 140m 199n 140m 200n 120m 299n 120m 300n 100m 399n 100m 400n 80m 499n 80m 500n 60m 599n 60m 600n 40m 699n 40m 700n 20m 799n 20m 800n 0 899n 0 900n -20m 999n -20m 1u -40m 1.099u -40m 1.1u -42m 1.199u -42m 1.2u -44m 1.299u -44m 1.3u -46m 1.399u -46m 1.4u -48m 1.499u -48m 1.5u -50m 1.599u -50m 1.6u -52m 1.699u -52m 1.7u -54m 1.799u -54m 1.8u -56m 1.899u -56m 1.9u -58m 1.999u -58m 2u -60m 2.099u -60m 2.1u -80m 2.199u -80m 2.2u -100m 2.299u -100m 2.3u -120m 2.399u -120m 2.4u -140m 2.499u -140m 2.5u -160m 2.599u -160m"}
C {devices/vsource.sym} 1040 -1170 0 0 {name=V2 value="pwl 0 -160m 99n -160m 100n -140m 199n -140m 200n -120m 299n -120m 300n -100m 399n -100m 400n -80m 499n -80m 500n -60m 599n -60m 600n -40m 699n -40m 700n -20m 799n -20m 800n 0 899n 0 900n 20m 999n 20m 1u 40m 1.099u 40m 1.1u 42m 1.199u 42m 1.2u 44m 1.299u 44m 1.3u 46m 1.399u 46m 1.4u 48m 1.499u 48m 1.5u 50m 1.599u 50m 1.6u 52m 1.699u 52m 1.7u 54m 1.799u 54m 1.8u 56m 1.899u 56m 1.9u 58m 1.999u 58m 2u 60m 2.099u 60m 2.1u 80m 2.199u 80m 2.2u 100m 2.299u 100m 2.3u 120m 2.399u 120m 2.4u 140m 2.499u 140m 2.5u 160m 2.599u 160m"}
