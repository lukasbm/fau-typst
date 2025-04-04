# Developer Notes

This might be important for developers

## Relevant Issues

- [double line spacing](https://github.com/typst/typst/issues/106)
- [restore layout](https://github.com/typst/typst/issues/361)
- [restore layout](https://github.com/typst/typst/issues/420)


## Develop

`cd example && typst watch --root .. --font-path ./fonts/ showcase.typ showcase.pdf`

## Helper: Convert all pdfs to svgs

Typst does not support embeddings PDFs yet. You need to convert all of them to SVGs first.
The following command will help you do this:
`find . -type f -name "*.pdf" -exec sh -c 'pdf2svg "$0" "${0%.pdf}.svg"' {} \;`

## Sources

- <https://www.intern.fau.de/kommunikation-und-marke/corporate-design/fau-schrift/>
- <https://www.doc.zuv.fau.de//M/Styleguide/FAU_Styleguide-Essentials_v26_2022-07-14.pdf>
- <https://www.intern.fau.de/kommunikation-und-marke/vorlagen/praesentationsvorlagen-powerpoint>
- <https://www.wordpress.rrze.fau.de/entwicklung/design/schriften/>
- <https://www.intern.fau.de/kommunikation-und-marke/corporate-design/fau-logo/>

### Fonts

- FAU Sans Office (kommerzielle Lizenz, nur für interne Zwecke)

### Custom Slide Types

You can easily create new custom slide types for any purpose.

When doing so, please be careful of the following key points:
- only call `slide as polylux-slide` and not some other slide function like `section-slide` to avoid clashing and broken styles
- you can avoid repetition by extracting the styling into separate functions as shown in `lib/styles.typ`
- extract common components (such as header, footer or sidebar) into it's own function as shown in `lib/components.typ`
- For actual implementation examples see the source of `lib/slides.typ`
