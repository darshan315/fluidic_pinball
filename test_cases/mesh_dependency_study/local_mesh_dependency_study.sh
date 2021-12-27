#!usr/bin/sh -l

echo -e " \n MESH DEPENDENCY LEVEL = 75%L \n "

mkdir -p ../run/mesh_o1_i1
cp -r mesh_o1_i1/* ../run/mesh_o1_i1
singularity run ../../of2106-py1.9.0-cpu.sif ./Allrun ../run/mesh_o1_i1/

echo -e " \n MESH DEPENDENCY LEVEL = 100%L \n"

mkdir -p ../run/mesh_o2_i2
cp -r mesh_o2_i2/* ../run/mesh_o2_i2
singularity run ../../of2106-py1.9.0-cpu.sif ./Allrun ../run/mesh_o2_i2/

echo -e " \n MESH DEPENDENCY LEVEL = 125%L \n"

mkdir -p ../run/mesh_o3_i3
cp -r mesh_o3_i3/* ../run/mesh_o3_i3
singularity run ../../of2106-py1.9.0-cpu.sif ./Allrun ../run/mesh_o3_i3/

