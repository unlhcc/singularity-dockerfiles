#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]
    then
        python /app/alphafold/run_alphafold.py --help
	exit 1
    fi

# For devices with GPU compute capability 7.x the --flash_attention_implementation must be set to "xla".
cuda_compute_7=""
CUDA_COMPUTE=0
CUDA_MEMORY_AVAIL=0

# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
if ! command -v "nvidia-smi" 2>&1 >/dev/null
then
    # CPU node
    echo "`nvidia-smi` could not be found, running on CPU node..."
    cuda_compute_7=""
    CUDA_MEMORY_AVAIL=0
else
    # GPU node
    # https://github.com/google-deepmind/alphafold3/issues/59
    CUDA_COMPUTE=`nvidia-smi --query-gpu=compute_cap --format=csv,noheader | cut -f1 -d.`
    if [[ "$CUDA_COMPUTE" -lt 8 ]]
    then
        echo "GPU compute capability is 7.x, adding "--xla_disable_hlo_passes=custom-kernel-fusion-rewriter" to XLA_FLAGS..."
        export XLA_FLAGS="--xla_disable_hlo_passes=custom-kernel-fusion-rewriter"
        cuda_compute_7="--flash_attention_implementation=xla"
    fi

    # https://github.com/google-deepmind/alphafold3/issues/59
    CUDA_MEMORY_AVAIL=`nvidia-smi --query-gpu=memory.total --format=csv,noheader | cut -f1 -d" "`
    if [[ "$CUDA_MEMORY_AVAIL" -lt 50000 ]]
    then
        echo "Enabling unified memory for GPUs with less than 80GBs of memory..."
        export XLA_PYTHON_CLIENT_PREALLOCATE=false
        export TF_FORCE_UNIFIED_MEMORY=true
        export XLA_CLIENT_MEM_FRACTION=3.2
	# Patch is applied
    fi
fi

echo "Starting AlphaFold 3..."
echo "python /app/alphafold/run_alphafold.py "$@" ${cuda_compute_7}"
python /app/alphafold/run_alphafold.py "$@" ${cuda_compute_7}
