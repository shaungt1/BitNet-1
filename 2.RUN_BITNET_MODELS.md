## Step 1: Download and Build a Model

#### Windows (Git Bash) or macOS (Terminal)
```bash
python setup_env.py --hf-repo tiiuae/Falcon3-7B-Instruct-1.58bit -q i2_s
```

- Downloads and prepares the model.
- Replace `tiiuae/Falcon3-7B-Instruct-1.58bit` with any of these supported models:
  - `1bitLLM/bitnet_b1_58-large`
  - `1bitLLM/bitnet_b1_58-3B`
  - `HF1BitLLM/Llama3-8B-1.58-100B-tokens`
  - `tiiuae/Falcon3-7B-Instruct-1.58bit`
  - `tiiuae/Falcon3-7B-1.58bit`
  - `tiiuae/Falcon3-10B-Instruct-1.58bit`
  - `tiiuae/Falcon3-10B-1.58bit`
  - `tiiuae/Falcon3-3B-Instruct-1.58bit`
  - `tiiuae/Falcon3-3B-1.58bit`
  - `tiiuae/Falcon3-1B-Instruct-1.58bit`

---

### Step 2: Run Inference on the Model

#### Windows (Git Bash) or macOS (Terminal)
```bash
python run_inference.py -m models/Falcon3-7B-Instruct-1.58bit/ggml-model-i2_s.gguf -p "You are a helpful assistant" -cnv
```

- Generates text from the prompt.
- Update the `-m` path to match your chosen model (e.g., `models/bitnet_b1_58-large/ggml-model-i2_s.gguf` for `1bitLLM/bitnet_b1_58-large`).

