#!/bin/bash

: ${1?"Usage: $0 from_s8.hspice to_sky130.spice"}
: ${2?"Usage: $0 from_s8.hspice to_sky130.spice"}

properties_to_delete=("\\\$X" "\\\$Y" "\\\$D" "r" "N" "mult" "IP" "EP"\
    "FDC" "area" "ahftempperim" "PJ" "model")

input=$1
output=$2


cp $input $output

# apply mappings from rewrites.csv
: > _sed.script

tail -n +2 $(dirname $0)/../common/rewrites.csv > rewrites.txt

while IFS=, read -r from to
do
    echo "s#\<$from\>#$to#g" >> _sed.script
#done <<< $(tail -n +2 $(dirname $0)/rewrites.csv)

done < rewrites.txt

sed -f _sed.script -i $output
\rm _sed.script rewrites.txt

# remove properties_to_delete
for p in ${properties_to_delete[@]}; do
    sed -i -E "s# $p=[^[:space:]]+##g" $output
done

# remove empty subckts
# sed -i '/\.SUBCKT.*/{$!N;/\n\.ENDS/!P;D;D}' $output

# remove $T=number number number number properties
sed -i -E "s# \\\$T=[^[:space:]]+ [^[:space:]]+ [^[:space:]]+ [^[:space:]]+##g" $output

# M-instances -> X-instances
# D-instances -> X-instances
# C-instances -> X-instances
sed -i -E "s#^(M|D|C)#X\1#g" $output

# fix up $[device_name] devices
# for R-devices (resistors) apply the following transformation:
# RXX x y value m=1 a=1 b=2 $[sky130_fd_pr__res_generic_po] -> RXX x y sky130_fd_pr__res_generic_po m=1 a=1 b=2
sed -i -E "s#^(R[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) ([\.0-9]+) (.*) \\\$\[sky130_fd_pr__res_generic_po\]#\1 sky130_fd_pr__res_generic_po \3#g" $output
sed -i -E "s#^(R[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) ([\.0-9]+) (.*) \\\$\[short\]#\1 \2 short \3#g" $output

# RXX x y m=1 a=1 b=2 $[device_name] -> RXX x y device_name m=1 a=1 b=2
sed -i -E "s#^(R[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) (.*)? \\\$\[([^[:space:]]+)\]#\1 \3 \2#g" $output

# RXX x y m=1 a=1 b=2 $[device_name] -> RXX x y device_name m=1 a=1 b=2
sed -i -E "s#^(R[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) (.*) \\\$\[([^[:space:]]+)\]#\1 \3 \2#g" $output

# RXX x y $[device_name] m=1 a=1 b=2 -> RXX x y device_name m=1 a=1 b=2
sed -i -E "s#^(R[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) \\\$\[([^[:space:]]+)\] (.*)#\1 \2 \3#g" $output

# add w=480000u l=45000u to sky130_fd_pr__res_generic_po instances
# sed -i -E "s#(^R.* sky130_fd_pr__res_generic_po .*)#\1 w=480000u l=45000u#g" $output

# for "Dpar"s
# XXXX x y Dpar m=1 a=1 $[device_name] ->
# XXXX x y device_name m=1 a=1
sed -i -E "s#^(X[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) Dpar (.*) \\\$\[([^[:space:]]+)\]#\1 \3 \2#g" $output
# for now comment them out
# sed -i -E "s#^(X.*Dpar.*)#* \1#g" $output

# XC x y m=1 L=2 $[cap_device_name] -> XC x y cap_device_name m=1 L=2 
sed -i -E "s#^(X[^[:space:]]+ [^[:space:]]+ [^[:space:]]+) (.*) \\\$\[([^[:space:]]+)\]#\1 \3 \2#g" $output

# handle Probes -> subckt pins
top_level_subckt=$(tac $output | grep -i -E -o -m 1 ".SUBCKT.*" | awk '{print $2}')

echo "Top-level subckt name: $top_level_subckt"
# replace subckt declaration
pins=$(sed -E -n "s#^X.* ([^[:space:]]+) Probe.*#\1#p" $output)
readarray -t ARRAY <<< $pins; 
IFS=' '; pins="${ARRAY[*]}"
subckt=".SUBCKT $top_level_subckt $pins"
echo "New subckt definition:"
echo "$subckt"
sed -i "s#^.subckt $top_level_subckt\>#$subckt#i" $output
# delete all Probes
sed -i "s#^X.* Probe .*##g" $output


######
## Remove .subckts without any pins

awk 'BEGIN { IGNORECASE=1 } $1==".subckt" && NF==2 { hide=1 } hide==0 { print } $1==".ends" { hide=0 }' $output > ${output}.tmp

mv ${output}.tmp $output

