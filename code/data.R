library(reshape2)
library(dplyr)

## Old code for TableA from Andrea

read.tablea.old <- function (file) {
    r <- read.delim(file, sep = "\t", header = FALSE)
    colnames(r)[1] <- "Language"
    return (r)
}

tablea.long <- function (tablea) {
    melt(tablea, id.vars = "Language")
}

## Code for TableA from viewer app

remove.params <- function (r, params) {
    r <- r[-which(rownames(r) %in% params),]

    return (r)
}

remove.constant.params <- function (r) {
    constant.params <- character(0)

    for (i in 1:nrow(r)) {
        if (all(r[i,] == "0" | r[i,] == "-") ||
            all(r[i,] == "0" | r[i,] == "+")) {
            constant.params <- c(constant.params, rownames(r)[i])
        }
    }

    print(constant.params)

    r <- remove.params(r, constant.params)

    return (r)
}

read.tablea <- function (file) {
    r <- read.csv(file)
    rownames(r) <- r[,1]
    r <- r[,2:ncol(r)]
    r <- r %>%
      select(
          ## Remove Italian and Greek dialects
          -Mus, -Aid, -Scal, -Sal, -Ncal, -Cam, -Gri, -BoG, -RPG,
          ## Remove ancient languages
          -Got, -OE, -ClG, -NTG, -Lat,
          ## Remove Malagasy, Quichua, Chickasaw
          -Mal, -Qui, -ChK
          )

    ## Remove params for Southern Italy only, which are not set and/or
    ## relevant for other languages
    r <- remove.params(r, c("AGS", "AGO", "EM1", "DPN", "NTD", "OKP", "FVP", "ASF"))

    return (r)
}

calc.dist <- function (a, b) {
    ident <- 0
    diff <- 0
    if(length(a) != length(b)) {
        stop ("wtf")
    }
    for (i in 1:length(a)) {
        if (a[i] == "0" || b[i] == "0") {
            next
        }
        if (! (a[i] %in% c("+", "-")) ||
            ! (b[i] %in% c("+", "-"))) {
            print (a[i])
            print (b[i])
            stop ("wtf2")
        }
        if (a[i] == b[i]) {
            ident <- ident + 1
            #print(paste0("Ident ", rownames(tablea)[i]))
        } else {
            diff <- diff + 1
            #print(paste0("Diff ", rownames(tablea)[i]))
        }
    }
    #print(ident)
    #print(diff)
    return (1 - ident / (ident + diff))
}

calc.table.d <- function (tablea) {
    pairs <- expand.grid(a = colnames(tablea),
                         b = colnames(tablea))
    pairs$a <- as.character(pairs$a)
    pairs$b <- as.character(pairs$b)
    pairs <- subset(pairs, a < b)
    pairs$dist <- NA
    for (i in 1:nrow(pairs)) {
        a <- pairs[i,1]
        b <- pairs[i,2]
        if (a == b) {
            next
        }
        pairs[i,]$dist <- calc.dist(tablea[,a], tablea[,b])
    }
    return (pairs)
}

read.random <- function (path) {
    r <- read.delim(path, sep = "\t", header = FALSE)
    r <- data.frame(dist = r[,2])

    return (r)
}

IE <- c("SicRG", "It", "Sp", "Fr", "Ptg", "Rm", "Grk", "CyG", "E",
        "D", "Da", "Ice", "Nor", "Blg", "SC", "Slo", "Po", "Rus",
        "Ir", "Wel", "Ma", "Hi", "Far", "Pas")
ST <- c("Man", "Can")
Sem <- c("Heb", "Ar")
FU <- c("Hu","Fin","Est")
Tur <- c("Tur","Bur")
Bas <- c("cB","wB")

rm.intrafam.pairs <- function (tabled) {
    td <- filter(tabled,
                 !(a %in% IE & b %in% IE |
                     a %in% ST & b %in% ST |
                     a %in% Sem & b %in% Sem |
                     a %in% FU & b %in% FU |
                     a %in% Tur & b %in% Tur |
                     a %in% Bas & b %in% Bas))
    return (td)
}


tablea <- read.tablea("../data/taba.csv")
tabled <- calc.table.d(tablea)
