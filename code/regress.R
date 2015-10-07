## tabled$is.euras <- tabled$a %in% c(IE, FU, Tur, Bas) & tabled$b %in% c(IE, FU, Tur, Bas)


## summary(lm(dist ~ is.euras, data = rm.intrafam.pairs(tabled)))

library(sets)
library(dplyr)
`%>%` <- dplyr::`%>%`

library(AICcmodavg)
library(stringr)

fams <- gset(list(IE,
                  ST,
                  Sem,
                  FU,
                  Alt,
                  Bas,
                  "Ka",
                  "Ku",
                  "Jap",
                  "Inu",
                  "Wo"))

fams.pset <- as.list(2^fams)

fams.pset <- Map(function(x) Reduce(c,x), fams.pset)

res <- NULL
for (i in 2:length(fams.pset)) {
    tabled$tmp <- factor(ifelse(tabled$a %in% fams.pset[[i]] & tabled$b %in% fams.pset[[i]],
                                "A",
                         ifelse(tabled$a %in% fams.pset[[i]] | tabled$b %in% fams.pset[[i]],
                                "X", "B")))
    tab <- rm.intrafam.pairs(tabled)
    if(any(tab$tmp == "A") && any(tab$tmp == "B") && any(tab$tmp == "X")) {
        m <- lm(dist ~ tmp, data = tab)
        res <- rbind(res,
                     data.frame(langs = str_c(fams.pset[[i]], collapse =","),
                                aic = AICc(m)))
    }
}
