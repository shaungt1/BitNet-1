## `BitNet` Setup Guide for Windows and macOS with Virtual Enviroment

This guide provides step-by-step instructions to set up the BitNet project from [microsoft/BitNet](https://github.com/microsoft/BitNet). It covers checking for Python 3.9,`PYTHON 3.9 MUST BE USED` installing it if necessary, setting up the environment, and running BitNet on Windows (using Git Bash) and macOS (using Terminal).

---

### Prerequisites

### Clone the BitNet Repository
1. Open Git Bash (Windows) or Terminal (macOS).
2. Navigate to your project directory:
3. Clone the repository:
   ```bash
   git clone --recursive https://github.com/microsoft/BitNet.git
   cd BitNet
   ```

### Install Build Tools
- **Git**: Install from [git-scm.com](https://git-scm.com/downloads).
- **Windows Build Tools** (Windows only):
  - Visual Studio 2022 with:
    - Desktop development with C++
    - C++ CMake Tools for Windows
    - C++ Clang Compiler for Windows (clang>=18)
    - MSBuild Support for LLVM-Toolset
  - Install via the Visual Studio Installer.
- **CMake**: Version >=3.22. Install via Visual Studio or [cmake.org](https://cmake.org/download/).
- **Clang**: Version >=18. Included with Visual Studio or install from [LLVM](https://releases.llvm.org/).

Verify tools:
```bash
cmake --version  # Should be >=3.22
clang --version  # Should be >=18
```

---

### Step 1: Check if Python 3.9 is Installed

BitNet requires Python 3.9 or higher. Check if it’s installed at a common default path.

#### Windows (Git Bash)
- Open Git Bash and run:
  ```bash
  python_path="$HOME/AppData/Local/Programs/Python/Python39/python.exe"
  if [ -f "$python_path" ]; then
      echo "Python 3.9 found at $python_path"
      "$python_path" --version
  else
      echo "Python 3.9 not found at $python_path"
      echo "Proceed to Step 2 to install it."
  fi
  ```
  - Checks `%USERPROFILE%\AppData\Local\Programs\Python\Python39\python.exe`.
  - Outputs version (e.g., `Python 3.9.13`) if found.

#### macOS (Terminal)
- Open Terminal and run:
  ```bash
  python_path="/Library/Frameworks/Python.framework/Versions/3.9/bin/python3"
  if [ -f "$python_path" ]; then
      echo "Python 3.9 found at $python_path"
      "$python_path" --version
  else
      echo "Python 3.9 not found at $python_path"
      echo "Proceed to Step 2 to install it."
  fi
  ```
  - Checks a common macOS path.
  - Outputs version if found.

#### Alternative Check (Both OS)
- Run:
  ```bash
  python -c "import sys; print(sys.executable)"
  ```
  - Shows the active Python path. If it’s not 3.9, proceed to Step 2.

---

### Step 2: Install Python 3.9.13

If Python 3.9 isn’t found, install it from [python.org](https://www.python.org/downloads/release/python-3913/).

#### Windows
1. Download the "Windows installer (64-bit)" from [Python 3.9.13](https://www.python.org/ftp/python/3.9.13/python-3.9.13-amd64.exe).
2. Run the installer:
   - Check "Add Python 3.9 to PATH".
   - Select "Customize installation".
   - Ensure all optional features are checked.
   - Install to `%USERPROFILE%\AppData\Local\Programs\Python\Python39` (default) or `C:\Python39`.
3. Verify:
   ```bash
   "C:/Users/$(whoami)/AppData/Local/Programs/Python/Python39/python.exe" --version
   ```
   - Or, if installed to `C:\Python39`:
     ```bash
     "C:/Python39/python.exe" --version
     ```
   - Should output `Python 3.9.13`.

#### macOS
1. Download the "macOS 64-bit installer" from [Python 3.9.13](https://www.python.org/ftp/python/3.9.13/python-3.9.13-macos11.pkg).
2. Run the installer:
   - Follow prompts to install to `/Library/Frameworks/Python.framework/Versions/3.9`.
3. Verify:
   ```bash
   "/Library/Frameworks/Python.framework/Versions/3.9/bin/python3" --version
   ```
   - Should output `Python 3.9.13`.

---


### Step 3: Create and Activate Virtual Environment

Set up a virtual environment using Python 3.9.

#### Windows (Git Bash)
```bash
"C:/Users/$(whoami)/AppData/Local/Programs/Python/Python39/python.exe" -m venv bitnet-venv
source bitnet-venv/Scripts/activate
```

#### macOS (Terminal)
```bash
"/Library/Frameworks/Python.framework/Versions/3.9/bin/python3" -m venv bitnet-venv
source bitnet-venv/bin/activate
```

- Verify: `(bitnet-venv)` appears in your prompt, and:
  ```bash
  python --version  # Should show Python 3.9.13
  ```

---

### Step 4: Install BitNet Requirements

1. Install BitNet Requirements
   ```bash
      pip install -r requirements.txt
   ```


