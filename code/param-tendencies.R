library(dplyr)
library(grid)
library(gridExtra)
library(ggplot2)

source("data.R")

tablea <- read.tablea("../data/TableA.txt")

nlangs <- nrow(tablea)

tablea.param.freqs <- tablea.long(tablea) %>%
    group_by(variable) %>%
    summarize(plus = sum(value == "+"),
              minus = sum(value == "-"),
              zero = sum(value == "0")) %>%
    mutate(p = plus / (plus + minus))

## Adapted from the waffle package <https://github.com/hrbrmstr/waffle>
cols <- 7
lvls <- length(levels(tablea.param.freqs$variable))
dat <- expand.grid(x = seq_len(ceiling(lvls / cols)),
                   y = cols:1)
dat$value <- c(tablea.param.freqs$p,
               rep(NA, nrow(dat) - nrow(tablea.param.freqs))
               )
dat$zero <- c(tablea.param.freqs$zero,
              rep(NA, nrow(dat) - nrow(tablea.param.freqs))
              )
indiv.params <- ggplot(dat, aes(x = x, y = y, color = value,
                                size = 100 * (1 - zero / nlangs))) +
  geom_point(shape = 15) +
  scale_size_area(name = "Percent non-0", max_size = 10,
                  breaks = c(100, 50)) +
  labs(x = "ones", y = "tens", title = "Individual parameter values") +
  scale_x_continuous(expand = c(0.05, 0.05), breaks = 1:10, labels = c(1:10)) +
  scale_y_continuous(expand = c(0.05, 0.05), breaks = 1:7, labels = 6:0) +
  coord_equal() +
  theme(panel.grid = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        panel.margin = unit(0, "null"),
        # axis.text = element_blank(),
        axis.title = element_text(size = 10),
        axis.ticks = element_blank(),
        axis.line = element_blank(),
        #axis.ticks.length = unit(0, "null"),
        #axis.ticks.margin = unit(0, "null"),
        plot.title = element_text(size = 18),
        plot.background = element_blank(),
        plot.margin = unit(c(0, 0, 0, 0), "null"),
        plot.margin = rep(unit(0, "null"), 4),
        legend.key = element_blank()
      ) +
  scale_color_gradient2(name = "", midpoint = 0.5, mid = "grey80")

params.overall <-
    ggplot(tablea.param.freqs, aes(x = p)) +
      geom_histogram(binwidth = 0.1, origin = -0.05,
                     color = "grey50", fill = "grey50") +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0)) +
      labs(x = "Percent +", y = "Count", title = "Parameter tendencies") +
      theme(plot.title = element_text(size = 18),
            plot.margin = unit(c(0,3,0,0), "cm"),
            panel.border = element_blank(),
            axis.title = element_text(size = 10),
            panel.background = element_blank(),
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank())

png("../figures/parameter-tendencies.png", width = 6, height = 6, units = "in",
    res = 300)

grid.arrange(params.overall, indiv.params, ncol = 1, heights = c(0.4, 0.6))

dev.off()


## Notes:
## - discuss this in "a model of parametric change" section
## - put figure in supplementary material
## - use density estimate instead of/in addition to histogram?
## - unimplied parameters -> black border around their square
## - SVG version with tooltips for names

## Figure N: A description of the parameters in Table A.  The upper portion of
## the figure plots how often a given parameter assumes the value of + (as
## opposed to -; zeroes are not counted) in the dataset.  The data show that
## there is a bimodal tendency among the parameters: a parameter is more
## likely to be mostly + or mostly -, and less likely to be split 50-50 among
## these values.  The lower portion of the figure shows, for each individual
## parameter, how frequent the value + is.  The figure may be read by
## combining 10*vertical axis + horizontal axis.  Thus the upper-left square
## represents parameter 1, the upper right parameter 10, and the square below
## parameter 1 is parameter 11.  The size of the squares represents the
## proportion of languages which have a given parameter set to a non-zero
## value

## Figure N gives a description of the parameters in Table A.

## Why bimodal: Most langs are IE.  Thus, we expect them to be mostly the same
## for many parameters.  Also, the parameters that we use to distinguish
## within IE (and more broadly???) are mostly(???) existential parameters,
## which pick out one lang or a group.
