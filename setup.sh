#!/bin/bash

# setup.sh: Automates BitNet setup and runs inference on a user-selected model

# Exit on any error
set -e

# Step 1: Check for Python 3.9
echo "Step 1: Checking for Python 3.9..."

if [ "$(uname)" == "Darwin" ]; then
    # macOS
    PYTHON_PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin/python3"
    PYTHON_CMD="$PYTHON_PATH"
else
    # Windows (Git Bash)
    PYTHON_PATH="$HOME/AppData/Local/Programs/Python/Python39/python.exe"
    PYTHON_CMD="$PYTHON_PATH"
fi

if [ -f "$PYTHON_PATH" ]; then
    echo "Python 3.9 found at $PYTHON_PATH"
    "$PYTHON_CMD" --version
else
    echo "Python 3.9 not found at $PYTHON_PATH"
    echo "Please install Python 3.9.13 from https://www.python.org/downloads/release/python-3913/"
    echo "Windows: Use 'Windows installer (64-bit)', check 'Add Python 3.9 to PATH', install to default path."
    echo "macOS: Use 'macOS 64-bit installer', install to default path."
    echo "After installing, rerun this script."
    exit 1
fi

# Step 2: Clone BitNet Repository
echo "Step 2: Cloning BitNet repository..."
cd ~/Documents
if [ ! -d "BitNet" ]; then
    git clone --recursive https://github.com/microsoft/BitNet.git
fi
cd BitNet

# Step 3: Create and Activate Virtual Environment
echo "Step 3: Setting up virtual environment..."
if [ -d "bitnet-venv" ]; then
    rm -rf bitnet-venv
fi
"$PYTHON_CMD" -m venv bitnet-venv
if [ "$(uname)" == "Darwin" ]; then
    source bitnet-venv/bin/activate
else
    source bitnet-venv/Scripts/activate
fi
echo "Virtual environment activated: $(python --version)"

# Step 4: Install Requirements
echo "Step 4: Installing requirements..."
pip install -r requirements.txt
echo "Requirements installed."

# Step 5: Let User Choose a Model
echo "Step 5: Choose a model to download and run:"
MODELS=(
    "1bitLLM/bitnet_b1_58-large"
    "1bitLLM/bitnet_b1_58-3B"
    "HF1BitLLM/Llama3-8B-1.58-100B-tokens"
    "tiiuae/Falcon3-7B-Instruct-1.58bit"
    "tiiuae/Falcon3-7B-1.58bit"
    "tiiuae/Falcon3-10B-Instruct-1.58bit"
    "tiiuae/Falcon3-10B-1.58bit"
    "tiiuae/Falcon3-3B-Instruct-1.58bit"
    "tiiuae/Falcon3-3B-1.58bit"
    "tiiuae/Falcon3-1B-Instruct-1.58bit"
)

# Display model options
for i in "${!MODELS[@]}"; do
    echo "$((i+1)): ${MODELS[$i]}"
done

# Prompt user for input
read -p "Enter the number of the model you want (1-10): " MODEL_NUM
MODEL_INDEX=$((MODEL_NUM-1))

if [ "$MODEL_INDEX" -lt 0 ] || [ "$MODEL_INDEX" -ge "${#MODELS[@]}" ]; then
    echo "Invalid choice. Please enter a number between 1 and 10."
    exit 1
fi

CHOSEN_MODEL="${MODELS[$MODEL_INDEX]}"
echo "You selected: $CHOSEN_MODEL"

# Step 6: Download and Build the Chosen Model
echo "Step 6: Downloading and building $CHOSEN_MODEL..."
python setup_env.py --hf-repo "$CHOSEN_MODEL" -q i2_s
echo "Model $CHOSEN_MODEL downloaded and built."

# Step 7: Run Inference on the Chosen Model
MODEL_NAME=$(echo "$CHOSEN_MODEL" | cut -d'/' -f2)
echo "Step 7: Running inference on $MODEL_NAME..."
python run_inference.py -m "models/$MODEL_NAME/ggml-model-i2_s.gguf" -p "You are a helpful assistant" -cnv
echo "Inference complete!"

# Deactivate virtual environment
deactivate
echo "Setup and inference finished. Reactivate with 'source bitnet-venv/Scripts/activate' (Windows) or 'source bitnet-venv/bin/activate' (macOS)."