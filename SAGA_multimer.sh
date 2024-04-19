#!/bin/bash
#SBATCH --job-name=custome_tempalte_multimer_bioc014102
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --partition gpu
#SBATCH --mem=24G
#SBATCH --account=bioc014102


#SBATCH -e /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/log/%A_ATAC-ZZZ3_err.txt
#SBATCH -o /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/log/%A_ATAC-ZZZ3_out.txt

module load lang/cuda/11.2-cudnn-8.1
#module load lib/cudnn/11.2
source /user/home/vi21227/.bashrc
ptxas --version
nvcc --version
nvidia-smi

fasta=/user/home/vi21227/code/vi21227/code/Docs/MiniHATs/inps/SAGA.csv
out=/user/home/vi21227/code/vi21227/code/Docs/MiniHATs/out/AF_temp/

colabfold_batch $fasta \
	$out \
	--model-type 'alphafold2_multimer_v3' \
	--custom-template-path /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/inps/Alinged_AF.cif \
	--num-recycle 20 \
	--num-models 3 \
	--num-relax 1 \
	--use-gpu-relax \
	--save-recycles
	--custom-template-path /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/out/SAGA_VP16/SAGA_unrelaxed_alphafold2_multimer_v3_model_3_seed_000.pdb\	
