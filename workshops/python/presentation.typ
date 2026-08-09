#import "@preview/grape-suite:3.1.0": slides
#import slides: *

#show: slides.with(
    no: none,
    series: [Python Workshop],
    title: [Modern Python Tooling],
    topics: ([The better package manager], [The better notebook]),
    author: "Rishi Vora",
    show-semester: false,
    show-date: false,
    show-outline: false,
)

#set page(margin: (top: 1.5em))
#show heading: set block(below: 1em)
#set text(size: 0.9em)

// Fix list items not hiding the markers properly
#let no-par-spacing(it) = context {
    set par(spacing: par.leading)
    it
}

#show list: no-par-spacing
#show enum: no-par-spacing

#show hide: it => {
    show list.item: list
    show enum.item: enum

    it
}

// Fix borked speaker notes
// Custom speaker note function compatible with Typst 0.14+
#let speaker-note(content) = {
    let text-content = if type(content) == str {
        content
    } else if repr(content.func()) == "raw" {
        content.text
    } else {
        panic("Speaker note must be a string or raw block")
    }
    [#metadata((t: "Note", v: text-content)) <pdfpc>]
}

// Styling code blocks
#show raw: set text(font: "Maple Mono Normal NF")
#show raw.where(block: true): set text(size: 11pt)
#show raw.where(block: true): box.with(
    fill: luma(240),
    inset: 10pt,
    width: 100%,
    radius: 4pt,
)

// Styling tables
#show table.cell.where(x: 0): strong
#show table.cell.where(y: 0): strong
#show table.cell: set text(0.8em)
#show table.cell: set par(leading: 0.5em)

// Styling figures
#show figure: set text(size: 0.7em)

// Styling images
#show image: it => box(radius: 4pt, clip: true, it)

// Styling links
#show link: set text(fill: rgb("#1a73e8"))


// Slides begin here -------------------------------
#focus-slide[
    Part 1: The better package manager
]

#slide[
    == Traditional Python Environments

    #show: later

    #polylux.item-by-item(start: 2)[
        - *Global environment*: (Not recommended)
            - All projects share the same environment.
            - Risk of version conflicts and system tool issues.

            #v(0.5em)

        - *Virtual environments with `venv`*:
            - Isolated environments for each project.
            - `python -m venv .venv` & `source .venv/bin/activate`.

            #v(0.5em)

        - *Conda*:
            - Package manager for Python and non-Python dependencies.
            - `conda create -n my-env python=3.12` & `conda activate my-env`.
            - Powerful for scientific stacks, but often slow and "heavy".
    ]

    #speaker-note(
        ```md
        `openmpi`, `fftw`, or `cuda-toolkit` are examples of non-Python dependencies that Conda can manage.
        ```,
    )
]

#slide[
    == Traditional Dependency Management

    #show: later

    === *`requirements.txt`*:
    - Simple list of packages.
    - Lacks metadata (like the required Python version).
    - Doesn't lock transitive dependencies.

    #uncover(3)[
        #align(horizon)[
            #example(title: [Sample])[
                ```
                # This is a comment and will be ignored by pip
                pandas==2.1.0        # Exact version
                lxml>=4.9.2          # Minimum version
                numpy~=1.24.0        # Compatible release (>=1.24.0, <1.25.0)
                requests             # Latest version
                git+https://github.com/psf/requests.git@main#egg=requests # Install from a public GitHub repository
                ```
            ]
        ]
    ]
]

#slide[
    === *`environment.yml`* (Conda):
    - Environment definition including Python version.
    - Platform-specific exports make sharing difficult.

    #uncover(2)[
        #align(horizon)[
            #example(title: [Sample])[
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
            ]
        ]
    ]
]

#slide[
    === *`pyproject.toml`*:
    - Modern and official standard for Python project metadata and dependencies.
    - Supported by many modern tools.

    #uncover(2)[
        #align(horizon)[
            #example(title: [Sample])[
                ```toml
                [project]
                name = "my-project"
                version = "0.1.0"
                dependencies = [
                  "numpy>=1.24",
                  "pandas",
                ]
                requires-python = ">=3.9"
                ```
            ]
        ]
    ]
]

#slide[
    == The Problems with Traditional Workflows

    #show: later

    === Dependency Locking
    - Transitive dependencies are not locked in `requirements.txt`.
    - Leads to "works on my machine" bugs.
    - Modern managers (npm, cargo) use lockfiles.

    #uncover(3)[
        #align(horizon)[
            #example[
                #set text(size: 0.8em)

                `scikit-learn==1.3.0` directly depends on `numpy`, `scipy`, and `joblib`, but `scipy` itself depends on `numpy`, and `numpy` depends on several C libraries. If you specify `scikit-learn==1.3.0` in `requirements.txt`, pip will install whatever versions of `scipy`, `joblib`, and their dependencies it _deems compatible at install time_. This can lead to different environments having different transitive dependency versions.
            ]
        ]
    ]
]

#slide[

    #set align(horizon)

    #polylux.toolbox.side-by-side(columns: (1.75fr, 1fr))[
        #example(title: [Sample `cargo.lock`])[
            #show raw: set text(size: 0.68em)

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
        ]
    ][
        #set text(size: 0.8em)
        #set align(horizon)

        ==== Solution: Lockfiles

        #v(1em)

        This shows exact versions of all direct and transitive dependencies, ensuring *reproducible environments across different machines and over time*.
    ]
]

#slide[
    === The "Conda + Pip" Trap
    - Mixing them leads to environment inconsistency.
    - Pip might overwrite Conda-installed packages.
    - Standard Conda does not provide a cross-platform lock file by default.

    #set align(center + horizon)

    #figure(
        image("assets/conda-conflict.png", height: 60%),
        caption: [From the Anaconda documentation],
    )

    #speaker-note(
        ```md
        - "Conda solver hang" or "Inconsistent environment"
        - While you can `conda env export`, the resulting file is often platform-specific (containing specific builds for Linux/Mac/Windows), making it hard to share with colleagues on different OSs.
        ```,
    )
]

#slide[
    == Solution

    So what does a modern Python package manager look like? Let's compare the traditional tools with the ideal solution.

    #show: later

    #set align(horizon)

    #table(
        columns: (0.95fr, 1fr, 1fr, 1fr, 1fr),
        inset: 8pt,
        fill: (x, y) => if x == 4 { rgb("#eafaf1") } else { none },
        align: (x, y) => if y == 0 { center } else { left },
        table.header(
            [Feature],
            [`requirements.txt`],
            [`environment.yml`],
            [`pyproject.toml`],
            [`pyproject.toml` + Lockfile],
        ),
        [Scope],
        [Direct dependencies only],
        [Environment specification],
        [Project metadata (PEP 621)],
        [Full project snapshot],

        [Transitive Locking],
        [No],
        [Requires external tool],
        [No],
        [Yes (Native)],

        [Deterministic], [No], [Requires external tool], [No], [Yes],
        [Reproducibility],
        [Low],
        [Medium (Platform-bound)],
        [Low],
        [High (Universal)],
    )
]

#slide[
    == uv - The Modern Solution

    *uv* is a Python package and project manager written in Rust.

    #show: later

    - *Standard Metadata*: Fully embraces `pyproject.toml` (PEP 621) for project configuration.
    - *Native Transitive Locking*: Automatically generates and uses a cross-platform lockfile (`uv.lock`).
    - *Deterministic*: Ensures the exact same versions of all dependencies are installed everywhere.
    - *Universal Reproducibility*: Works seamlessly across different operating systems without platform-bound exports.

]

#slide[
    === What more does *uv* offer?

    #show: later

    - Handles project creation and setup.
    - Installs and manages Python versions.
    - Handles virtual environments.
    - Runs and installs tools published as Python packages.
    - Runs Python scripts, with support for inline dependency metadata.
    - Includes a pip-compatible interface for a performance boost with a familiar CLI.
    - Disk-space efficient, with a global cache for dependency deduplication.

    #show: later

    - 10-100x faster than pip.

    #set box(fill: black, inset: 8pt)
    #figure(
        image("assets/uv-perf.svg"),
        caption: [Installing Trio's dependencies with a warm cache],
    )
]

#slide[
    === Python Management

    ```bash
    # List all available Python versions
    uv python list

    # Install Python 3.12
    uv python install 3.12
    ```

    As simple as that! `uv` handles downloading, installing, and managing multiple Python versions seamlessly.
]

#slide[
    === Project Management

    #polylux.toolbox.side-by-side(columns: (1fr, 1fr))[
        ```bash
        # Create a new project in the current directory
        uv init

        # Pin the Python version for the project
        uv python pin 3.12

        # Install dependencies
        uv install numpy pandas==2.3.3 matplotlib

        # See the dependency tree
        uv tree

        # Remove a dependency
        uv remove matplotlib
        ```
    ][
        ```bash
        # Update dependencies
        uv lock --upgrade-package numpy
        uv lock --upgrade

        # Run a Python script
        uv run script.py

        # Install a tool
        uv tool install ruff

        # Run a tool without installing
        uvx ruff

        # Enter the project shell
        uv run python
        ```
    ]

    #show: later

    Notice how we don't need to activate the environment with `source .venv/bin/activate` or `conda activate my-env`. The `uv run` command automatically uses the correct environment for the project.
]

#slide[
    Want to share the project with a colleague? Deploy it on cluster? Or just ensure it works in 6 months when you forget all the details?

    #show: later

    #set align(center + horizon)
    #figure(
        image("assets/meme.png", height: 75%),
        caption: [From the guide by #link("https://www.saaspegasus.com/guides/uv-deep-dive/", "SaaS Pegasus")],
    )
]

#focus-slide[
    Part 2: The better notebook
]

#slide[
    == Traditional Notebook Experience

    Most people use *Jupyter* Notebooks (`.ipynb` files) for interactive data analysis and exploration. Jupyter provides a web-based interface where you can write and execute code in cells, visualize outputs, and document your workflow with Markdown.

    #speaker-note(
        ```md
        - Google Colab
        ```,
    )

    #show: later

    \

    Let's look at a demo that showcases all the pain points with Jupyter.
]

#slide[
    == Marimo - A Jupyter Replacement
    #align(
        center,
        figure(
            image("assets/marimo-example.jpg", height: 83%),
            caption: [A dashboard built with Marimo],
        ),
    )
]

#slide[
    #set align(horizon)
    #show table: set text(0.95em)

    #table(
        columns: (0.6fr, 1fr, 1fr),
        inset: 8pt,
        fill: (x, y) => if x == 2 { rgb("#eafaf1") } else { none },
        table.header([Feature], [Jupyter], [Marimo]),
        [State Consistency],
        [Hidden state (cells run out of order). 36% of notebooks found non-reproducible.],
        [Reactive (cells re-run automatically). Guarantees consistent state.],

        [File Format],
        [JSON (`.ipynb`). Difficult to version control.],
        [Pure Python (`.py`). Git-friendly and human-readable.],

        [UI Interactivity],
        [Requires extra libraries like `ipywidgets`.],
        [Built-in UI elements (sliders, etc.) synced with Python.],

        [Dependencies],
        [External environment management.],
        [Can do inline sandboxing (package requirements serialized in the file).],

        [Reusability],
        [Not possible to import or run as a standalone script.],
        [Can be imported as a module or executed from CLI.],

        [App Deployment],
        [Requires significant extra effort.],
        [Every notebook is an interactive web app.],
    )
]

#slide[
    === Getting Started with a Tutorial

    ```bash
    # Install marimo
    uv add marimo

    # Open the tutorial notebook
    uv run marimo tutorial for-jupyter-users
    ```

    #show: later
    \

    === Creating and Editing Notebooks

    ```bash
    # Create a new notebook
    uv run marimo new

    # Edit an existing notebook
    uv run marimo edit notebook.py
    ```
]

#slide[
    === Features

    - Integration with *uv*.
    - Source control friendliness.
    - Outputs are not stored within the notebook.
    - Ability to import as a module or run from CLI.
    - AI integration.
    - Integration with VS Code.
    - Import from Jupyter. Export to Jupyter, HTML, or PDF.
    - Deploy as an interactive web app or slides, run in the browser via Wasm.
    - Molab as a cloud alternative to Google Colab.

    #speaker-note(
        ```md
        - Convert `pain.ipynb` to marimo notebook with `uv run marimo convert pain.ipynb -o not_pain.py`.
        - Show how nicely marimo will prompt to install missing packages.
        - Won't run because of duplicate exports. Ask audience beforehand to guess the error.
        ```,
    )
]

#focus-slide[
    #text(size: 2em, [Thank you!])

    Questions?
]
