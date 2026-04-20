// Inkhaven Fair poster design system
// Defaults ported from Aelerinya's 24x36 moloch poster.

// Alias the built-in `columns` function so the `poster(columns: ...)`
// parameter does not shadow it inside the function body.
#let _columns-fn = columns

#let solarized    = rgb("#fdf6e3")
#let ink-dark     = rgb("#4b2e05")
#let ink-medium   = rgb("#834f08")
#let gold-light   = rgb("#d4af37")
#let gold-dark    = rgb("#b8860b")

#let _paper-dims = (
  "11x17in": (11in, 17in),
  "18x24in": (18in, 24in),
  "24x36in": (24in, 36in),
  "36x48in": (36in, 48in),
)

#let _column-lookup = (
  "11x17in": (landscape: 3, portrait: 2),
  "18x24in": (landscape: 4, portrait: 3),
  "24x36in": (landscape: 6, portrait: 4),
  "36x48in": (landscape: 8, portrait: 6),
)

#let _resolve-page-size(paper, orientation) = {
  let dims = _paper-dims.at(paper)
  let short = dims.at(0)
  let long = dims.at(1)
  if orientation == "landscape" {
    (width: long, height: short)
  } else {
    (width: short, height: long)
  }
}

#let _resolve-columns(paper, orientation, columns) = {
  if columns == auto {
    _column-lookup.at(paper).at(orientation)
  } else {
    columns
  }
}

#let byline(author, date: none) = {
  set align(center)
  set text(size: 18pt, style: "italic", weight: "regular")
  block(below: 1em)[
    #author
    #if date != none [ \ #text(size: 16pt)[#date] ]
  ]
}

#let pull-quote(body) = {
  set text(size: 14pt, style: "italic")
  set par(leading: 0.7em)
  block(
    inset: (left: 2em, right: 2em, top: 0.5em, bottom: 0.5em),
    fill: none,
    stroke: none,
    body,
  )
}

#let inkhaven-logo() = {
  // v0.1 text-only wordmark. SVG asset lands in a later commit.
  text(font: ("Libertinus Serif", "New Computer Modern"), size: 14pt, weight: "regular",
       tracking: 0.2em, upper[Inkhaven])
}

#let poster(
  body,
  title: "",
  author: "",
  date: none,
  paper: "24x36in",
  orientation: "landscape",
  accent-color: gold-dark,
  columns: auto,
) = {
  let page-size = _resolve-page-size(paper, orientation)
  let column-count = _resolve-columns(paper, orientation, columns)

  set page(
    width: page-size.width,
    height: page-size.height,
    margin: (x: 1.5in, y: 1in),
    fill: solarized,
  )

  set text(
    font: ("Libertinus Serif", "New Computer Modern"),
    size: 13pt,
    fill: ink-dark,
    lang: "en",
    hyphenate: true,
  )

  set par(
    justify: true,
    leading: 0.75em,
    spacing: 0.75em,
  )

  show link: it => {
    set text(fill: accent-color)
    it
  }

  // Title block, non-breakable, spans full width above the columns.
  block(width: 100%, breakable: false)[
    #set align(center)
    #set text(size: 72pt, weight: "regular",
              font: ("Libertinus Serif", "New Computer Modern"))
    #block(below: 0.4em)[#title]

    #byline(author, date: date)

    #line(length: 100%, stroke: accent-color + 0.5pt)
  ]

  v(1em)

  _columns-fn(column-count, gutter: 1.2em, body)
}
