library(phangorn)
library(Rphylip)
library(memisc)
library(ggtree)
library(dplyr)

make.distance.matrix <- function (tabled) {
    langs <- union(levels(factor(tabled$a)), levels(factor(tabled$b)))
    d <- length(langs)
    m <- matrix(rep.int(0, d*d), nrow = d, ncol = d)
    rownames(m) <- langs
    colnames(m) <- langs

    for (i in 1:nrow(tabled)) {
        a <- as.character(tabled[i,]$a)
        b <- as.character(tabled[i,]$b)
        dist <- tabled[i,]$dist

        m[a,b] <- dist
        m[b,a] <- dist
    }

    return (m)
}

make.tree <- function (dists) {
    upgma(dists)
}

make.kitsch <- function (dists) {
    ## FIXME: negative = TRUE apparently disallows negative lengths, contrary
    ## to its name...
    t <- Rkitsch(dists, quiet = TRUE, negative = TRUE, path = "/usr/bin")

    return (t)
}

lang.to.name <- function (x) {
    return (memisc::recode(x,
                           "SicRG" -> "Sicilian",
                           "It" -> "Italian",
                           "Sp" -> "Spanish",
                           "Fr" -> "French",
                           "Ptg" -> "Portuguese",
                           "Rm" -> "Romanian",
                           "Grk" -> "Greek (standard)",
                           "CyG" -> "Cypriot Greek",
                           "E" -> "English",
                           "D" -> "German",
                           "Da" -> "Danish",
                           "Ice" -> "Icelandic",
                           "Nor" -> "Norwegian",
                           "Blg" -> "Bulgarian",
                           "SC" -> "Serbo-Croatian",
                           "Slo" -> "Slovenian",
                           "Po" -> "Polish",
                           "Rus" -> "Russian",
                           "Ir" -> "Irish",
                           "Wel" -> "Welsh",
                           "Ma" -> "Marathi",
                           "Hi" -> "Hindi",
                           "Far" -> "Farsi",
                           "Pas" -> "Pashto",
                           "Ar" -> "Arabic",
                           "Heb" -> "Hebrew",
                           "Hu" -> "Hungarian",
                           "Est" -> "Estonian",
                           "Fin" -> "Finnish",
                           "Tur" -> "Turkish",
                           "Bur" -> "Buryat",
                           "cB" -> "Basque (central)",
                           "wB" -> "Basque (western)",
                           "Can" -> "Cantonese",
                           "Man" -> "Mandarin",
                           "Inu" -> "Inuktitut",
                           "Wo" -> "Wolof",
                           "Ka" -> "Kadiweu",
                           "Ku" -> "Kuikuro",
                           "Jap" -> "Japanese"))
}


## Actually produce the trees

## One: "Wolof to Inuktitut"

rootdir <- system("git rev-parse --show-toplevel")

setwd(paste0(rootdir, "/figures"))

pdf("treeone.pdf")
tablea.one <- remove.constant.params(
    select(tablea,
           SicRG, It, Sp, Fr, Ptg, Rm, Grk, CyG, E, D, Da,
           Ice, Nor, Blg, SC, Slo, Po, Rus, Ir, Wel, Ma, Hi,
           Far, Pas, Ar, Heb, Hu, Est, Fin, Tur, Bur,cB,
           wB, Can, Man))
dists.one <- calc.table.d(tablea.one)
dm.one <- make.distance.matrix(dists.one)
plot(make.kitsch(dm.one))
dev.off()

## Two: adding Inu and Wo

pdf("treetwo.pdf")
tablea.two <- remove.constant.params(
    select(tablea,
           SicRG, It, Sp, Fr, Ptg, Rm, Grk, CyG, E, D, Da,
           Ice, Nor, Blg, SC, Slo, Po, Rus, Ir, Wel, Ma, Hi,
           Far, Pas, Ar, Heb, Hu, Est, Fin, Tur, Bur,cB,
           wB, Can, Man, Inu, Wo))
dists.two <- calc.table.d(tablea.two)
dm.two <- make.distance.matrix(dists.two)
plot(make.kitsch(dm.two))
dev.off()

## Three: adding Ka and Ku

## Figure 5S

tiff("../figures/treethree.tif", width = 6, height = 8, units = "in", res = 300)

tablea.three <-
  dplyr::select(tablea,
                SicRG, It, Sp, Fr, Ptg, Rm, Grk, CyG, E, D, Da,
                Ice, Nor, Blg, SC, Slo, Po, Rus, Ir, Wel, Ma, Hi,
                Far, Pas, Ar, Heb, Hu, Est, Fin, Tur, Bur, cB,
                wB, Can, Man, Inu, Wo, Ka, Ku, Jap)

dists.three <- calc.table.d(tablea.three)

dists.three$a <- lang.to.name(dists.three$a)
dists.three$b <- lang.to.name(dists.three$b)

dm.three <- make.distance.matrix(dists.three)

kitsch <- make.kitsch(dm.three)

g <- ggtree(kitsch) + geom_tiplab() + scale_x_continuous(limits = c(0,0.25))
print(g)

dev.off()

## Four: adding Qui and ChK

pdf("treefour.pdf")

tablea.four <- remove.constant.params(
    select(tablea,
           SicRG, It, Sp, Fr, Ptg, Rm, Grk, CyG, E, D, Da,
           Ice, Nor, Blg, SC, Slo, Po, Rus, Ir, Wel, Ma, Hi,
           Far, Pas, Ar, Heb, Hu, Est, Fin, Tur, Bur,cB,
           wB, Can, Man, Inu, Wo, Ka, Ku, Qui, ChK))
dists.four <- calc.table.d(tablea.four)
dm.four <- make.distance.matrix(dists.four)
plot(make.kitsch(dm.four))

dev.off()
