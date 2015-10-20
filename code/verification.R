## page 1

## page 2

nrow(tablea)                            # number of parameters
ncol(tablea)                            # number of langs

## page 3

## number of parameters -- see above
## number of generable languages -- calculated by Bortolussi
2 ^ nrow(tablea)

## page 4

## number of languages -- see above

nlang <- ncol(tablea)

nlang * (nlang-1) / 2                   # number of pairs

median(tabled$dist)                     # observed median

medians <- apply(rand40, 1, median)     # random medians

mean(medians)
quantile(medians, c(0.05, 0.95))
min(medians)

nrow(rand)                              # Number of random pairs

p("Median test p-value is ", median.test(tabled$dist, rand$dist))

p("Median test w/o intrafamily pairs is ", median.test(td.nif$dist, rand$dist))

quantile(rand$dist, 0.001)              # critical threshold

sum(tabled$dist < quantile(rand$dist, 0.001)) # number of langs below thresh.

sum(tabled$a %in% IE & tabled$b %in% IE) +
  sum(tabled$a %in% FU & tabled$b %in% FU) +
  sum(tabled$a %in% Alt & tabled$b %in% Alt) +
  sum(tabled$a %in% Sem & tabled$b %in% Sem) +
  sum(tabled$a %in% Bas & tabled$b %in% Bas) +
  sum(tabled$a %in% ST & tabled$b %in% ST)

sum(tabled$dist < quantile(rand$dist, 0.001) & (
    tabled$a %in% IE & tabled$b %in% IE |
    tabled$a %in% FU & tabled$b %in% FU |
    tabled$a %in% Alt & tabled$b %in% Alt |
    tabled$a %in% Sem & tabled$b %in% Sem |
    tabled$a %in% Bas & tabled$b %in% Bas |
    tabled$a %in% ST & tabled$b %in% ST)) # same family below thresh

## Page 5

with(rm.intrafam.pairs(tabled), min(dist)) # range of cross-fam pairs
with(rm.intrafam.pairs(tabled), max(dist))

with(rm.intrafam.pairs(tabled), sum(dist < quantile(rand$dist, 0.001))) # crossfam below thresh

sum(tabled$class == "IE/Fin-Ugr") # Number IE/FU

with(subset(tabled, class == "IE/Fin-Ugr"), sum(dist < quantile(rand$dist, 0.001))) # IE/FU below thresh

with(subset(tabled, class == "IE/Fin-Ugr"), sum(dist < quantile(rand$dist, 0.001))) / sum(tabled$class == "IE/Fin-Ugr") # percentage

hu.tur <- tabled[tabled$a == "Hu" & tabled$b == "Tur",]$dist

hu.tur                                  # Hu-Tur distance

sum(rand$dist < hu.tur) / nrow(rand)    # Hu-Tur probability

## Page 6

quantile(rand$dist, 0.999)              # Right-tail threshold

tabled[which.max(tabled$dist),]         # highest observed distance
