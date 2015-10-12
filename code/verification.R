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

## TODO: random experiment

p("Median test p-value is ", median.test(tabled$dist, rand$dist))

p("Median test w/o intrafamily pairs is ", median.test(td.nif$dist, rand$dist))

quantile(rand$dist, 0.001)              # critical threshold

sum(tabled$dist < quantile(rand$dist, 0.001)) # number of langs below thresh.

sum(tabled$class == "IE") # IE pairs

sum(tabled$dist < quantile(rand$dist, 0.001) & tabled$class == "IE") # IE below thresh

sum(tabled$dist < quantile(rand$dist, 0.001) & tabled$class == "IE") / sum(tabled$class == "IE") # percentage

## Page 5

with(rm.intrafam.pairs(tabled), min(dist)) # range of cross-fam pairs
with(rm.intrafam.pairs(tabled), max(dist))

with(rm.intrafam.pairs(tabled), sum(dist < quantile(rand$dist, 0.001))) # crossfam below thresh

sum(tabled$class == "IE/Fin-Ugr") # Number IE/FU

with(subset(tabled, class == "IE/Fin-Ugr"), sum(dist < quantile(rand$dist, 0.001))) # IE/FU below thresh

with(subset(tabled, class == "IE/Fin-Ugr"), sum(dist < quantile(rand$dist, 0.001))) / sum(tabled$class == "IE/Fin-Ugr") # percentage

hu.tur <- tabled[tabled$a == "Hu" & tabled$b == "Tur",]$dist

hu.tur                                  # Hu-Tur distance

## TODO: wrong random dataset
sum(rand$dist < hu.tur) / nrow(rand)    # Hu-Tur probability

## Page 6

quantile(rand$dist, 0.999)              # Right-tail threshold

tabled[which.max(tabled$dist),]         # highest observed distance
