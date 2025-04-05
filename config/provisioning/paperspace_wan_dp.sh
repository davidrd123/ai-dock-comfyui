#!/bin/bash
set -e

# apt update
# apt install -y aria2

# Activate virtual environment if it exists
if [ -f ".venv/bin/activate" ]; then
    echo "Activating virtual environment..."
    source .venv/bin/activate
else
    echo "Warning: Virtual environment not found at .venv/bin/activate"
fi

# DOWNLOAD_DIR='/home/davidrd/Projects/Lora/ai-dock-comfyui/config/test-dl'
DOWNLOAD_DIR='/notebooks/diffusion-pipe/imagegen_models'
# Script to download models using aria2c and huggingface-cli
echo "Starting model downloads..."

# Create directories if they don't exist
mkdir -p $DOWNLOAD_DIR/wan

# Download models using aria2c (replace these URLs with your actual model URLs)
# echo "Downloading models using aria2c..."
# aria2c -x 16 -s 16 -k 1M -d $DOWNLOAD_DIR/hunyuan_video -o "hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors" "https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors"
# aria2c -x 16 -s 16 -k 1M -d $DOWNLOAD_DIR/hunyuan_video -o "hunyuan_video_vae_bf16.safetensors" "https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_vae_bf16.safetensors"

# # # Check if downloads were successful
# if [ $? -ne 0 ]; then
#     echo "Error: aria2c downloads failed"
#     exit 1
# fi

# Install huggingface_hub if not already installed
pip install -q "huggingface_hub"

# Enable faster downloads with hf_transfer if available
pip install -q hf_transfer
pip install -q "huggingface_hub[hf_transfer]"
export HF_HUB_ENABLE_HF_TRANSFER=1

mkdir -p $DOWNLOAD_DIR/wan/Wan2.1-T2V-1.3B

# Download models from Hugging Face
echo "Downloading models from Hugging Face..."
# Download Wan models from Wan-AI/Wan2.1-T2V-1.3B
huggingface-cli download --local-dir $DOWNLOAD_DIR/wan/Wan2.1-T2V-1.3B "Wan-AI/Wan2.1-T2V-1.3B" --include "*.safetensors" --exclude "*.bin"
# huggingface-cli download --local-dir $DOWNLOAD_DIR/clip-vit-large-patch14 "openai/clip-vit-large-patch14" --include "*.safetensors" --exclude "*.bin"
# huggingface-cli download --local-dir $DOWNLOAD_DIR/llava-llama-3-8b-text-encoder-tokenizer "Kijai/llava-llama-3-8b-text-encoder-tokenizer" --include "*.safetensors" --exclude "*.bin"

echo "All downloads completed successfully!"