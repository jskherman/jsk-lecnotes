#import "lib.typ": *

#show: template.with(
  title: [Boiga Event Spaces, Distributions,\ Hypotheses Testing, and Statistical Tests],
  short_title: "Probability II",
  description: [
    Notes based on lectures for Probability II (Engineering Data Analysis II)\ at the University of Chicago by Professor John Doe, Spring 2020
  ],
  date: datetime(year: 2024, month: 12, day: 25),
  authors: (
    (
      name: "Je Sian Keith Herman",
      link: "https://jskherman.com",
    ),
  ),
  
  // lof: true,
  // lot: true,
  // lol: true,
  bibliography_file: "refs.bib",
  paper_size: "a4",
  // landscape: true,
  cols: 1,
  text_font: "STIX Two Text",
  code_font: "Cascadia Mono",
  accent: "#1A41AC", // blue
  h1-prefix: "Lecture",
  colortab: true,
)

#include "content/doc1.typ"
