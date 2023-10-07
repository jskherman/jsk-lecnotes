                                        
#import "@local/jsk-lecnotes:0.1.0": *  // or copy `src/template.typ` and use
                                        // import "template.typ": *`
#show: template.with(
  title: [Martingales, Brownian Motion,\ Ergodic Theory],
  short-title: "ChE Calculations 101",
  description: [
    Notes based on lectures for Math 6720 (Probability Theory II)\ at Cornell by Professor Lionel Levine, Spring 2020
  ],
  // date: datetime(year: 2020, month: 4, day: 1),
  authors: (
    (
      name: "Je Sian Keith Herman",
      orcid: "0000-0002-3281-1292",
      link: "https://jskherman.com",
      // affiliations: "1,2",
    ),
  ),
  affiliations: (
    // (id: "1", name: "University of British Columbia"),
    // (id: "2", name: "Curvenote Inc."),
  ),
  lof: false,
  lot: false,
  lol: false,
  // bibliography-file: "refs.bib",
  paper-size: "a4",
  columns: 1,
  text-font: "XCharter",
  code-font: "Cascadia Mono",
  accent: "#DC143C", // blue
)

#include "content/example-doc.typ"