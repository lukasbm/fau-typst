#import "@preview/polylux:0.3.1": logic
#import "@preview/polylux:0.3.1": utils

#import "elements.typ": *
#import "colors.typ": *
#import "util.typ": *
#import "fonts.typ": *

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
  // set up global settings
  let ascent = 2.5mm

  set page(
    paper: "presentation-" + aspect-ratio,
    margin: (
      left: config.SideBarWidthLeft,
      top: config.HeaderHeight + ascent,
      right: config.InnerRightMargin,
      bottom: config.FootHeight + ascent,
    ),
    header: none,
    footer: none,
    footer-descent: ascent,
    header-ascent: ascent,
  )

  set text(font: FontFamily, size: 24pt)

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
  })

  let header = locate(
    loc => {
      let col = FAUColors // color(state("institution").at(loc))
      let assets = FAUAssets

      //  FIXME: layout/alignment by using grid or columns ...

      // Kennung
      set align(top + left)
      assets.KennungWhite

      // Logo
      set align(top + right)
      set image(width: config.WordMarkTitleWidth, height: config.WordMarkTitleHeight)
      WortmarkeWhite

      // line
      show line: set block(above: 0em, below: 0mm)
      line(length: 200%, stroke: config.LineWidthThick + col.SeparationLineColor)
    },
  )

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

  set page(header: header)
  logic.polylux-slide(content)
}

#let slide(title: none, subtitle: none, body) = {
  let header = locate(
    loc => {
      let col = FAUColors // color(state("institution").at(loc))

      // title
      set align(top + left)
      show text: set block(above: 0em, below: 0em)
      if title != none {
        text(size: TitleFontSize, weight: "bold", fill: col.BaseColor, title)
      }
      if title != none and subtitle != none {
        linebreak()
        text(size: SecondFontSize, fill: col.BaseColor, subtitle)
      }

      // logo
      set align(bottom + right)
      set image(width: config.WordMarkWidth, height: config.WordMarkHeight)
      WortmarkeBlue

      // line
      set align(bottom + left)
      show line: set block(above: 0em, below: 3mm)
      line(length: 200%, stroke: config.LineWidthThick + col.SeparationLineColor)
    },
  )
  let footer = locate(
    loc => {
      let col = FAUColors // color(state("institution").at(loc))

      // line
      show line: set block(above: 0em, below: 3mm)
      line(length: 200%, stroke: config.LineWidthThin + col.SeparationLineColor)

      // short texts
      set text(11pt)
      let quad = 0.7cm
      text("short institution")
      h(quad)
      text("short author")
      h(quad)
      text(col.BaseColor)["short title"]
      h(1fr)
      text("short date")
      h(quad)
      text(logic.logical-slide.display() + [~/~] + utils.last-slide-number)
      h(quad)
    },
  )

  set page(header: header, footer: footer)

  logic.polylux-slide(body)
}

#let focus-slide(title: "", body) = slide(title: title, align(center + horizon, body))

// TODO:
#let slide-plain = slide

// TODO:
#let slide-blank = slide

// TODO:
#let toc(highlight: (:)) = slide

// TODO: flesh it out to get toc overview (also use toc slide)
#show heading: it => [
  #slide(title: it, body: none)
]
