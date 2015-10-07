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
    - 1: manually
    - 2: `dist-plots.R`
    - 3: XXXXX
    - 4: XXXXX
    - 1S: manually
    - 2S: manually
    - 3S: `network.R`
    - 4S: Manually
    - 5S: XXXXX
    - 6S: `trees.R` with manual adjustments for presentation
    - 7S: manually
    - 8S: manually
  - `misc-calcs.R` contains code to generate some of the numbers quoted
    in the text
  - `regress.R` and `param-tendencies.R` are not currently used.
- `data` data for the analysis
  - `taba.csv` Table A
  - `impls.txt` implications.  Format is X;Y means X will be set to 0
    on some condition of Y.  All dependencies are considered, even
    compound ones (where Y sets X to 0 only in the presence of some
    external Z)
  - `random.txt` Our sample of random languages.  Tab separated values,
    columns are:
    1. meaningless
    2. distance
    3. number of (non-zero) parameter identities
    4. number of (non-zero) parameter differences
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
