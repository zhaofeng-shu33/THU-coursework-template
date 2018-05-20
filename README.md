# THU coursework Template
[![Build Status](https://www.travis-ci.org/zhaofeng-shu33/THU-coursework-template.svg?branch=master)](https://www.travis-ci.org/zhaofeng-shu33/THU-coursework-template)
LaTeX package for students in Tsinghua University to write coursework more efficiently, also can be used by students from other university.

Notice that the package itself does not import ctex package, to use it with Chinese writing, see example file `ithw.tex` for detail.

## Features

 * support custom courseheader
 * automatic header setting
 * support coursework counter
 * definition of common math symbols

## ToDo

 * automatic enumerate environment labeling and reference

## Compiler from source

Use `make doc` or run the following commands one by one:

    xelatex thucoursework.dtx
    makeindex -s gind.ist -o thucoursework.ind thucoursework.idx
    makeindex -s gglo.ist -o thucoursework.gls thucoursework.glo
    xelatex thucoursework.dtx
    xelatex thucoursework.dtx

## Usage

`\usepackage{iidef}` and you are ready to go!

## Help
  see manual `thucoursework.pdf`

## Sample File

 * `iihw.tex` is the homework of **Information Inference**
 * `ithw.tex` is the homework of **Information Theory**, chinese version (to make it work, use `ctex` package in user file.)

## Contributors

 TA xiangxiangxu revised this template, zhaofeng-shu33 made it a latex package.

## License
 see [LICENSE.md](LICENSE.md) for detail.


