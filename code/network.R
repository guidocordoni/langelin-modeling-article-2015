library(igraph)

net <- unique(read.delim("../data/impls.txt", sep = ";", header = FALSE))

net <- subset(net, ! V2 %in% c("AGS", "AGO", "EM1", "DPN", "NTD", "OKP", "FVP", "ASF"))
net <- subset(net, ! V1 %in% c("AGS", "AGO", "EM1", "DPN", "NTD", "OKP", "FVP", "ASF"))

gr <- graph.edgelist(as.matrix(net[,c(2,1)]))

layout <- layout_with_fr(gr)

tiff("../figures/network.tif", wid = 6, hei = 6, res = 300, units = "in")

plot(gr, vertex.size = 9, vertex.label.cex = 0.5, edge.arrow.size = 0.25)

## plot(gr,
##      layout = layout.fruchterman.reingold(gr, area = 30 * vcount(gr)^2),
##      vertex.size = 10, vertex.label.cex = 0.5, edge.arrow.size = 0.25)

dev.off()

## big.nodes <- c("DGR", "NSD")
## big.indices <- which(V(gr)$name %in% big.nodes)
## big.edges <- incident(gr, big.indices)
## weights <- rep(1, ecount(gr))
## weights[big.edges] <- 2

## l <- layout.sugiyama(gr, hgap = 30, maxiter = 500)
## origvert <- c(rep(TRUE, vcount(gr)), rep(FALSE, nrow(l$layout.dummy)))
## realedge <- get.edgelist(l$extd_graph)[,2] <= vcount(gr)

## plot(l$extd_graph,
##      vertex.size = ifelse(origvert, 5, 0),
##      vertex.shape = ifelse(origvert, "square", "none"),
##      vertex.label = ifelse(origvert, V(gr)$name, ""),
##      edge.arrow.mode = ifelse(realedge, 2, 0),
##      vertex.size = 18, vertex.label.cex = 0.5, edge.arrow.size = 0.25)
