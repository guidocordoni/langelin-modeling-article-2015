library(dplyr)
library(grid)
library(gridExtra)
library(ggplot2)

source("data.R")

tablea <- read.tablea("../data/TableA.txt")

tablea.param.freqs <- tablea.long(tablea) %>%
    group_by(variable) %>%
    summarize(plus = sum(value == "+"),
              minus = sum(value == "-")) %>%
    mutate(p = plus / (plus + minus))

## Adapted from the waffle package <https://github.com/hrbrmstr/waffle>
cols <- 7
lvls <- length(levels(tablea.param.freqs$variable))
dat <- expand.grid(x = seq_len(ceiling(lvls / cols)),
                   y = cols:1)
dat$value <- c(tablea.param.freqs$p,
               rep(NA, nrow(dat) - nrow(tablea.param.freqs)))
indiv.params <- ggplot(dat, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "white", size = 2) +
  labs(x = "ones", y = "tens", title = "Individual parameter values") +
  scale_x_continuous(expand = c(0, 0), breaks = 1:10, labels = c(1:10)) +
  scale_y_continuous(expand = c(0, 0), breaks = 1:7, labels = 6:0) +
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
        plot.margin = rep(unit(0, "null"), 4)) +
  scale_fill_gradient2(name = "", midpoint = 0.5)

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
            panel.background = element_blank(),
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank())

png("../figures/parameter-tendencies.png", width = 6, height = 6, units = "in",
    res = 300)
grid.arrange(params.overall, indiv.params, ncol = 1, heights = c(0.4, 0.6))
dev.off()
