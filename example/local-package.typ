#import "@preview/polylux:0.4.0": *
#import "@local/fau-typst:0.0.1": fau-theme, main
#import fau-theme: *

#show: main.setup-theme.with(
  short-author: "Lukas Böhm",
  short-title: "Test Document",
  short-date: datetime.today(),
  short-organization: "Lab1",
)

#polylux-slide[
  need this empty slide at the beginngin due to a bug with state updates

  Issue will be resolved _hopefully_ soon.
]

#title-slide(
  title: "Test Document showing off the theme",
  subtitle: "in Typst, the new Markup Language",
  authors: (
    (
      name: "Theresa Tungsten",
      affiliation: "Artos Institute",
      email: "tung@artos.edu",
    ),
    (name: "Eugene Deklan", affiliation: "Honduras State"),
    (name: "Lukas Böhm"),
  ),
)

#slide(title: "Introduction", subtitle: "What is this?")[
  This file demonstrates the usage of the FAU theme for typst.
]
