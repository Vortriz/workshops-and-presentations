# Part 1: The better package manager

## The traditional way to manage Python environments

- You have a global Python environment (absolutely not recommended):
  - All your projects share the same Python environment.
  - You install dependencies globally, with `pip install numpy` for example.
  - This can lead to conflicts between projects, as different projects may require different versions of the same package.
  - This also messes with your system Python installation, which can cause issues with system tools that rely on Python.

- You have a virtual environment for each project:
  - Python allows you to create isolated environments for each project using `venv`.
  - You can create a virtual environment with `python -m venv .venv` and activate it with `source .venv/bin/activate` (Linux/Mac) or `.venv\Scripts\activate` (Windows). Then you can install dependencies within that environment using `pip install numpy` for example.
  - This way, you can manage dependencies for each project separately, avoiding conflicts and ensuring that each project has the correct versions of packages.

- The Conda way:
  - Conda (via Miniconda or Anaconda) is a package and environment manager that handles more than just Python.
  - It allows you to install non-Python dependencies (like `openmpi`, `fftw`, or `cuda-toolkit`) directly into the environment.
  - You create an environment with `conda create -n my-env python=3.12` and activate it with `conda activate my-env`.
  - While powerful for scientific stacks, it is often criticized for being slow and for creating large, "heavy" environments.

## The traditional way to manage dependencies

You may be using a `requirements.txt` file to manage your dependencies. This file lists all the packages and their versions that your project depends on.

```
# This is a comment and will be ignored by pip
pandas==2.1.0        # Exact version
lxml>=4.9.2          # Minimum version
numpy~=1.24.0        # Compatible release (>=1.24.0, <1.25.0)
requests             # Latest version
git+https://github.com/psf/requests.git@main#egg=requests # Install from a public GitHub repository
```

For Conda users, the equivalent is the `environment.yml` file. It allows you to specify the Python version, Conda-native packages, and even a nested list of Pip packages.

```yaml
name: my-env
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.11
  - numpy>=1.24
  - scipy
  - matplotlib
```

## The problems with the traditional workflow (and their solutions)

### Specifying Metadata

`requirements.txt` files are simple and easy to use, but they lack the ability to specify rich metadata about the project. For example, they can’t specify which version of Python is needed, making it possible to attempt installation in an incompatible environment.

- Solution: `pyproject.toml` (or `environment.yml` for Conda, though it's not a standard for packaging).

| Feature | `requirements.txt` | `environment.yml` | `pyproject.toml` |
| --- | --- | --- | --- |
| Purpose | Simple list of pip packages. | Environment definition for Conda. | Modern standard for metadata and dependencies. |
| Python Version | No. | Yes. | Can specify `requires-python`. |
| Non-Python Deps | No. | Yes (via Conda channels). | No (requires system tools). |

### Dependency Locking

The best that `requirements.txt` can do is to specify the exact versions of the direct dependencies (python packages) that your project needs. However, it does not "lock" the transitive dependencies (the dependencies of your dependencies).

For example, `scikit-learn==1.3.0` directly depends on `numpy`, `scipy`, and `joblib`, but `scipy` itself depends on `numpy`, and `numpy` depends on several C libraries. If you specify `scikit-learn==1.3.0` in `requirements.txt`, pip will install whatever versions of `scipy`, `joblib`, and their dependencies it deems compatible at install time. This can lead to different environments having different transitive dependency versions, causing the "works on my machine" problem.

Other languages and their package managers (like `npm` for JavaScript or `cargo` for Rust) have a concept of a "lock file" (like `package-lock.json` or `Cargo.lock`) that records the exact versions of all dependencies, including transitive ones.

Here's an example `Cargo.lock` file:

```toml
[[package]]
name = "serde"
version = "1.0.163"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "2113ab51bed1e7f57b4aa1c2e48ed660eb3d3f7f44d4bcf8cfd3bf63ee574ad1"

[[package]]
name = "serde_json"
version = "1.0.104"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "076066c5a1078eac5cdd75fc1635cd020c207a6d3dcbf858667951a8ec57272f"
dependencies = [
 "itoa",
 "ryu",
 "serde",
]

[[package]]
name = "itoa"
version = "1.0.9"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137910150ad5b15"

[[package]]
name = "ryu"
version = "1.0.15"
source = "registry+https://github.com/rust-lang/crates.io-index"
checksum = "1ad4cc8da4ef723ed60bced201181d83791ad433213d8c24efffda1eec85d741"
```

This shows exact versions of all direct and transitive dependencies, ensuring reproducible environments across different machines and over time.

### The "Conda + Pip" Trap

In scientific computing, it's very common to mix Conda and pip. You might install `numpy` via Conda but then install a niche physics library via pip.

- Pip is not aware of Conda's environment constraints, and Conda is only partially aware of Pip's. This often leads to Pip overwriting a Conda-installed package with a different version, breaking the environment's internal consistency (the dreaded "Conda solver hang" or "Inconsistent environment").
- Standard Conda does not provide a cross-platform lock file by default. While you can `conda env export`, the resulting file is often platform-specific (containing specific builds for Linux/Mac/Windows), making it hard to share with colleagues on different OSs.

## uv - Python package and project manager

- Provides comprehensive project management, with a universal lockfile `uv.lock`.
- Installs and manages Python versions.
- Runs and installs tools published as Python packages.
- Runs Python scripts, with support for inline dependency metadata.
- Includes a pip-compatible interface for a performance boost with a familiar CLI.
- Disk-space efficient, with a global cache for dependency deduplication.
- 10-100x faster than pip.

### Python management

```bash
# List all available Python versions
uv python list

# Install Python 3.12
uv python install 3.12
```

### Project management

1. Create a new project with `uv`:

```bash
# Create a new project in the current directory
uv init

# Pin the Python version for the project
uv python pin 3.12

# Install dependencies
uv install numpy matplotlib
uv install pandas==2.3.3

# See the dependency tree
uv tree

# Update dependencies
uv lock --upgrade-package numpy
uv lock --upgrade

# Remove a dependency
uv remove matplotlib

# Run a Python script
uv run script.py

# Enter the project shell
uv run python
```

Notice how we don't need to activate the environment with `source .venv/bin/activate` or `conda activate my-env`. The `uv run` command automatically uses the correct environment for the project.

# Part 2: The better notebook

## The traditional notebook experience

Most people use Jupyter Notebooks (`.ipynb` files) for interactive data analysis and exploration. Jupyter provides a web-based interface where you can write and execute code in cells, visualize outputs, and document your workflow with markdown.

Lets look at a demo that show cases all the pain points with Jypyter.

## Marimo - A Jupyter Replacement

Marimo is a **reactive** Python notebook that addresses the long-standing issues with the Jupyter ecosystem.

| Feature | Jupyter | Marimo |
| --- | --- | --- |
| **State Consistency** | Hidden state (cells run out of order). 36% of notebooks found non-reproducible. | Reactive (cells re-run automatically). Guarantees consistent state. |
| **File Format** | JSON (`.ipynb`). Difficult to version control. | Pure Python (`.py`). Git-friendly and human-readable. |
| **UI Interactivity** | Requires extra libraries like `ipywidgets`. | Built-in UI elements (sliders, etc.) synced with Python. |
| **Dependencies** | External environment management. | Inline sandboxing. Package requirements serialized in the file. |
| **Reusability** | Hard to import or run as a standalone script. | Can be imported as a module or executed from CLI. |
| **App Deployment** | Requires significant extra effort. | Every notebook is an interactive web app. |

### Getting started

```bash
# Install Marimo
uv add marimo

# Create a new Marimo notebook
uv run marimo new

# Edit an existing notebook
uv run marimo edit notebook.py
```

### Features to demo

- Coming from Jupyter tutorial
- Integration with uv
- Source control friendliness
- Ability to import as a module or run from CLI.
- AI integration
- Integration with VSCode
- Import from Jupyter. Export to Jupyter, HTML, or PDF.
- Deploy as an interactive web app or slides, run in the browser via WASM.
- Molab
- Mention that outputs are not stored within the notebook.
