// Imports =============================================================

#import "@preview/whalogen:0.2.0": ce
#import "@preview/codly:1.1.1": codly-init, codly
#import "@preview/codly-languages:0.1.1": codly-languages
#import "@preview/showybox:2.0.3": showybox
#import "@preview/ctheorems:1.1.3": thmenv, thmrules

// Template ============================================================

#let template(
  // The title of the lecture notes
  title: "Lecture Notes Title",

  // The short_title is shown in the running header
  short_title: none, // string

  // The description of the lecture notes; is optional. Example:
  // description: [A template for lecture notes]
  description: none,

  // The date of the lecture notes; is optional. Example
  // datetime(year: 2020, month: 02, day: 02)
  date: none,

  // An array of authors. For each author you can specify a name, orcid, and affiliations.
  // affiliations should be content, e.g. "1", which is shown in superscript and should match the affiliations list.
  // Everything but but the name is optional.
  authors: (
      // name: "",
      // link: ""
  ),

  // Enable/disable the list of figures, tables, and listings.
  lof: false,
  lot: false,
  lol: false,

  // The path to a bibliography file if you want to cite some external works.
  bibliography_file: none,
  // Citation style
  bibstyle: "apa",

  // The article's paper size. Also affects the margins.
  paper_size: "a4",
  // page orientation
  landscape: false,

  // The number of columns to be used in the page
  cols: 1,

  // The text and code font. Must be a valid font name.
  text_font: "Libertinus Serif",
  code_font: "DejaVu Sans Mono",

  // The color of the lecture notes' accent color. Must be a valid HEX color.
  accent: "#DC143C",
  h1-prefix: "Lecture",
  colortab: false,

  // The lecture notes' content.
  body

) = {
  // Necessary for ctheorems package
  show: thmrules

  let accent_color = {
    if type(accent) == "string" {
      rgb(accent)
    } else if type(accent) == "color" {
      accent
    } else {
      rgb("#DC143C")
    }
  }

  // Construct string title from title content
  let str_title = ""

  if type(title) == content and title.has("children") {
    for element in title.children {
      if element.has("text") {
        str_title = str_title + element.text + " " 
      }
    }
  } else if type(title) == "string" {
    str_title = title
  }
    
  str_title = str_title.trim(" ")

  // Set document metadatra
  set document(title: str_title, author: authors.map(author => author.name))

  // Set the text and code font
  set text(font: text_font, size: 10pt)
  show raw: set text(font: code_font)

  // Make links blue and underlined. Disable for author list.
  show link: it => {
    let author_names = ()
    for author in authors {
      author_names.push(author.name)
    }
    
    if it.body.has("text") and it.body.text in author_names {
      it
    } else {
      underline(stroke: (dash: "densely-dotted"), offset: 2pt, text(fill: accent_color, it)) 
    }
  }

  // Configure the page.
  set page(
    paper: paper_size,
    columns: cols,
    flipped: landscape,
    numbering: "1",
    number-align: center,
    header: context {
      let elems = query(
        selector(heading.where(level: 1)).before(here())
      )
      
      let head_title = text(fill: accent_color, {
        if short_title != none { short_title } else { str_title }
      })
      
      if elems.len() == 0 {
        align(right, "")
      } else {
        let current_heading = elems.last()
        if current_heading.numbering != none {
          head_title + h(1fr) + emph(h1-prefix + " " + counter(heading.where(level: 1)).display("1: ") + current_heading.body)
        } else {
          head_title + h(1fr) + emph(current_heading.body)
        }
        v(-6pt)
        line(length: 100%, stroke: (thickness: 1pt, paint: accent_color, dash: "solid"))
      }
    },

  background: if colortab {
      place(top + right, rect(fill: gradient.linear(angle: 45deg, white, accent_color), width: 100%, height: 1em))
      // place(bottom + left, rect(fill: gradient.linear(angle: 45deg, accent_color, white), width: 100%, height: 1em))
    } else { none }
)

  set text(10pt)
  // Configure equation numbering and spacing.
  set math.equation(numbering: "[1.1]")
  show math.equation: eq => {
    set block(spacing: 0.65em)
    eq
  }

  // Configure lists.
  set enum(indent: 0pt, body-indent: 6pt)
  set list(indent: 0pt, body-indent: 6pt)

  // TODO: Configure headings
  // set heading(numbering: "1A.1A.1A.")
  show selector(heading.where(level: 1)): set heading(numbering: 
    (..nums) => h1-prefix + " " + nums
      .pos()
      .map(str)
      .join(".") + ":" ,
  )
  show selector(heading.where(body: [Contents])).or(
    heading.where(body: [List of Figures]).or(
      heading.where(body: [List of Tables]).or(
        heading.where(body: [List of Listings])
      )
    )
  ): set heading(numbering: none)
  show selector(heading.where(body: [References])): set heading(numbering: none)
  
  show heading: it => {
    it
    v(12pt, weak: true)
  }

  // Configure code blocks.
  show: codly-init.with()
  codly(languages: codly-languages)
  
  show raw.where(block: false): it => box(fill: luma(236), inset: (x: 2pt), outset: (y: 3pt), radius: 1pt)[#it]
  

  // Configure figures
  // set figure(placement: auto)
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  show figure.where(
    kind: raw
  ): it => {
    v(0.5em)
    it
    v(0.5em) 
  }

  // Create color tab at the upper right corner

  // Display the paper's title and description.
  align(center, [
    #set text(18pt, weight: "bold")
    #title
    ])
  if description != none {
    align(center, box(width: 90%)[
      #set text(size: 12pt, style: "italic")
      #description
    ])
  }
  v(18pt, weak: true)

  // Authors and affiliations
  align(center)[
    #if authors.len() > 0 {
      box(inset: (y: 10pt), {
        authors.map(author => {
          text(11pt, weight: "semibold")[
            #if "link" in author {
              [#link(author.link)[#author.name]]
            } else { author.name }]
        }).join(", ", last: {
          if authors.len() > 2 {
            ", and"
          } else {
            " and"
          }
        })
      })
    }
  ]
  v(6pt, weak: true)

  // Display the lecture notes' last updated date.
  if date != none {
  align(center, table(
    columns: (auto, auto),
    stroke: none,
    gutter: 0pt,
    align: (right, left),
    [#text(size: 11pt, "Published:")],
    [#text(
      size: 11pt,
      fill: accent_color,
      weight: "semibold",
      date.display("[month repr:long] [day padding:zero], [year repr:full]")
    )
    ],
    text(size: 11pt, "Last updated:"),
    text(
      size: 11pt,
      fill: accent_color,
      weight: "semibold",
      datetime.today().display("[month repr:long] [day padding:zero], [year repr:full]")
    )
  ))
  } else {
    align(center,
    text(size: 11pt)[Last updated:#h(5pt)] + text(
      size: 11pt,
      fill: accent_color,
      weight: "semibold",
      datetime.today().display(
        "[month repr:long] [day padding:zero], [year repr:full]"
      )
    )
    )
  }
  v(18pt, weak: true)

  show outline.entry: it => {
    text(fill: accent_color, it)
  }

  // Display the lecture notes' table of contents.
  heading(level: 1, outlined: false)[Contents]
  outline(indent: auto, title: none)

  if lof or lot or lol {
    show heading.where(level: 1): set text(size:0.9em)
    if lof {
      v(4pt)
      heading(level: 1)[List of Figures]
      outline(
        indent: auto,
        title: none,
        target: figure.where(kind: image),
      )
    }
  
    if lot {
      v(4pt)
      heading(level: 1)[List of Tables]
      outline(
        indent: auto,
        title: none,
        target: figure.where(kind: table),
      )
    }
  
    if lol {
      v(4pt)
      heading(level: 1)[List of Listings]
      outline(
        indent: auto,
        title: none,
        target: figure.where(kind: raw),
      )
    }

  align(center)[#v(1em) * \* #sym.space.quad \* #sym.space.quad \* *]
  }
  
  v(2em, weak: true)

  // Set paragraph to be justified and set linebreaks
  set par(justify: true, linebreaks: "optimized", leading: 0.8em)

  // Display the lecture notes' content.
  body

  v(24pt, weak: true)

  // Display bibliography.
  if bibliography_file != none {
    align(center)[#v(0.5em) * \* #sym.space.quad \* #sym.space.quad \* * #v(0.5em)]
    bibliography(bibliography_file, title: [References], style: bibstyle)
  }
}

// Functions ===========================================================

// Configure blockquotes.
#let blockquote(cite: none, body) = [
  #set text(size: 0.97em)
  #pad(left: 1.5em)[
    #block(
    breakable: true,
    width: 100%,
    fill: gray.lighten(90%),
    radius: (left: 0pt, right: 5pt),
    stroke: (left: 5pt + gray, rest: 1pt + silver),
    inset: 1em
    )[#body]
  ]
]


// Configure horizontal ruler
#let horizontalrule = {
  v(1em)
  line(start: (37%,0%), end: (63%,0%), stroke: stroke((thickness: 0.5pt, dash: "solid")))
  v(1em)
}

// Configure alternative horizontal ruler
#let sectionline = align(center)[#v(0.5em) * \* #sym.space.quad \* #sym.space.quad \* * #v(0.5em)]

// Attempt to add \boxed{} command from LaTeX
#let dboxed(content) =  {
    box(stroke: 0.5pt + black, outset: (x: 1pt, y: 8pt), inset: (x: 2pt, y: 1pt), baseline: 6pt, $display(#content)$)
  } 
  
#let iboxed(content) = {
    box(stroke: 0.5pt + black, outset: (x: 1pt, y: 3pt), inset: (x: 2pt, y: 1pt), baseline: 1pt, $#content$)
  }

// ==== Nice boxes using showybox and ctheorems packages ====
//
// | Environment | Accent Color         |
// |-------------|----------------------|
// | Definition  | olive                |
// | Example     | purple               |
// | Note        | blue                 |
// | Attention   | red / rgb("#DC143C") |
// | Quote       | black                |
// | Theorem     | navy                 |  
// | Proposition | maroon               |
// | Hypothesis  | orange               |

#let boxnumbering = "1.1.1.1.1.1"
#let boxcounting = "heading"

#let definition = thmenv(
  "Definition",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Definition #number],
      frame: (
        border-color: olive,
        title-color:  olive.lighten(30%),
        body-color:   olive.lighten(95%),
        footer-color: olive.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)

#let example = thmenv(
  "example",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Example #number],
      frame: (
        border-color: purple,
        title-color:  purple.lighten(30%),
        body-color:   purple.lighten(95%),
        footer-color: purple.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)

#let note = thmenv(
  "note",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Note #number],
      frame: (
        border-color: blue,
        title-color:  blue.lighten(30%),
        body-color:   blue.lighten(95%),
        footer-color: blue.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)

#let attention = thmenv(
  "attention",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Attention #number],
      frame: (
        border-color: rgb("#DC143C"),
        title-color:  rgb("#DC143C").lighten(30%),
        body-color:   rgb("#DC143C").lighten(95%),
        footer-color: rgb("#DC143C").lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)

#let quote = thmenv(
  "quote",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Quote #number],
      frame: (
        border-color: black,
        title-color:  black.lighten(30%),
        body-color:   black.lighten(95%),
        footer-color: black.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)

#let theorem = thmenv(
  "theorem",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Theorem #number],
      frame: (
        border-color: navy,
        title-color:  navy.lighten(30%),
        body-color:   navy.lighten(95%),
        footer-color: navy.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)

#let proposition = thmenv(
  "Proposition",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Proposition #number],
      frame: (
        border-color: maroon,
        title-color:  maroon.lighten(30%),
        body-color:   maroon.lighten(95%),
        footer-color: maroon.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)


#let hypothesis = thmenv(
  "hypothesis",
  boxcounting,
  none,
  (name, number, body, ..args) => {
    showybox(
      title: [*#name* #h(1fr) Hypothesis #number],
      frame: (
        border-color: orange,
        title-color:  orange.lighten(10%),
        body-color:   orange.lighten(95%),
        footer-color: orange.lighten(80%),
      ),
      ..args.named(),
      body
    )
  }
).with(numbering: boxnumbering)
