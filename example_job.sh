#!/bin/bash
#SBATCH -J example_job          # Job name
#SBATCH -o %A.out               # Standard output (%A = job ID)
#SBATCH -e %A.err               # Standard error
#SBATCH -c 8                    # Number of CPU cores
#SBATCH -p gpu                  # Partition name
#SBATCH --gres=gpu:1            # Number of GPUs
#SBATCH -q normal               # QOS
#SBATCH --mem=32G               # Memory

# ========================================
# Environment Setup
# ========================================
# Activate your conda/virtual environment
source /home/username/miniforge3/bin/activate myenv

# Load .slurmrc functions
source /apps/.slurmrc

# ========================================
# Slack Alert Configuration
# ========================================
# Replace with your Channel ID
# Get it from: Slack App > Right Click > View app details > Channel ID
CHANNEL_ID="YOUR_CHANNEL_ID_HERE"

# Start notification
slurm_start "$CHANNEL_ID"

# ========================================
# Your Actual Job Commands
# ========================================
echo "Starting training..."
python train.py --epochs 100 --batch-size 32

echo "Running inference..."
python inference.py --model checkpoint.pth --data test_data/

echo "Processing results..."
python postprocess.py --output results/

# ========================================
# End Notification
# ========================================
slurm_end "$CHANNEL_ID"
