This repository contains the supplementary material to the article
“Mathematical modeling of grammatical diversity successfully addresses
core probabilistic issues in historical linguistics.”  This was produced
by the [LanGeLin project][langelin] team with the support of ERC advanced grant
\#295736.

[langelin]: https://www.york.ac.uk/language/research/projects/langelin/

The authors of the article are:

- Giuseppe Longobardi
- Andrea Ceolin
- [Aaron Ecay][aaron]
- Luca Bortolussi
- Cristina Guardiano
- Monica-Alexandrina Irimia
- Dimitris Michelioudakis
- Nina Radkevich
- Andrea Sgarro

[aaron]: http://aaronecay.com

## Contents

The repository is organized into the following directories:

- `code`: Code for the analysis
  - `data.R` functions for reading in data
  - The figures in the article are generated as follows:
    - 1: `dist-plots.R`
    - 1S: manually
    - 2S: manually
    - 3S: `network.R`
    - 4S: manually
    - 5S: `tabled` from `data.R`
    - 6S: `trees.R` with manual adjustments for presentation
    - 7S: manually
    - 8S: manually
  - Tables:
    - 1: manually
    - 2: manually
    - 3: `misc-calcs.R`
    - 4: `misc-calcs.R`
  - `misc-calcs.R` contains code to generate some of the numbers quoted
    in the text
  - `regress.R` and `param-tendencies.R` are not currently used.
  - `generate.py` contains the python code for generating random languages.
- `data` data for the analysis
  - `taba.csv` Table A
  - `impls.txt` implications.  Format is X;Y means X will be set to 0
    on some condition of Y.  All dependencies are considered, even
    compound ones (where Y sets X to 0 only in the presence of some
    external Z)
  - `random.txt` Our sample of random languages.  Tab separated values,
    columns are:
    1. distance
    2. number of (non-zero) parameter identities
    3. number of (non-zero) parameter differences
    **NOTE**: this file is large (~150MB).  You will need to install and
    configure the [git-lfs](https://git-lfs.github.com/) plugin in order
    to download it.
  - `TableA.txt` unused older version/format of Table A.
- `figures` output directory for figures; also contains the source for
  an (unused) illustration of parameter-setting from Biberauer and
  Roberts (2012)
- `poster` LaTeX source for a poster version of these results presented
  at DiGS17 in Iceland (May 2015)

## Copyright

The materials in this repository are copyright of the authors.  They are
made available for scientific purposes, but you must ask permission
before redistributing them in any way.
