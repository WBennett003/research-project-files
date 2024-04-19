#!/bin/bash
#SBATCH --job-name=SAGA_multimer_bioc014102
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-gpu=24g
#SBATCH --partition mlcnu
#SBATCH --account=bioc014102


#SBATCH -e /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/log/CL_100_recycles%A_err.txt
#SBATCH -o /user/home/vi21227/code/vi21227/code/Docs/MiniHATs/log/CL_100_recycles_%A_out.txt


module load lang/cuda/11.2-cudnn-8.1
module load lib/cudnn/11.2


source /user/home/vi21227/.bashrc
source /user/home/vi21227/initAConda.sh
source activate alphalink
cd /user/home/vi21227/code/vi21227/code/AF/AlphaLink2/

ptxac --version
nvcc --version
nvidia-smi


bash run_alphalink.sh \
	/user/home/vi21227/code/vi21227/code/Docs/MiniHATs/inps/SAGA.fasta \
	/user/home/vi21227/code/vi21227/code/Docs/MiniHATs/ms_linked.pkl.gz \
	/user/home/vi21227/code/vi21227/code/Docs/MiniHATs/out/SAGA_CL/ \
	/user/home/vi21227/code/vi21227/code/AF/AlphaLink2/weights/AlphaLink.pt \
	/sw/apps/alphafold/databases \
	2050-05-01 \
	25
#	--amber --num-relax 3 --num-recycle 3

