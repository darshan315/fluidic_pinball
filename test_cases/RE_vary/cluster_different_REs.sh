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
   
   #singularity run ../../of2106-py1.9.0-cpu.sif ./Allrun $folder   
   
   #----------------------------------------------------------------------------#		
# creates jobscript in each folder
cat > $folder/job.sh <<EOF
#!/bin/bash -l
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --time=12:00:00
#SBATCH --job-name=RE_$i
#SBATCH --ntasks-per-node=4

module load singularity/3.6.0rc2

singularity run of2106-py1.9.0-cpu.sif ./Allrun ./test_cases/run/RE_$i/
EOF
	chmod +x $folder/job.sh
  #----------------------------------------------------------------------------#	
  
  
  
echo -e "\nSubmitting JOB on cluster for RE=$i\n"
cd ../..
sbatch test_cases/run/RE_$i/job.sh
cd test_cases/RE_vary

done

