# Harald Pretl & Georg Zachl, IIC, JKU
#
# Clears all docker images and triggers a rebuild.
#
# Order for building: base first, then magic; skywater-pdk before open_pdks; last is foss-asic-tools

source venv/bin/activate

# First, grep all containers that build on the foss-asic-tools container and delete them.
docker ps -a |grep -i foss-asic-tools |cut -d " " -f 1 |xargs echo docker rm

# Then, for all images that are available for the build, try to find some and if they exist, delete all existing tags.
for d in images/*/ ; do
	docker images | grep -w "^`basename $d`" | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} echo docker rmi "`basename $d`:{}"
done
