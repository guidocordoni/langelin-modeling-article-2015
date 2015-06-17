p <- function (...) {
    print(paste0(...))
}


## First paragraph under "sampling statistics" (langs); first para below "how
## many langs are there" (params)
print(paste0("TableA has ", ncol(tablea), " languages and ", nrow(tablea), " parameters"))

## first para below "how ## many langs are there"
p("This leads to ", 2 ^ nrow(tablea), " languages without taking into account implications")

## https://stat.ethz.ch/pipermail/r-help/2010-April/234387.html
median.test <- function (x, y) {
    z <- c(x ,y)
    g <- rep(1:2, c(length(x), length(y)))
    m <- median(z)
    fisher.test(z < m, g)$p.value
}


p("Median test p-value is ", median.test(tabled$dist, rand$dist))

p("Median test w/o intrafamily pairs is ", median.test(td.nif$dist, rand$dist))

subset(tabled, dist > 0.5)

quantile(rand$dist, 0.001)
quantile(rand$dist, 0.0001)
quantile(rand$dist, 0.00001)

sum(tabled$dist < quantile(rand$dist, 0.001))
sum(tabled$dist < quantile(rand$dist, 0.0001))
sum(tabled$dist < quantile(rand$dist, 0.00001))

euras <- c(IE, FU, Sem, Tur, Bas)

tabled$euras <- tabled$a %in% euras & tabled$b %in% euras

tabled$close <- tabled$dist < quantile(rand$dist, 0.001)

tabled$close2 <- tabled$dist < median(tabled$dist)

with(rm.intrafam.pairs(tabled), table(euras, close2))
fisher.test(with(rm.intrafam.pairs(tabled), table(euras, close2)))


sum(rm.intrafam.pairs(tabled)$dist < quantile(rand$dist, 0.001))
