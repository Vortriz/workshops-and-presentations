#import "@preview/grape-suite:3.1.0": slides
#import slides: *

#show: slides.with(
    no: none,
    series: [Typst Workshop],
    title: [The Modern Typesetting Solution],
    topics: ([Why Typst?], [Ecosystem & Adoption]),
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

// Custom full-page showcase
#let showcase(title, imgs) = slide[
    #set page(header: none, footer: none, margin: 0pt)
    #set align(center + horizon)
    #show heading.where(level: 3): it => smallcaps(it)

    #grid(
        columns: (10%, 85%),
        rotate(-90deg, reflow: true)[
            #heading(level: 3)[
                #smallcaps(title)
            ]
        ],
        grid(
            columns: imgs.len(),
            stroke: 1pt + gray.lighten(50%),
            column-gutter: 0.5pt,
            ..imgs
        ),
    )
]

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

// Styling links
#show link: set text(fill: rgb("#1a73e8"))

// Custom LaTeX logo for slides
#let LaTeX = {
    set text(font: "New Computer Modern")
    let a = text(baseline: -0.35em, size: 0.66em, "A")
    let e = text(baseline: 0.22em, "E")
    box(
        "L"
            + h(-0.32em)
            + a
            + h(-0.13em)
            + "T"
            + h(-0.14em)
            + e
            + h(-0.14em)
            + "X",
    )
}


// Slides begin here -------------------------------
#focus-slide[
    Part 1: Why Typst?
]

#slide[
    == What's wrong with #LaTeX??

    #show: later

    #polylux.item-by-item(start: 2)[
        - *The Gold Standard*: De facto standard for academic and technical publishing since the 80s.
        - *Legacy Baggage*:
            - *Heavy Installation*: 2GB+ distributions (TeX Live, MiKTeX).
            - *Slow Feedback*: Save $arrow.r$ Wait 5-10s $arrow.r$ Check PDF.
            - *Opaque Errors*: "Undefined control sequence" in a package you didn't know you imported.
            - *Programming in TeX*: Macros are powerful but notoriously difficult to debug and maintain. Not to mention the plethora of backslashes and curly braces!
    ]

    #speaker-note(
        ```md
        LaTeX was built for a different era of computing. While it's powerful, the developer experience (DX) hasn't kept up with modern standards like Markdown or Rust.
        ```,
    )
]

#slide[
    == Typst: An Update to Typesetting

    Typst is a new, open-source typesetting system that aims to be as powerful as #LaTeX while being much easier to learn and use.

    #show: later

    #set align(horizon)

    #table(
        columns: (1fr, 1.2fr, 1.2fr),
        inset: 10pt,
        fill: (x, y) => if x == 2 { rgb("#eafaf1") } else { none },
        align: (x, y) => if y == 0 { center } else { left },
        table.header([Feature], [#LaTeX], [Typst]),
        [Speed], [Slow (takes seconds)], [Instant (milliseconds)],
        [Language], [Macro-based (TeX)], [Native Scripting],
        [Installation], [Heavy (2GB+)], [Single Binary (40MB)],
        [Packages], [Global/Fragmented (CTAN)], [Managed (Typst Universe)],
        [Error Handling], [Cryptic / Stack-heavy], [Clear / Visual],
    )
]

#slide[
    == The Ecosystem: Typst Universe

    Typst uses a modern package management system similar to `uv` or `cargo`.

    #show: later

    - *No more manual downloads*: Just import with `#import "@preview/package:version"`.
    - *Versioned Dependencies*: Ensures your document compiles the same way 5 years from now.
    - *Central Registry*: Explore themes, templates, and packages at #link("https://typst.app/universe")[typst.app/universe].
]

#slide[
    == Adoption

    #show: later

    Typst is powerful, but it's still a very new language!

    #show: later

    === Current Reality:
    - *Journals*: Most publishers still require #LaTeX source.
    - *Conferences*: Adoption is starting, but #LaTeX remains the default.

    #show: later

    === The Good News:
    - *arXiv*: Native support for Typst is officially coming soon!
]

#slide[
    == Where Typst Shines TODAY

    You don't have to wait for every journal to switch to start using Typst.

    #show: later

    === Presentations:

    Using libraries like #link("https://typst.app/universe/package/touying")[`touying`], #link("https://typst.app/universe/package/diatypst")[`diatypst`], or #link("https://typst.app/universe/package/grape-suite")[`grape-suite`] (like this one!).
]

#showcase(
    [CVs & Resumes],
    (
        image("assets/cv.pdf", page: 1),
        image("assets/cv.pdf", page: 2),
    ),
)

#showcase(
    [Posters],
    (
        image("./assets/poster.png"),
    ),
)

#showcase(
    [Reports & Theses],
    (
        image("assets/phd-thesis-001.pdf"),
        image("assets/phd-thesis-002.pdf"),
    ),
)

#showcase(
    [And much more...],
    (
        image("assets/BA_2025_managed_typo-001.pdf"),
    ),
)

#focus-slide[
    Part 2: Demo
]

#slide[
    == Quick Links

    === Downloading Typst for Local Use
    - https://typst.app/open-source/#download
    - Or use #link("https://myriad-dreamin.github.io/tinymist/")[Tinymist] VS Code extension.

    === Documentation & Learning Resources
    - https://typst.app/docs/
    - https://typst.app/docs/guides/for-latex-users/
    - https://typst.app/docs/reference/syntax/
    - https://typst.app/docs/reference/symbols/sym/

    === Packages & Templates
    - https://typst.app/universe/
]

#focus-slide[
    #text(size: 2em, [Thank you!])

    Questions?
]
