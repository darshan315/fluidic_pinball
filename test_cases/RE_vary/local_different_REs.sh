#!usr/bin/sh -l

vals=($(seq 10 10 20))
a=1.0

for i in "${vals[@]}"
do
   echo -e "\n \n Reynolds number is set to $i \n \n"
   folder=../run/RE_"$i"
   mkdir -p "$folder"
   cp -r ../base_case/* "$folder"
   
   NU=$(echo "scale=6; 1/$i" | bc)
   sed -i "s/nu .*/nu        "$NU";/g" $folder/constant/transportProperties
   
   singularity run ../../of2106-py1.9.0-cpu.sif ./Allrun $folder   
done

