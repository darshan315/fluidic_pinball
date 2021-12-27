#!usr/bin/sh -l

vals=($(seq 10 10 20))
a=1.0

for i in "${vals[@]}"
do
   echo -e "\n For Reynolds number = $i \n"
   folder=../../pydrl/notebooks/data/RE_"$i"
   data_folder=../run/RE_"$i"
   mkdir -p "$folder"
   cp $data_folder/postProcessing/field_cylinder_a/0/surfaceFieldValue.dat $folder/surfaceFieldValue_a.dat
   cp $data_folder/postProcessing/field_cylinder_b/0/surfaceFieldValue.dat $folder/surfaceFieldValue_b.dat
   cp $data_folder/postProcessing/field_cylinder_c/0/surfaceFieldValue.dat $folder/surfaceFieldValue_c.dat
   
   cp $data_folder/postProcessing/forces/0/coefficient.dat $folder/
      
done

