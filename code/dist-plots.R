library(ggplot2)
library(grid)

rand <- read.random("../data/random.txt")
rand$Type <- "Random"
rand$ind <- TRUE
data <- rbind(rand,
              data.frame(dist = tabled$dist,
                         Type = "Observed",
                         ind = TRUE))

png("../figures/distributions.png", width = 6, height = 6, units = "in",
    res = 300)

ggplot(data, aes(x = dist, color = Type)) +
  geom_density(adjust = 2) +
  theme_bw() +
  ylab("") +
  xlab("Distance") +
  theme(plot.margin = unit(c(0,0,0,0), "mm"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

dev.off()


td.nif <- rm.intrafam.pairs(tabled)

data <- rbind(data,
              data.frame(dist = td.nif$dist,
                         Type = "Obs. (no intra-fam.)",
                         ind = FALSE))

png("../figures/distributions2.png", width = 6, height = 6, units = "in",
    res = 300)

ggplot(data, aes(x = dist, color = Type, size = Type, linetype = Type)) +
  geom_density(adjust = 2) +
  theme_bw() +
  ylab("") +
  xlab("Distance") +
  scale_linetype_manual(values = c("dashed", "solid", "solid")) +
  scale_size_manual(values = c(0.5,1,1)) +
  theme(plot.margin = unit(c(0,0,0,0), "mm"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

dev.off()

pdf("../figures/distributions-poster.pdf", width = 6, height = 3)

ggplot(data, aes(x = dist, color = Type)) +
  geom_density(adjust = 2) +
  theme_bw() +
  ylab("") +
  xlab("Distance") +
  theme(plot.margin = unit(c(0,0,0,0), "mm"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

dev.off()

pdf("../figures/distributions2.pdf", width = 6, height = 6)

ggplot(data, aes(x = dist, color = Type)) +
  geom_density(adjust = 2) +
  theme_bw() +
  ylab("") +
  xlab("Distance") +
  theme(plot.margin = unit(c(0,0,0,0), "mm"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

dev.off()

tabled.close <- subset(rm.intrafam.pairs(tabled), dist < quantile(rand$dist, 0.001))

classify.pair <- function (a, b) {
    x <- ifelse(a %in% IE, "IE",
                ifelse(a %in% FU, "FU",
                ifelse(a %in% ST, "ST",
                ifelse(a %in% Sem, "Sem",
                ifelse(a %in% Tur, "Tur",
                ifelse(a %in% Bas, "Bas",
                       a))))))
    y <- ifelse(b %in% IE, "IE",
                ifelse(b %in% FU, "FU",
                ifelse(b %in% ST, "ST",
                ifelse(b %in% Sem, "Sem",
                ifelse(b %in% Tur, "Tur",
                ifelse(b %in% Bas, "Bas",
                       b))))))

    z <- ifelse(x < y, paste0(x,y), paste0(y,x))
           ifelse(z == "FUIE", "IE/Fin-Ugr",
           ifelse(z == "BasIE", "IE/Basque",
           ifelse(z == "FUTur", "Fin-Ugr/Altaic",
           ifelse(z == "IESem", "IE/Sem",
           ifelse(z == "IETur", "IE/Alt",
           ifelse(z == "IEInu", "IE/Inuk",
           ifelse(z == "IEIE", "IE", "Other")))))))
}

tabled.close$class <- classify.pair(tabled.close$a, tabled.close$b)

tabled$class <- classify.pair(tabled$a, tabled$b)


tab <- table(tabled.close$class)
nms <- rownames(tab)[order(tab, decreasing = TRUE)]
nms <- nms[nms != "Other"]
nms <- c(nms, "Other")

png("../figures/close-pair-bars.png", width = 6, height = 6, units = "in",
    res = 300)

ggplot(tabled.close, aes(x = class)) +
  geom_bar() +
  scale_x_discrete(limits = nms)+
  theme_bw() +
  theme(plot.margin = unit(c(0,0,0,0), "mm"),
        axis.title.x = element_blank()) +
  ylab("Count")

dev.off()

pdf("../figures/close-pair-bars-poster.pdf", width = 6, height = 3)

ggplot(tabled.close, aes(x = class)) +
  geom_bar() +
  scale_x_discrete(limits = nms)+
  theme_bw() +
  theme(plot.margin = unit(c(0,0,0,0), "mm"),
        axis.title.x = element_blank()) +
  ylab("Count")

dev.off()

pair.dots <- function (tabled) {
    tabled %>%
    filter(class != "Other") %>%
    group_by(class) %>%
    summarize(n = n(), s = sum(close)) %>%
    mutate(p = s/n) %>%
    ggplot(aes(x = class, y = p)) +
    geom_point(aes(size = n)) +
    scale_size_area("Number of pairs") +
    coord_cartesian(ylim=c(-0.05,1.05)) +
    scale_x_discrete(limits=c("IE","IE/Fin-Ugr","IE/Basque","IE/Sem","IE/Alt",
                              "IE/Inuk","Fin-Ugr/Altaic")) +
    xlab("Comparison type") +
    ylab("Proportion below critical thresh.") +
    theme(text = element_text(size = 8))
}

pair.dots.mean <- function (tabled) {
    tabled %>%
    filter(class != "Other") %>%
    group_by(class) %>%
    summarize(n = n(), mean = mean(dist), median = median(dist)) %>%
    ggplot(aes(x = class, y = median)) +
    geom_point(aes(size = n)) +
    scale_size_area("Number of pairs") +
    coord_cartesian(ylim=c(-0.05,1.05)) +
    scale_x_discrete(limits=c("IE","IE/Fin-Ugr","IE/Alt","IE/Basque","IE/Sem","Fin-Ugr/Altaic",
                              "IE/Inuk")) +
    xlab("Comparison type") +
    ylab("Proportion below critical thresh.") +
    theme(text = element_text(size = 8))
}


pdf("../figures/pair-dots.pdf", width = 6, height = 6)
pair.dots(tabled)
dev.off()

png("../figures/pair-dots.png", width = 6, height = 6, units = "in", res = 300)
pair.dots(tabled)
dev.off()

one.ie <- sum((tabled$a %in% IE & ! (tabled$b %in% IE)) |
                (tabled$b %in% IE & ! (tabled$a %in% IE)))

non.if <- nrow(rm.intrafam.pairs(tabled))

one.ie.close <- sum(! tabled.close$class %in% c("Other", "Fin-Ugr/Altaic"))

non.if.close <- nrow(tabled.close)


for (i in 1:nrow(tabled)) {
    row <- tabled[i,]
    if (row$a == "SicRG" | row$b == "SicRG") {
        next
    }
    ldrow <- subset(ld, (a == row$a & b == row$b) | (b == row$a & a == row$b))
    if (row$dist - ldrow$V2 > 0.001) {
        print(row$a)
        print(row$b)
        print(row$dist)
        print(ldrow$V2)
    }
}
