library(reshape2)

read.tablea <- function (file) {
    r <- read.delim(file, sep = "\t", header = FALSE)
    colnames(r)[1] <- "Language"
    return (r)
}

tablea.long <- function (tablea) {
    melt(tablea, id.vars = "Language")
}
