#import "styling.typ": main-color, main-color-variant, main-gradient

#set page(
    margin: 0pt,
    paper: "a4",
    fill: rgb("#FDFDFD"),
    background: box(
        width: 100%,
        height: 100%,
        fill: gradient.radial(
            center: (0%, 150%),
            radius: 150%,
            main-color,
            white.transparentize(100%),
        ),
    ),
)

#let bg-image(it, opacity: 1, ..args) = image(
    bytes(
        read(it).replace(
            "opacity=\"1\"",
            "opacity=\"" + str(opacity) + "\"",
        ),
    ),
    ..args,
)

#{
    place(
        top + left,
        dx: 11.5cm,
        dy: 9.5cm,
        rotate(
            180deg,
            bg-image("assets/fractal.svg", opacity: 0.15, width: 40%),
        ),
    )

    place(
        top + left,
        dx: 10cm,
        dy: 0cm,
        rotate(
            10deg,
            bg-image("assets/universe.svg", opacity: 0.15, width: 50%),
        ),
    )

    place(
        top + left,
        dx: 1.5cm,
        dy: 12.5cm,
        bg-image("assets/wave.svg", opacity: 0.15, width: 50%),
    )

    place(
        top + left,
        dx: 1cm,
        dy: 19cm,
        rotate(
            -110deg,
            bg-image("assets/random-walk.svg", opacity: 0.15, width: 50%),
        ),
    )

    place(
        top + left,
        dx: 2cm,
        dy: 7cm,
        rotate(
            0deg,
            bg-image("assets/fbd.svg", opacity: 0.15, width: 50%),
        ),
    )

    place(
        top + left,
        dx: 6cm,
        dy: 11cm,
        rotate(
            5deg,
            bg-image("assets/vector-box.svg", opacity: 0.15, width: 50%),
        ),
    )
}

#let date-and-time = grid.cell(
    x: 0,
    y: 0,
    rowspan: 8,
    align: center + bottom,
    rotate(
        -90deg,
        reflow: true,
        {
            set text(size: 20pt, font: "Inter")

            (
                h(2em)
                    + text(weight: "bold")[14/08/26]
                    + h(2em)
                    + text(weight: "bold")[6:30PM]
                    + h(2em)
                    + text(weight: "bold")[LH4]
            )
        },
    ),
)

#let vertical-gradient = grid.cell(
    x: 5,
    y: 0,
    rowspan: 4,
    fill: gradient.linear(
        angle: -90deg,
        main-color.transparentize(500%),
        main-color-variant.transparentize(50%),
    ),
    [],
)

#let title = grid.cell(
    x: 1,
    y: 1,
    colspan: 2,
    align: center + horizon,
    text(size: 120pt, bottom-edge: "descender")[typst],
)

#let description = grid.cell(
    x: 3,
    y: 6,
    colspan: 2,
    align: right + horizon,
    {
        set par(leading: 4pt)

        text(
            font: "Hanken Grotesk",
            weight: "light",
            size: 10pt,
            spacing: 0.4em,
            tracking: 0.01em,
        )[Typst is a new markup-based typesetting system \ that is designed to be as powerful as LaTeX \ while being much easier to learn and use.

            In this talk we will cover the basics of Typst, \ including its syntax, features, and its ecosystem \ as well as compare it to LaTeX.

            Knowledge of LaTeX is not required :)]
    },
)

#grid(
    columns: (0.4fr, ..(1fr,) * 4, 0.15fr),
    rows: (0.5fr, ..(1fr,) * 6, 0.3fr),

    // stroke: 1pt + gray,

    date-and-time, vertical-gradient, title,
    description,
)
