                                        
#import "template.typ": *
#show: template.with(
  title: [Quantum Mechanics, Brownian Motion,\ Ergodic Theory],
  short_title: "Phys 123",
  description: [
    Notes based on lectures for Phys 123 (Statistical Mechanics II)\ at Bicol University by Professor John Doe, Spring 2020
  ],
  // date: datetime(year: 2023, month: 10, day: 01),
  authors: (
    (
      name: "Je Sian Keith Herman",
      orcid: "0000-0002-3281-1292",
      link: "https://jskherman.com",
      affiliations: "1,2",
    ),
  ),
  affiliations: (
    (id: "1", name: "Bicol University"),
    (id: "2", name: "JSK Inc."),
  ),
  lof: false,
  lot: false,
  lol: false,
  bibliography_file: "refs.bib",
  paper_size: "a4",
  columns: 1,
  text_font: "EB Garamond",
  code_font: "Cascadia Code",
  accent: "#DC143C", // blue
)

#include "content/example-doc.typ"