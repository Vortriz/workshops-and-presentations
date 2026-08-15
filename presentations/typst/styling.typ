#let main-color = rgb("#00afc6")
#let main-color-variant = rgb("#00c6b5")
#let main-gradient = gradient.linear(
    angle: 30deg,
    main-color,
    main-color-variant,
)

#let raw-block-template(it) = {
    if it.lang not in ("tex", "typ", "just") {
        return it
    }
    grid(
        columns: 2,
        column-gutter: 1em,
        inset: (
            bottom: par.leading / 2,
            top: par.leading / 2,
            right: 0.25em,
            left: -0.32em,
        ),
        stroke: (x, y) => if x == 0 {
            (right: 1pt + luma(80%))
        } else {
            none
        },
        align: (right, raw.align),
        ..for line in it.lines {
            (
                text(fill: luma(80%), str(line.number)),
                line,
            )
        }
    )
}

#let subtitle(it) = text(size: 30pt, weight: "bold", fill: main-gradient, it)

#let template(doc) = {
    set page(
        paper: "presentation-16-9",
        margin: 1.5cm,
        footer: {
            set align(right)
            set text(16pt, luma(40%))
            align(right, context counter(page).display())
        },
    )
    set text(size: 20pt, font: ("Libertinus Serif", "Noto Color Emoji"))
    show heading: set block(below: 1em)
    show link: set text(rgb("#3f51b5"))

    show raw: set text(font: "Maple Mono Normal NF")
    show raw: set underline(stroke: 0pt) // no underline, it looks bad
    show raw: set block(breakable: false)
    show raw.where(block: true): raw-block-template
    show raw.where(block: true): set raw(lang: "typ")

    show outline: set block(spacing: 1em)
    show outline: it => {
        show link: set text(black)
        it
    }

    show outline.entry: it => link(
        it.element.location(),
        it.indented(it.prefix(), it.body()),
    )

    doc
}

#let slide(it, ..args) = page(..args, it)

#let section(it, ..args) = slide(
    header: none,
    footer: none,
    fill: main-gradient,
    margin: 0em,
    ..args,
)[
    #set align(center + horizon)
    #set text(50pt, fill: white)
    #set par(leading: 20pt)
    #it
]

#let subsection(it, ..args) = slide(
    header: none,
    footer: none,
    margin: 0em,
    ..args,
)[
    #set align(center + horizon)
    #set text(size: 50pt, fill: main-gradient)
    #set par(leading: 20pt)
    #it
]

#let code-snippets(
    code-template: it => it,
    result-template: it => it,
    columns: (50%, 50%),
    ..args,
) = grid(
    columns: columns,
    inset: (bottom: 25pt),
    row-gutter: 25pt,
    column-gutter: 10pt,
    ..args.named(),
    ..args
        .pos()
        .map(x => (
            {
                show: code-template
                x
            },
            {
                show: result-template
                eval(x.text, mode: "markup")
            },
        ))
        .join(),
)

#let showcase(title, imgs) = slide(header: none, footer: none, margin: 0pt)[
    #set align(center + horizon)
    #set text(weight: "black")

    #grid(
        columns: (10%, 85%),
        rotate(-90deg, reflow: true)[
            #title
        ],
        grid(
            columns: imgs.len(),
            stroke: 1pt + gray.lighten(50%),
            column-gutter: 0.5pt,
            ..imgs
        ),
    )
]
