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
  "16x20in": (16in, 20in),
  "18x24in": (18in, 24in),
  "22x28in": (22in, 28in),
  "24x36in": (24in, 36in),
  "36x48in": (36in, 48in),
)

// Column counts target ~6" per column on the existing 18x24 / 24x36 / 36x48
// baseline. 16x20 gets 3 columns in both orientations (~5.3"–6.7"/col) so
// the column width stays within the same readable range. 22x28 slots
// between 18x24 and 24x36 — 5 columns landscape (5.6"/col), 4 portrait
// (5.5"/col).
#let _column-lookup = (
  "16x20in": (landscape: 3, portrait: 2),
  "18x24in": (landscape: 4, portrait: 3),
  "22x28in": (landscape: 5, portrait: 4),
  "24x36in": (landscape: 6, portrait: 4),
  "36x48in": (landscape: 8, portrait: 6),
)

#let _margin-lookup = (
  "16x20in": (x: 1in, top: 0.75in, bottom: 1.5in),
  "18x24in": (x: 1in, top: 0.75in, bottom: 1.5in),
  "22x28in": (x: 1in, top: 0.75in, bottom: 1.5in),
  "24x36in": (x: 1in, top: 0.75in, bottom: 1.5in),
  "36x48in": (x: 1in, top: 0.75in, bottom: 1.5in),
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

#let byline(author, date: none, blog: none, accent: rgb("#b8860b")) = {
  set align(center)
  set text(size: 19pt, fill: ink-dark, weight: "semibold", tracking: 0.2em)
  block(above: 0.8em, below: 1.2em)[
    #upper(author)#if blog != none [ · #upper(blog)]#if date != none [ · #upper(date)]
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

#let inkhaven-logo(height: 0.8in, text-size: auto, fill: ink-medium) = {
  let resolved-size = if text-size == auto { height * 0.6 } else { text-size }
  block(below: 1in,
  //  stroke: 1pt + red
   )[
    #set align(center)
    #image("assets/inkhaven_logo.webp", height: height)
    #block(above: 0.3em, below: 0em)[
      #text(
        font: ("Libertinus Serif", "New Computer Modern"),
        size: resolved-size,
        weight: "regular",
        tracking: 0.3em,
        fill: fill,
        upper[Inkhaven],
      )
    ]
    #block(above: 0.3em, below: 0em)[
      #text(
        font: ("Libertinus Serif", "New Computer Modern"),
        size: resolved-size,
        weight: "regular",
        tracking: 0.3em,
        fill: fill,
        upper[Residency],
      )
    ]
  ]
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
  qr-svg: none,
  blog: none,
  font-size: 13pt,
  title-size: 58pt,
) = {
  let page-size = _resolve-page-size(paper, orientation)
  let column-count = _resolve-columns(paper, orientation, columns)

  set page(
    width: page-size.width,
    height: page-size.height,
    margin: _margin-lookup.at(paper),
    fill: solarized,
    footer: [
      #v(1fr)
      #line(length: 100%, stroke: 0.4pt + accent-color)
      #set align(center)
      #text(size: 18pt, fill: accent-color)[Sponsored by ]
      #box(baseline: 25%)[#image("assets/WPCOM-Dark-Default@2x.png", height: 18pt)]
      #v(1fr)
    ],
  )

  set text(
    font: ("Libertinus Serif", "New Computer Modern"),
    size: font-size,
    fill: ink-dark,
    lang: "en",
    hyphenate: true,
  )

  set par(
    justify: true,
    leading: 0.75em,
    spacing: 1.2em,
  )

  show link: it => {
    set text(fill: accent-color)
    it
  }

  // Title block, non-breakable, spans full width above the columns.
  // Fixed 1.75in side columns keep the logo and QR at their natural size
  // regardless of title length (prevents "RESIDENCY" from hyphenating).
  block(width: 100%, breakable: false,
    // stroke: 1.5pt + red
   )[
    #grid(
      columns: (1.75in, 1fr, 1.75in),
      align: (center + horizon, center + bottom, center + horizon),
      // Logo and QR use place() so they don't contribute to the grid row
      // height — the row sizes to the title alone, so the byline sits right
      // under the title regardless of how many lines the title occupies.
      [#inkhaven-logo(height: 1.1in, text-size: 0.18in)],
      [
        #set text(size: title-size, weight: "regular", hyphenate: false,
                  font: ("Libertinus Serif", "New Computer Modern"),
                  bottom-edge: "descender")
        #set par(justify: false, leading: 0.2em)
        #block(above: 0.5em, below: 0em)[#title]
        #byline(author, date: date, blog: blog, accent: accent-color)
      ],
      [
        #if qr-svg != none {
          block(
            // stroke: 1pt + red
           )[
            #image(bytes(qr-svg), format: "svg", width: 1.1in)
            #block(above: 0.3em, width: 1.1in)[
              #set text(size: 7pt, fill: ink-medium, tracking: 0.15em)
              #set align(center)
              #upper[Read online]
            ]
          ]
        }
      ],
    )
    #block(above: 0.2in, below: 0.8em)[#line(length: 100%, stroke: accent-color + 0.5pt)]
  ]

  v(0.6em)

  _columns-fn(column-count, gutter: 1.2em, body)
}
