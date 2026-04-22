# inkhaven-poster

Typst design system for printing Inkhaven residents' featured essays as
large-format posters for the in-person Inkhaven Fair.

Most residents do not need this repo directly — the portal wizard on
inkhaven.blog generates a PDF from their featured post. This repo is for
residents who want to compile locally from Typst source, and for the team
who maintain the shared design system.

## Install as a local Typst package

Clone into your Typst local package cache. Typst resolves
`@local/<name>:<version>` by looking here:

```bash
git clone https://github.com/lesswrong2/inkhaven-poster \
  ~/.cache/typst/packages/local/inkhaven-poster/0.1.0
```

`git clone` creates the intermediate directories for you.

## Compile the sample

```bash
cp ~/.cache/typst/packages/local/inkhaven-poster/0.1.0/examples/sample-essay.typ my-poster.typ
typst compile my-poster.typ
```

Produces `my-poster.pdf` next to the source.

Fonts: v0.1 asks for Libertinus Serif with New Computer Modern as a
fallback. NCM ships with Typst, so compile always succeeds; install
Libertinus system-wide for the intended look.

## Writing your own poster

A poster source is a normal `.typ` file that starts with:

```typst
#import "@local/inkhaven-poster:0.1.0": *

#show: poster.with(
  title: "Your title",
  author: "Your name",
  blog: "your-blog-name",   // optional — renders in the byline between author and date
  date: "2026-04-15",
  paper: "24x36in",         // 11x17in | 18x24in | 24x36in | 36x48in
  orientation: "landscape", // landscape | portrait
)

= Optional top-level heading

The body is real Typst — paragraphs, headings, *emphasis*,
#link("https://example.com")[inline links], #image("figure.png", width: 100%),
and so on.
```

The column count is chosen automatically from the paper size and
orientation; override with `columns: 5` (or any integer) if you need.

## Uploading your PDF

When you are happy with the output, upload the PDF through the portal
wizard at https://www.inkhaven.blog/portal — the team uses the portal to
collect every poster before sending the print order.
