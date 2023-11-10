#import "@preview/polylux:0.3.1": logic
#import "@preview/polylux:0.3.1": utils

#import "elements.typ": *
#import "colors.typ": *
#import "util.typ": *

///////////////
// Define state
///////////////

// sets up state
#let fau-theme(
  aspect-ratio: "16-9",
  short-title: none,
  short-author: none,
  short-date: none,
  institution: "Tech",
  body,
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )
  set text(font: "FAUSans Office", size: 24pt)
  // show footnote.entry: set text(size: .6em)

  // define global state (can't define it beforehand, otherwise title slide breaks)
  let _ = state("short-title", short-title)
  let _ = state("short-author", short-author)
  let _ = state("short-date", short-date)
  let _ = state("assets", AllAssets.at(institution))
  let _ = state("color", AllColors.at(institution))
  let _ = state("institution", institution)

  body
}

/////////////////
// slides
/////////////////

#let title-slide(
  title: "Title",
  subtitle: "Subtitle",
  authors: ("author1", "author 2"),
  institution: "FAU",
  date: datetime.today(),
) = {
  let background-color = FAUBlue
  let background-img = FAUAssets.Title

  set text(fill: white, font: "FAUSans Office", size: 20pt)
  set page(background: {
    set image(fit: "stretch", width: 100%, height: 100%)
    background-img
  }, margin: 1em)

  let content = locate(loc => {
    let colors = (a: FAUBlue, b: FAUBlue, c: FAUBlue)

    // let logo = WortmarkeBlue
    // if logo != none {
    //   align(right, logo)
    // }

    align(center + horizon, {
      block(inset: 0em, breakable: false, {
        text(size: 2em, fill: colors.a, strong(title))
        if subtitle != none {
          parbreak()
          text(size: 1.2em, fill: colors.a, subtitle)
        }
      })
      set text(size: .8em)
      grid(
        columns: (1fr,) * calc.min(authors.len(), 3),
        column-gutter: 1em,
        row-gutter: 1em,
        ..authors.map(author => text(fill: black, author)),
      )
      v(1em)
      let institution-name = "test"
      if institution-name != none {
        parbreak()
        text(size: .9em, institution-name)
      }
      if date != none {
        parbreak()
        date.display()
      }
    })
  })

  logic.polylux-slide(content)
}

#let slide(title: none, body) = {
  let header = locate(loc => {
    heading(title)
    line(length: 100%, stroke: 2mm + FAUBlue)
  })
  let footer = locate(loc => {
    text("fill")
  })

  set page(
    header: header,
    footer: footer,
    footer-descent: -2em,
    header-ascent: -2em,
  )

  logic.polylux-slide(body)
}

#let focus-slide(title: "", body) = slide(title: title, align(center + horizon, body))
