#import "styling.typ": *
#import "@preview/tiptoe:0.4.0": *

#show: template

#section[
    #set par(leading: -12pt)
    #text(size: 26pt, smallcaps[a glimpse of]) \
    #text(size: 140pt)[*typst*]
]

#subsection(columns: 2)[
    Typst is a \
    *typesetting* \
    _system_

    #colbreak()

    But *why* \
    do you _need_ \
    one?
]

#slide[
    #subtitle[Documents like reports?]

    #place(
        center + horizon,
        dy: 3cm,
        image(
            "assets/microsoft-word.jpg",
        ),
    )
]

#slide(margin: 0pt)[
    #set align(center + horizon)
    #image(
        "assets/microsoft-word-meme.webp",
    )
]

#slide[
    #subtitle[Presentations?]

    #place(
        center + horizon,
        dy: 3cm,
        image(
            "assets/microsoft-powerpoint.png",
        ),
    )
]

#slide(margin: 0pt)[
    #set align(center + horizon)
    #image(
        "assets/microsoft-powerpoint-meme.jpg",
    )
]

#subsection[
    #text(
        weight: "semibold",
    )[What if you could \ #text(weight: "black")[design] your documents \ _`programmatically`?_]
]

// #slide[
//     #subtitle[But this is a solved problem!]

//     #columns(2)[
//         #image(
//             "assets/latex-solved-typesetting.png",
//             height: 80%
//         )

//         #colbreak()

//         #image(
//             "assets/word-vs-latex.jpg",
//             height: 85%
//         )
//     ]
// ]

// #subsection[
//     #text(weight: "semibold")[Or is it?] \
//     #text(font: "FreeSans", fill: gray.darken(20%), size: 0.25em)[\*vsauce theme song starts playing\*]
// ]

// #let just-latex-things(block-width: 100%, arrow-length: 5em, ..cells) = place(
//     center + horizon,
//     block(
//         width: block-width,
//         grid(
//             columns: (1fr, arrow-length, 1fr),
//             rows: (1fr, auto, 1fr),
//             grid.cell(
//                 x: 0,
//                 rowspan: 3,
//                 image(
//                     "assets/latex-example-1.jpg",
//                     height: 80%
//                 )
//             ),
//             grid.cell(
//                 x: 1,
//                 y: 1,
//                 line(
//                     stroke: 15pt + blue.lighten(10%),
//                     length: 100%,
//                     tip: triangle.with(
//                         width: 2em,
//                         length: 2em,
//                     ),
//                 ),
//             ),
//             grid.cell(
//                 x: 2,
//                 rowspan: 3,
//                 image(
//                     "assets/latex-example-2.jpg",
//                     height: 80%
//                 )
//             ),
//             ..cells
//         )
//     )
// )

// #slide[
//     #subtitle[How LaTeX works]
//     #just-latex-things(arrow-length: 5em)
// ]

#section[
    #set par(spacing: 0em)
    #let smalltext = text.with(
        size: 12pt,
        spacing: 1.8em,
        tracking: 0.4em,
        weight: "bold",
        font: "Maple Mono Normal NF",
        fill: white.transparentize(20%),
    )

    #smalltext[This is where]

    #text(size: 140pt, bottom-edge: "bounds")[*typst*]

    #set par(spacing: 1em)
    #smalltext[comes in!]
]

#subsection(margin: (y: 0pt))[
    #place(
        center + horizon,
        text(fill: luma(90%), size: 430pt)[&],
    )

    #set text(size: 50pt, fill: main-gradient)

    #grid(
        columns: (1fr, 1fr),
        align: center + horizon,
        [a *markup* \ _language_], [a *programming* \ _language_],
    )
]

#slide[
    #let ext = box.with(
        inset: 15pt,
        fill: luma(90%),
        radius: 10pt,
    )

    #set align(center + horizon)
    #set text(24pt)

    #let compile = text(1.2em, `typst compile file.typ`)
    #let watch = text(1.2em, `typst watch file.typ`)
    $
        #ext[`*.typ`]
        stretch(->, size: #9cm)^compile_watch
        cases(
            #ext(`*.pdf`),
            #ext(`*.png`),
            #ext(`*.svg`),
            #ext(fill: none, stroke: luma(90%) + 2pt)[`*.html`],
        )
    $
]

#section[
    #text(150pt)[*3*] modes:\
    #set text(30pt)
    markup, _math_, `code`
]

#slide[
    #subtitle[A source file starts in Markup mode]

    #set heading(numbering: "1.", outlined: false)

    // Undo previous increment, will be redone
    // below by = Introduction
    #counter(heading).update(0)

    #code-snippets(
        ```
        = Introduction
        Some things are *important* and
        must be _emphasized_.

        == First approach <part1>
        Some more text.

        == Second approach
        Something different from @part1.

        ```,

        ```
        Enumerations:
        + Lemon
        + Banana
        ```,

        ```
        - Lemon
        - Banana
        ```,

        raw(
            block: true,
            (
                "A code block:",
                "```py",
                "x = 3",
                "print(x + 5)",
                "```",
            ).join("\n"),
        ),
    )
]

#slide[
    #subtitle[Switch to math mode:  `$ ... $`]

    #code-snippets(
        ```
        Euler's formula:
        $
          e^(i theta)
          = sum_(n=0)^oo (i theta)^n / n!
          = cos(theta) + i sin(theta).
        $
        ```,

        ```
        $ W = arrow(F) dot arrow(d) $
        ```,

        ```
        Using $theta = pi$ the formula
        gives $e^(i pi) = -1$.
        ```,

        ```
        $
          A inter B = emptyset =>
          A without B = A
        $
        ```,

        ```
        $
        Q = 2 pi E_"start" / E_"dissipated"
        $
        ```,

        ```
        $ QQ = { p/q : p in ZZ, q in NN } $
        ```,

        ```
        $
          vec(3,9,15) =
          mat(1,2,3; 4,5,6; 7,8,9)
          vec(1,1,0)
        $
        ```,

        ```
        $
          f(x) &= (x+1)^2 &&= x^2 + 2x + 1 \
          g(x) &= 10(x-1) &&= 10x - 10
        $
        ```,
    )
]

#slide[
    #subtitle[Switch to code mode: ` #...`]

    #code-snippets(
        ```
        Example: bold text

        - With *markup*

        - With #strong[function call]
        ```,
    )

    Here `[]` goes back to markup mode. Compare:

    #show regex("[\[\]()]"): set text(weight: "bold", red.darken(10%))

    #code-snippets(
        ```
        - #strong[Some _markup_ value]
        - #strong("Some _string_ value")
        ```,
    )
]

#slide[
    #code-snippets(
        ```
        #link("example.com", "Example")
        ```,

        ```
        #table(
            columns: 2,
            [This is col 1],
            [This is col 2],
            [Back to col 1],
        )
        ```,

        ```
        #image(
            "assets/turinglogo.jpg",
            width: 20%,
        )
        ```,

        ```
        #figure(
            image(
                "assets/cow.jpg",
                width: 7cm
            ),
            caption: [Cowdynamics],
        )
        ```,

        ```
        #{
            let bool = true
            let list = (1, 2, 3)
            let dict = (a: 1, b: 2)
            let lambda = x => x * 2
        }
        ```,

        ```
        #let n = 3

        Powers of 2 up to $n = #n$:

        #for i in range(n+1) {
          let value = calc.pow(2, i)
          $ 2^#i = #value $
        }
        ```,
    )
]

#section(margin: 5em)[
    #set align(left)

    `set` & `show`
]

#slide[
    #set text(size: 36pt)
    #set align(center + horizon)

    ```typ #set text(size: 36pt)```

    #place(center + horizon)[
        #show raw: it => box(inset: (y: 0.25em), hide(it))

        #h(-0.5em)
        #raw("#set")
        #math.overbrace(raw("text"), "element")
        #math.underbrace(raw("size: 36pt"), "new defaults")
    ]
]

#slide[
    #code-snippets(
        ```
        This is normal text.

        #set text(
          font: "Overpass",
          size: 24pt,
          weight: "semibold"
        )

        This is differently styled text.
        ```,

        ```
        #set enum(numbering: "a1.")
        + Element A
          + Element A1
          + Element A2
        + Element B
        ```,
    )
]

#slide[
    #set text(size: 36pt)
    #set align(center + horizon)

    #block({
        set align(left)
        {
            show "link": it => box({
                it
                set text(1em / 0.8, black)
                place(bottom + center, math.overbrace(hide("link"), "selector"))
            })
            ```typ #show link: set text(fill: red)```
        }

        v(0.5em)

        {
            show "underline": it => box({
                it
                set text(1em / 0.8, black)
                place(top + center, math.underbrace(
                    hide("underline"),
                    "transformation",
                ))
            })
            ```typ #show link: underline```
        }
    })
]

#slide[
    #code-snippets(
        ```
        This is an unstyled link: \
        https://www.example.com

        #show link: set text(fill: red)
        #show link: underline
        This is a styled link \
        https://www.example.com.
        ```,

        ```
        // Anonymous transformation function
        #show link: it => [🔗] + it
        Go to https://www.example.com.
        ```,
    )
]

#slide[
    #code-snippets(
        ```
        #set text(font: "DejaVu Serif")

        #show math.equation: set text(
          font: "DejaVu Math TeX Gyre",
        )

        The definite integral of $f$
        on $[a, b]$ is defined as

        $
          integral_a^b = lim_(n->oo)
            (b-a)/n sum_(i=1)^n f(xi_i)
        $
        ```,
    )
]

#slide(margin: 0pt)[
    #place(
        center + horizon,
        image("assets/emoji_u1fa90.svg", height: 100%),
    )

    #place(
        center + horizon,
        box(
            fill: gradient.linear(
                angle: 30deg,
                main-color-variant.transparentize(10%),
                main-color.transparentize(10%),
            ),
            width: 100%,
            height: 100%,
        ),
    )

    #set align(center + horizon)
    #text(size: 80pt, fill: white.transparentize(10%))[`Universe`]
]


#slide[
    #subtitle[Diagrams with fletcher]
    #code-snippets(
        columns: (67%, auto),
        ```
        #import "@preview/fletcher:0.5.8": *

        #diagram(
            cell-size: 15mm,
            $
        	    G edge(f, ->) edge("d", pi, ->>) & im(f) \
        	    G slash ker(f) edge("ur", tilde(f), "hook-->")
            $
        )
        ```,
    )
]

#slide[
    #subtitle[Plotting from CSV with Lilaq]
    #code-snippets(
        ```
        #import "@preview/lilaq:0.6.0"

        #let data = lilaq.load-txt(
            read("assets/data.csv"),
            header: true
        )

        #lilaq.diagram(
            lilaq.plot(data.t, data.U),
            width: 100% - 1cm,
            height: 60%,
        )
        ```,
    )
]

#slide[
    #subtitle[Electronic circuits with Zap]
    #code-snippets(
        ```
        #import "@preview/zap:0.5.0"

        #zap.circuit({
            import zap: *

            vsource("v1", (0, 0), (0, 4),
                u: $U$)
            resistor("r1", "v1.out",
                (8, 4), label: $R$, i: $I$)
            wire((8, 4), (8, 0))
            wire((8, 0), (0, 0))
        })
        ```,
    )
]

#slide[
    #subtitle[Quantum circuits with Quill]
    #code-snippets(
        column-gutter: 5em,
        result-template: scale.with(200%),
        ```
        #import "@preview/quill:0.8.0": *

        #quantum-circuit(
            lstick($|psi〉$),  ctrl(1), gate($H$), 1, ctrl(2), meter(), [\ ],
            lstick($|beta_00〉$, n: 2), targ(), 1, ctrl(1), 1, meter(), [\ ],
            3, gate($X$), gate($Z$), midstick($|psi〉$), setwire(0)
        )
        ```,
    )
]

#slide[
    #subtitle[General-purpose drawing with CeTZ]

    #show raw.where(block: true): set block(breakable: true)
    #set text(0.7em)

    #code-snippets(
        columns: (100%, 40%),
        code-template: columns.with(2, gutter: 0pt),
        result-template: place.with(bottom, dx: -9cm, dy: 1cm),
        ```
        #import "@preview/cetz:0.4.2": canvas, draw, angle
        #canvas(length: 3.5cm, {
            import draw: *
            let my-alpha = 50deg
            let arrow = (end: ">", fill: black)
            let node = content.with(padding: 5pt)
            let P = (my-alpha, 1)
            let Px = (P, "|-", (0, 0))
            let Py = (P, "-|", (0, 0))
            line((-1.2, 0), (1.3, 0), mark: arrow)
            node((), anchor: "west", $x$)
            line((0, -1.2), (0, 1.3), mark: arrow)
            node((), anchor: "south", $y$)
            circle((0, 0), radius: 1)
            circle(P, radius: 1.5pt, fill: black)
            line((0, 0), P)
            line(Py, P, Px, stroke: (dash: "dotted"))
            node(Px, anchor: "north", $cos(alpha)$)
            node(Py, anchor: "east", $sin(alpha)$)
            node((my-alpha, 0.55), anchor: "south-east", $1$)
            angle.angle(
                (0, 0), (1, 0), P,
                label: $alpha$,
                radius: 0.3,
                label-radius: 160%,
                mark: arrow
            )
        })
        ```,
    )
]

#let neural-net = {
    show raw.where(block: true): set text(5pt)
    show raw.where(block: true): pad.with(left: 70mm)
    v(-3em)
    code-snippets(
        columns: 1,
        rows: (15em, 10em),
        row-gutter: -2em,
        align: center,
        result-template: scale.with(70%),
        raw(block: true, read("assets/neural-net.typ").trim()),
    )
}

#slide(background: neural-net)[
    #let grad = gradient.linear(
        (white.transparentize(100%), 0%),
        (white.transparentize(5%), 20%),
        (white.transparentize(5%), 80%),
        (white.transparentize(100%), 100%),
        dir: ttb,
    )
    #block(
        fill: grad,
        outset: (y: 20pt),
        subtitle[
            Neural network architectures with neural-netz
        ],
    )
]

#slide[
    #subtitle(text(50pt)[Templates])

    #set text(size: 36pt)
    #set align(center)
    #v(1fr)
    #show "show": it => box({
        it
        set text(1em / 0.8, black)
        place(
            bottom + center,
            math.overbrace(hide("show:"), "select all content below"),
        )
    })
    #show "template": it => box({
        it
        set text(1em / 0.8, black)
        place(
            top + center,
            math.underbrace(hide("template"), "transformation"),
        )
    })
    ```typ #show: template```
    #v(1fr)
]

#slide[
    #set text(0.8em)
    #raw(block: true, lang: "typ", read("assets/ams-template.typ").trim())

    #place(
        horizon + right,
        image("assets/ams-template.png", height: 85%),
    )
]

#section(margin: 5em)[
    #text(weight: "semibold")[How to use it?] \
]

#slide[
    #subtitle[Webapp]

    #set list(marker: sym.checkmark)

    #columns(2)[
        Try it at #link("https://typst.app/play/", `typst.app/play`)

        You can signup for a free account at #link("https://typst.app/signup/", `typst.app/signup`)

        #colbreak()

        *Free plan*:
        - Live preview
        - Real-time collaboration
    ]

    #place(
        center + horizon,
        dy: 6cm,
        image(
            "assets/webapp.png",
        ),
    )
]

#slide[
    #subtitle[Local installation]

    Download the compiler and run it locally: #link("https://typst.app/open-source/#download", `typst.app/open-source/#download`)

    It's free and open-source!

    #place(
        center + horizon,
        dy: 5cm,
        image(
            "assets/typst-repo.png",
        ),
    )
]

#slide[
    #subtitle[Local installation]

    Or install the `Tinymist` extension for VS Code.

    #place(
        center + horizon,
        dy: 4cm,
        image(
            "assets/tinymist.png",
        ),
    )
]

#section(margin: 5em)[
    #set align(left)
    #text(weight: "semibold")[In practice] \
    #text(0.5em, font: "New Computer Modern")[Comparison with LaTeX]
]

#slide[
    #subtitle[Installation]
    #set text(1.1em)

    #grid(
        columns: (50%, 50%),
        column-gutter: 1em,
        [
            *Typst*

            - 1 file

            - 50MB

            - Packages downloaded as necessary

        ],
        [
            *TeX Live*

            - 200K files

            - 7GB

            - Packages preinstalled \
                #text(size: 0.7em)[(Note: MiKTeX can download on-demand)]
        ],
    )

]

#slide[
    #subtitle[Performance]

    #grid(
        columns: (50%, 50%),
        [
            *Typst*

            - Incremental compiler
        ],
        [
            *LaTeX*

            - Multipass compiler
        ],
    )

    #v(1em)
    With someone's linear algebra lecture notes (140 pages):
    #v(1em)

    #grid(
        columns: (50%, 50%),
        [
            Typst

            - 6s
            - 1 output file
            - on change: *instant preview*
        ],
        [
            LaTeX

            - 17s
            - 21 output files
            - on change: full recompile (6s if lucky)
        ],
    )
]

#slide[
    #subtitle[Output quality]
    #set text(0.9em)

    #place(
        center + horizon,
        dy: 2cm,
        image(
            "assets/thesis-screenshot.png",
        ),
    )
]

#slide[
    #subtitle[Reproducibility #text(0.7em)[(does it still compile?)]]
    #set text(1.1em)
    #set block(spacing: 2em)

    #grid(
        columns: (50%, 50%),
        [
            *Typst*

            - Not stable (still in 0.x phase)

        ],
        [
            *LaTeX*

            - Core: extremely stable

                Packages: not stable
        ],
    )
    #grid(
        columns: (50%, 50%),
        [
            // Space after first emoji is different in preview!
            // see
            - Package use is versioned:

                ```typ #import "@preview/zap:0.5.0" ```

        ],
        [
            - No versioning of packages:

                ```tex \usepackage{circuitikz} ```
        ],
    )
    #grid(
        columns: (50%, 50%),
        [
            - Easy to co-install older version

        ],
        [
            - Difficult to install older version
        ],
    )
]

#slide[
    #subtitle[Error messages]

    #grid(
        columns: (50%, 50%),
        column-gutter: 1em,
        [
            *Typst*

            #image("assets/typst-error.png", width: 80%)
        ],
        [
            *LaTeX*

            ```error
            ! Missing } inserted.
            <inserted text>
                            }
            l.189 \end{frame}

            ?
            ```
        ],
    )
]

#slide[
    #v(-1fr)
    #v(1em)

    *Case in point:* A person trying to compile a very nice #link("https://liantze.penguinattack.org/latextypesetting.html")[LaTeX presentation from 2011]

    #v(1em)
    #set text(0.9em)

    #show raw.where(lang: "error"): set text(red.darken(30%))
    #set enum(spacing: 2em)

    + ```error
        ! LaTeX Error: File `dtklogos.sty' not found.
        ```

        In TeX Live 2016, the package was renamed to `dtk-logos.sty`

    + ```error
        Package `texshade', Version 1.28 of 2024/01/10

        ! LaTeX Error: Command \charge already defined.
                       Or name \end... illegal, see p.192 of the manual.
        ```

        No clue from Google, I comment out `\usepackage{texshade}` for now.

    + ```error
        ! Undefined control sequence.
        <argument> \MakeIndex
        ```

        I comment out all uses of `\MakeIndex`.

    + ```error
        [18] (./talk.vrb
        ! Missing number, treated as zero.
        <to be read again>
                           \kern
        l.10 \documentclass[
                            a4paper,11pt]{article}
        ```

        Apparently a breaking change in `listings`, the fix is to replace

        ```tex
        postbreak=\mbox{{\smaller\color{gray}$\hookrightarrow$}}
        ```

        with

        ```tex
        \newsavebox\postbreakbox
        \savebox\postbreakbox{\raisebox{0ex}[0ex][0ex]{\smaller\color{gray}$\hookrightarrow$}}
        ...
        postbreak=\usebox\postbreakbox
        ```

    + ```error
        ! Undefined control sequence.
        <recently read> \MikTeX
        ```

        Probably a breaking change in `dtk-logos`. I remove all occurrences of `\MikTeX`.


    + ```error
        ! Undefined control sequence.
        <argument> \tikz [remember picture,overlay]\node
                                                         [single arrow,fill=DarkSeaG...
        l.47 ...1em] at (current page.center) {pdflatex};}

        ?
        ```

        Probably a change in the interaction between TikZ overlays and Beamer uncover. \  I comment out.
        #v(1cm) // for new page for next item


    + ```error
        ! Package bytefield Error: Macros \wordgroupr, \wordgroupl, \endwordgroupr,
        (bytefield)                and \endwordgroupl no longer exist.

        See the bytefield package documentation for explanation.
        ```

        A breaking change in `bytefield`. Adapting the code.

    + ```error
        ! Missing } inserted.
        <inserted text>
                        }
        l.189 \end{frame}

        ?
        ```

        No idea even which file is the problem... I give up.
]

#slide[
    #subtitle[Syntax]

    #grid(
        columns: (50%, 50%),
        ```
        #slide[Installation][
          #set text(1.1em)
          #grid(
            columns: (1fr, 1fr),
            column-gutter: 1em,
            [
              *Typst*
              - 1 file
              - 50MB
            ],
            ...
          )
        ]
        ```,
        ```tex
        \begin{frame}{Installation}
        \fontsize{11pt}{13pt}\selectfont
        \begin{columns}
            \begin{column}{0.48\textwidth}
                \textbf{Typst}
                \begin{itemize}
                    \item 1 file
                    \item 50MB
                \end{itemize}
            \end{column}
            ...
        \end{columns}
        \end{frame}
        ```,
    )
]

#slide[
    *Typst*

    ```
    $ QQ = { p/q : p in ZZ, q in NN } $
    ```

    $ QQ = { p/q : p in ZZ, q in NN } $

    #v(1em)

    *LaTeX*

    ```tex
    \documentclass{article}
    \usepackage{amssymb}
    \begin{document}
    \[ \mathbb{Q} = \left\{\frac{p}{q}: p\in\mathbb{Z},q\in\mathbb{N}\right\} \]
    \end{document}
    ```
    #v(0pt, weak: true)
    #align(center, image("assets/latex-eq.png", width: 7.4cm))
]

#section(margin: 5em)[
    #align(left)[
        What you can \
        _do with Typst_ \
        *today*!
    ]
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
        image("assets/poster.png"),
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

#section[
    #set text(weight: "bold")

    #text(size: 1.25em)[Thank You!] \

    #text(size: 0.75em)[Questions?]
]
