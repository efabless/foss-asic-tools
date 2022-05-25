layers=(67 68 69 70 71 72)
files=( "$@" )

for f in "${files[@]}"; do
    echo "Working on $f"
    for l in "${layers[@]}"; do
        sh $(dirname $0)/cp_shapes.sh $f $l/16 $l/20
    done
done
