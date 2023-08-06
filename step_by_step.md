---links---
- https://nashhigh.itch.io/zinearranger


---process---
- Installed:
    - texlive-latex
    - texlive-latexrecommended
    - texlive-latexextra
    - pandoc

- based largely off https://learnbyexample.github.io/customizing-pandoc/
    - chapter breaks https://learnbyexample.github.io/customizing-pandoc/#chapter-breaks
    - bash script skeleton https://learnbyexample.github.io/customizing-pandoc/#changing-settings-via-v-option
    - syntax highlighting https://learnbyexample.github.io/customizing-pandoc/#syntax-highlighting
    - pdf properties
        - but I switched to frontmatter
    - cover image
        - but I just did it in markdown
- download IBM Plex Mono to make the font accurate
- customized line/paragraph spacing
    - \onehalfspacing
    - \setlength{\parskip}{18pt}
- customized title font/size
```latex
\usepackage{titlesec}
\titleformat{\section}
  {\normalfont\normalsize\bfseries\clearpage}{\thesection.}{1em}{}
\titleformat{\subsection}
  {\normalfont\normalsize\itshape}{\thesubsection.}{1em}{}
\titleformat{\subsubsection}
  {\normalfont\normalsize\itshape}{\thesubsubsection.}{1em}{}
```
- added page numbers, and they came with a cool header
    - docs: https://mirrors.mit.edu/CTAN/macros/latex/contrib/fancyhdr/fancyhdr.pdf
    - learned from: https://tex.stackexchange.com/a/40115
- a handful of commands to make formatting easier
    - \largefont | \smallfont - change to 14 and 10 px respectively
    - \clibyte - generate a centered code block at the bottom of the current page
    - \bcenter | \ecenter - make centering things actually work

- folding to half and quarter
    - based on https://tug.org/pracjourn/2006-3/venugopal-pocketbook/venugopal-pocketbook.pdf
    - with help from the docs: http://tug.ctan.org/macros/latex/contrib/booklet/booklet.pdf
        - talk about differences between a4 and letter

- and a simple bash script to make it all work nicely
    - outputs to a4, letter, and html
    - also outputs half-fold and quarter-fold pdfs


---typesetting notes---
- Mostly don't need to worry about formatting at all. As long as you're receiving valid markdown you can just copy/paste and use it.
- A few things require manual tweaking. These can be largely copied from issue to issue.
    - The hardest thing to set into the document was easily 'W3bK3rN3l radio outpost' due to the difficulty of escaping lots of characters
- Image sizing and centering may take a little bit of work depending on whether the original fits on the page or not, but the turnaround between running the command and getting a new pdf back is very fast.
- Most of the work was separating paragraphs and styling headers, which isn't a problem when you have the original text. The other big time wasters were lining up multiple images on a page and ensuring one large image didn't take up the entire space.
- You get half and quarter fold versions pretty much immediately.
- Being able to set metadata is nice.


---writing notes---
- Include a basic template for the beginning and ending of a ^zine issue as the "basic file" that can be copied and written into.
- Make sure to point out certain important things about pandoc markdown, like hard line breaks and line blocks for formatting, escaping characters, certain characters merging (ellipsis, .. , -->)
- Stress the importance of footnotes whenever including a link but not putting the full url in the text. Heck, stress the importance of footnotes in general.
    - unlinked: `This is a link stuck somewhere in the text.^[<https://google.com>]`
    - linked: `[This is a link stuck somewhere in the text.](https://google.com)^[https://google.com]`
    - stress that footnotes don't need to be used only for links.
- mention formatting you get for free, like code boxes having syntax highlighting, fancy headers, page numbers.
- TEST HOW FOOTNOTES COME OUT IN HTML < less important but still best to test it
- Encourage anyone making their own zine to customize some things to make it more unique.
- Encourage people submitting content for a zine made using this tool to format their entries in pandoc markdown ahead of time, and use the tool itself to test them, and encourage zine creators who customize the template to share that template for others to reference.


- by default it uses a template that's a bit more generic. the ^Z test includes a template for ^Z's distinctive look.
# how to customize
- go to makezine.sh and change the fonts, font size, margins, etc
- copy template.latex and change:
    - what section fonts look like
    - the page numbers
    - line spacing and parskip
- add any level of custom html/css
