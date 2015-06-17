library(phangorn)
library(Rphylip)

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

pdf("../figures/treethree.pdf", width = 6, height = 8)

tablea.three <-
    select(tablea,
           SicRG, It, Sp, Fr, Ptg, Rm, Grk, CyG, E, D, Da,
           Ice, Nor, Blg, SC, Slo, Po, Rus, Ir, Wel, Ma, Hi,
           Far, Pas, Ar, Heb, Hu, Est, Fin, Tur, Bur,cB,
           wB, Can, Man, Inu, Wo, Ka, Ku, Jap)
dists.three <- calc.table.d(tablea.three)
dm.three <- make.distance.matrix(dists.three)
plot(make.kitsch(dm.three), no.margin = TRUE)

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
