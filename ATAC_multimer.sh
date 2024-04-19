#!/bin/bash
#SBATCH --job-name=ATAC_multimer_bioc014102
#SBATCH --nodes=1
#SBATCH --gres=gpu:2
#SBATCH --partition gpu
#SBATCH --mem=18G
#SBATCH --account=bioc014102
#SBATCH --time=1-0:00:00

#SBATCH -e /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/log/%A_ATAC_err.txt
#SBATCH -o /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/log/%A_ATAC_out.txt

#/sw/apps/alphafold/2021-09-10-1d43aaf/docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
#/sw/apps/alphafold/2021-09-10-1d43aaf/docker build -f docker/DockerFile -t alphafold
#pip3 install -r /sw/apps/alphafold/2021-09-10-1d43aaf/docker/requirements.txt

module load lang/cuda/11.2-cudnn-8.1
#module load lib/cudnn/11.2
source /user/home/vi21227/.bashrc
ptxas --version
nvcc --version
nvidia-smi

colabfold_batch /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/ATAC.csv \
	/user/home/vi21227/code/vi21227/code/Docs/MiniHATs/out/mATAC/ \
	--amber \
	--num-relax 3 \
	--use-gpu-relax \
	--num-recycle 100 \
	--use-dropout \
	--num-seed 3 \
	# --templates /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/out/ATAC/ATAC_unrelaxed_alphafold2_multimer_v3_model_4_seed_000.pdb