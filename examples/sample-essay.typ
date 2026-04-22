#import "@local/inkhaven-poster:0.1.0": *

#show: poster.with(
  title: "A Sample Poster",
  blog: "BLOGOGO",
  author: "Inkhaven",
  date: "04-13-2026",
  paper: "11x17in",
  orientation: "landscape",
)

= On the Shape of a Page

A poster is a strange artifact. Unlike a book, it does not reward slow,
linear attention. Unlike a screen, it does not move. It stands still and
asks to be read from across a room, then from up close, then from across a
room again. The typography has to survive both distances.

This sample exists only to show the shape: how the title block sits above
the columns, how the columns breathe at the chosen paper size, how the body
text flows when it is justified and hyphenated. Replace the text with the
essay you actually want to print.

== Paragraphs and emphasis

Most of a poster is plain paragraphs. They should set cleanly without the
reader noticing the typesetting at all. A single italic aside, or a phrase
in _emphasis_, is enough to carry tone. When something deserves real
attention, #strong[bold] will carry it — but use it sparingly; the eye
tires.

== Links and references

Inline references to external work, like
#link("https://typst.app")[the Typst documentation], flow into the prose in
the accent color. They do not break the column rhythm.

#pull-quote[
  Pull quotes can float between paragraphs as a visual pause — a place for
  the eye to rest, or for the single sentence that distills the argument.
]

== Structure

Headings at level two divide the poster into sections. Level three headings
sit tighter against their paragraphs. For short essays, one level of
heading is often enough.

- Bulleted lists survive the column layout.
- They work best when they are short.
- Long list items start to feel like disguised paragraphs.

And numbered lists, when the order matters:

+ Set the paper size and orientation first.
+ Let the default column count follow from the size.
+ Override the column count only if you have a reason.

== Closing

A poster lives on a wall for a week and then rolls into a tube. Its job is
to make the passing reader stop for a moment. If the text earns that
moment, the design has done its work.
