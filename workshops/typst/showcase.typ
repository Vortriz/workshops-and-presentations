#set document(title: "Typst Feature Showcase", author: "Rishi Vora")
#set page(paper: "a4", margin: 1.5cm, numbering: "1")
#set text(size: 10pt)
#set heading(numbering: "1.")
#show heading: set text(navy)
#show heading.where(level: 2): it => {
    line(
        length: 100%,
        stroke: (thickness: 1pt, paint: gray, dash: "dashed"),
    )
    it
}
#show link: set text(fill: blue)
#let docs(body) = {
    box(stroke: 1pt + gray, radius: 2pt)[
        #grid(
            columns: 2,
            gutter: 5pt,
            inset: (left: 0pt, rest: 5pt),
            align: horizon,
            grid.cell(fill: gray.lighten(75%), inset: 3pt)[*Reference*],
            grid.cell(body),
        )
    ]
}

= Typst Feature Showcase <sec-showcase>

#docs([https://typst.app/open-source/#download])

== Basic Markup
- *Bold*, _Italic_, `Monospace`
- `-` Bulleted and `+` Numbered lists
- `#title`
- Links: https://typst.app or #link("https://typst.app")[Typst]
- Labels: `<sec-showcase>` and References: @sec-showcase

== Math
Inline: $a^2 + b^2 = c^2$

$ mat(1, 2; 3, 4) times vec(x, y) = cases(2x + y, 3x + 4y) $

$ A = pi r^2 $

$ cal(A) := { x in RR | x "is natural" } $

#let x = 5
$ #x < 17 $

$
    sum_(k=0)^n k & = 1 + ... + n \
                  & = (n(n+1)) / 2
$

#docs([https://typst.app/docs/reference/math/])

== Figures & Tables
#figure(
    table(
        columns: (1fr, auto),
        inset: 5pt,
        [*Feature*], [*Status*],
        [Speed], [Fast],
        [Logic], [Native],
    ),
    caption: [Sample Table],
) <tab-feat>

#figure(
    image("/python/assets/conda-conflict.png", width: 40%),
    caption: [Sample Image],
) <fig-img>

== Scripting

- Code block `{}` and content block `[]`.
- ```typst
    #if x < 2 [
      This is shown
    ] else [
      This is not.
    ]
    ```
- ```typst
    #for c in "ABC" [
      #c is a letter.
    ]
    ```

#lorem(20) #footnote[Footnote demonstration.]

== Show & Set Rules
- `#set` sets properties of a built-in function.
- `#show` selects the element we want to customize.
- #{
        set text(fill: gray.darken(20%))
        show "Typst": it => [ *#it* ]
        [This is a test of Typst show rules.]
    }
- show-set mix on `#title`

== Bibliography
Citing @knuth1984texbook and @typst2024.

#bibliography("/typst/refs.bib", style: "apa")
