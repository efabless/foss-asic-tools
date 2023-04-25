layers=(67 68 69 70 71 72)
files=( "$@" )

for f in "${files[@]}"; do
    echo "Working on $f"
    for l in "${layers[@]}"; do
        sh $(dirname $0)/cp_shapes.sh $f $l/5 $l/16
    done
done
